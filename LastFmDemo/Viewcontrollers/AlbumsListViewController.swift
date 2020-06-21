//
//  AlbumsListViewController.swift
//  DemoLastFm
//
//  Created by Surendra on 19/06/2020.
//  Copyright © 2020 Surendra. All rights reserved.
//

import UIKit

final class AlbumsListViewController: UIViewController, Storyboarded {
    
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var indicatorView: UIActivityIndicatorView!
    
    private var fetchingMore = false
    var viewModel: AlbumsListViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search".localizedString
    }
    
    deinit {
        debugPrint("deinit - AlbumsListViewController")
    }
    
    override func didReceiveMemoryWarning() {
        viewModel.receivedMemoryWarning()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryboardSegueIdentifiers.detail, let album = sender as? Album, let nextViewController = segue.destination as? AlbumDetailViewController {
            nextViewController.viewModel = AlbumDetailViewViewModel(withAlbum: album)
        }
    }
    
}


// MARK: - Table view data source, delegate
extension AlbumsListViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        if section == 0 {
            numberOfRows = viewModel.currentCount
        } else if section == 1 && fetchingMore {
            numberOfRows = 1
        }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StoryboardCellIdentifiers.albumTableViewCell, for: indexPath) as? AlbumTableViewCell else {
            fatalError()
        }
        if indexPath.section == 0, let album = viewModel.alubm(atIndex: indexPath.row) {
            cell.setupCell(using: AlbumTableViewCellViewModel(withAlbum: album))
        } else {
            cell.setupCell(using: .none)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: StoryboardSegueIdentifiers.detail, sender: (viewModel.alubm(atIndex: indexPath.row)))
    }
    

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        // Identifying user scrolling table view, and reached very last cell
        if offsetY > contentHeight - scrollView.frame.height {
            
            // Attempt to fetch more data to show (if available)
            if !fetchingMore && viewModel.hasMoreDataToShow {
                fetchingMore = true
                tableView.reloadSections(IndexSet(integer: 1), with: .none)
                viewModel.fetchAlbums()
            }
        }
    }
}

// MARK: - SearchBarDelegate
extension AlbumsListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let serachTerm = searchBar.text!.trimmingCharacters(in: .whitespaces)
        guard viewModel.isValidSearchTerm(serachTerm) else {
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.indicatorView.startAnimating()
            self.viewModel.searchTerm = serachTerm
        }
    }
}

// MARK: - AlbumsListViewModelDelegate
extension AlbumsListViewController: AlbumsListViewModelDelegate {
    
    func didHandleMemoryWarning() {
        self.fetchingMore = false
        self.tableView.reloadData()
    }
    
    func onFetchCompleted() {
        self.fetchingMore = false
        indicatorView.stopAnimating()
        self.tableView.reloadData()
    }
    
    func onFetchFailed(with error: Error) {
        self.fetchingMore = false
        indicatorView.stopAnimating()
        let cancel = UIAlertAction(title: "Cancel".localizedString, style: .cancel)
        let retry = UIAlertAction(title: "Retry".localizedString, style: .destructive) { [weak self] (_) in
            guard let self = self else {
                return
            }
            self.fetchingMore = true
            self.indicatorView.startAnimating()
            self.viewModel.fetchAlbums()
        }
        showAlert("Warning".localizedString, message: error.localizedDescription, actions: [cancel, retry])
    }
}

