
import Foundation

struct University: Codable {
//    var country: String?
//    var name: String?
//    var countryCode: String?
//    var state: String?
//    var domains: [String]?
    
    //TODO: - i can map all property but as of now not using any other property except webPages so just mapping one field
    var webPages: [String]?
    
    enum CodingKeys: String, CodingKey {
//        case country
//        case name
//        case countryCode = "alpha_two_code"
//        case state = "state-province"
//        case domains
        case webPages = "web_pages"
    }
}
