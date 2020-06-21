
import Foundation


struct AlbumSearchResultResponse: Codable {
    let results: Results
}


struct Results: Codable {
    
    let totalResults: String
    let albummatches: Albummatches

    enum CodingKeys: String, CodingKey {
        case totalResults = "opensearch:totalResults"
        case albummatches
    }
}


struct Albummatches: Codable {
    let album: [Album]
}


