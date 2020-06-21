//
//  AlbumsListViewModelProtocol.swift
//  DemoLastFm
//
//  Created by Surendra on 18/06/2020.
//  Copyright © 2020 Surendra. All rights reserved.
//

import Foundation

protocol AlbumsListViewModelDelegate: class {
    /// Inform client on fetch complete
    func onFetchCompleted()
    
    /// Inform client about error when error occurred while fetching data
    /// - Parameter error: Error
    func onFetchFailed(with error: Error)
    
    
    /// Inform client that action has been taken on memory warning
    func didHandleMemoryWarning()
}

protocol AlbumsListViewModelProtocol {
    
    /// Cached number of items
    var currentCount: Int {get}
    
    /// Search term
    var searchTerm: String {get set}
    
    /// Indicating client to have more data to show
    var hasMoreDataToShow: Bool {get}
    
    /// Responsibe to get album at given index if available otherwise return nil
    /// - Parameter index: index
    func alubm(atIndex index: Int) -> Album?
    
    /// Fetch albums
    func fetchAlbums()
    
    /// Handling memory warning
    func receivedMemoryWarning()
    
    
    /// Validate search term If valid return true otherwise false
    /// - Parameter searchTerm: search term
    func isValidSearchTerm(_ searchTerm: String) -> Bool
}

final class AlbumsListViewModel {
    
    private var albumList = [Album]()
    private var currentPage = 1
    private var total = 0
    private var isNewSearch = false
    
    var searchTerm: String = "" {
        didSet {
            isNewSearch = true
            currentPage = 1
            fetchAlbums()
        }
    }
    
    private let dataService: DataServiceProviding
    private weak var delegate: AlbumsListViewModelDelegate?
    
    init(withDelegate delegate: AlbumsListViewModelDelegate,  dataService: DataServiceProviding = DataServiceProvider()) {
        self.dataService = dataService
        self.delegate = delegate
    }
    
}

extension AlbumsListViewModel: AlbumsListViewModelProtocol {
    
    func isValidSearchTerm(_ searchTerm: String) -> Bool {
        let serachTerm = searchTerm.trimmingCharacters(in: .whitespaces)
        guard serachTerm.count >= 3 else {
            return false
        }
        return true
    }
    
    
    var hasMoreDataToShow: Bool {
        return currentCount < total
    }
    
    var currentCount: Int {
        return albumList.count
    }
    
    func receivedMemoryWarning() {
        albumList.removeAll()
        currentPage = 1
        delegate?.didHandleMemoryWarning()
    }
    
    func alubm(atIndex index: Int) -> Album? {
        return albumList.count > index ? albumList[index] : nil
    }
    
    func fetchAlbums() {
        dataService.searchForAlbum(RequestQueryBuilder.searchAlbum(searchTerm: searchTerm, page: currentPage)) { [weak self] (result) in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    guard let self = self else {
                        return
                    }
                    if self.isNewSearch {
                        self.albumList.removeAll()
                        self.isNewSearch = false
                    }
                    self.albumList.append(contentsOf: result.albums)
                    self.delegate?.onFetchCompleted()
                    self.currentPage += 1
                    self.total = result.totalSearchResult
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.delegate?.onFetchFailed(with: error)
                }
            }
        }
    }
    
}

