# LastFmDemo

## High Level Architecture (MVVM)

![](https://github.com/SurendraK11/LastFmDemo/blob/master/HighLevelArchitecture.png "High Level Application Architecture")

## Installation

Clone repository and run

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

### Service layer
DataServiceProviding has a service apis e.g. allows to search for album

### Network layer
HttpClientProtocol which process network request, using URLSession

### CustomErrors - basic custom errors defined as below, based on requirements new error can be added
urlError

apiResponseError

dataNotFoundError

dataParsingError

unexpectedData
