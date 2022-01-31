//
//  Cosmetics.swift
//  CosmeticApp
//
//  Created by Kristel Maximova on 29.01.2022.
//

import Foundation

struct Cosmetics: Decodable {
    let brand: String?
    let name: String?
    let price: String?
    let image_link: String?
}
struct WebsiteDescription: Decodable {
    let cosmetics: [Cosmetics]?
    let websiteDescription: String?
    let websiteName: String?
}

