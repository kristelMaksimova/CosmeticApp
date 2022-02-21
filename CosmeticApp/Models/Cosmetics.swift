//
//  Cosmetics.swift
//  CosmeticApp
//
//  Created by Kristel Maximova on 29.01.2022.
//

struct Cosmetics: Decodable {
    let brand: String?
    let name: String?
    let price: String?
    let image_link: String?
    
    init(cosmeticsData: [String: Any]) {
        brand = cosmeticsData["brand"] as? String
        name = cosmeticsData["name"] as? String
        price = cosmeticsData["price"] as? String
        image_link = cosmeticsData["image_link"] as? String
    }
    
    static func getCosmetics(from value: Any) -> [Cosmetics] {
        guard let cosmeticsData = value as? [[String: Any]] else { return [] }
        return cosmeticsData.compactMap { Cosmetics(cosmeticsData: $0) }
    }
}
struct WebsiteDescription: Decodable {
    let cosmetics: [Cosmetics]?
    let websiteDescription: String?
    let websiteName: String?
}

enum UserAction: String, CaseIterable {
    case nailPolish = "NailPolish"
    case lipstick = "Lipstick"
    case mascara = "Mascara"
    case eyeshadow = "Eyeshadow"
    case blush = "Blush"
    case bronzer = "Bronzer"
}
