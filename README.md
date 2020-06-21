# LastFmDemo

Allows user to search album, search result displayed in list. Application shows detail information about album by selecting an album from list.

Search album api supports **Paging**, so application took advantage of paging (fetching and displaying data per page)

## High Level Architecture (MVVM)

![](https://github.com/SurendraK11/LastFmDemo/blob/master/HighLevelArchitecture.png "High Level Application Architecture")

## Installation

Applicaiton is built on **Swift 5.0**, minimum deployment target **iOS 13.0**, and using **Xcode 11.5**

Clone the repository, open LastFmDemo.xcodeproj and wait for **Swift Package** to configure dependencies (Swift Package Dependencies)

### Third party libraries

Third party libraries are managed by Swift Package Dependencies 

Kingfisher - it bind with UIImageView, which facilitate to download image and show asynchronously.


### Class definition 

### User Interface

User interface is built on Story board - Main.storyboard

AlbumsListViewController - All user to search for album, it shows search result 

AlbumDetailViewController - Show detail infomation of selected album 

### View Models

Every view controller has its own view model, which is responsible to interact with service layer, managing data model (update, delete etc), business logic. 

Benefits of view model are level of code separation, responsibility, testability, code readability etc

AlbumsListViewModelProtocol for AlbumsListViewController

AlbumDetailViewViewModelProtocol for AlbumDetailViewController

AlbumTableViewCellViewModelProtocal for AlbumTableViewCell

### Service layer
DataServiceProviding has a service apis e.g. allows to search for album

### Request builder 
RequestQueryBuilderProtocol is responsible to create url, used to interact with network apis using network service. RequestQueryBuilderProtocol is important class, which encapsulate implementation of creating url for defined endpoints


### Network layer
HttpClientProtocol which process network request, using URLSession

### CustomErrors - basic custom errors defined as below, based on requirements new error can be added
urlError

apiResponseError

dataNotFoundError

dataParsingError

unexpectedData


### Testing 

At the moment application covers 

  - testing of search album and paging in AlbumsListViewModelTests. 

  - testing of RequestQueryBuilder in RequestQueryBuilderTest

Created mocks for DataServiceProviding and AlbumsListViewModelDelegate helped in testing. 

