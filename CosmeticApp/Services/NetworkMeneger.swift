//
//  NetworkMeneger.swift
//  CosmeticApp
//
//  Created by Kristi on 21.02.2022.
//

import Foundation
import Alamofire

enum Link: String {
    case nailPolish = "http://makeup-api.herokuapp.com/api/v1/products.json?product_type=nail_polish"
    case lipstick = "http://makeup-api.herokuapp.com/api/v1/products.json?product_type=lipstick"
    case mascara = "http://makeup-api.herokuapp.com/api/v1/products.json?product_type=mascara"
    case eyeshadow = "http://makeup-api.herokuapp.com/api/v1/products.json?product_type=eyeshadow"
    case blush = "http://makeup-api.herokuapp.com/api/v1/products.json?product_type=blush"
    case bronzer = "http://makeup-api.herokuapp.com/api/v1/products.json?product_type=bronzer"
}

enum NetworkError: Error {
    case decodingError
    case invalidURL
    case noData
}

class NetworkManager {
    
    static let shared = NetworkManager()

    func fetchDataWithAlamofire(_ url: String, completion: @escaping(Result<[Cosmetics], NetworkError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let cosmetics = Cosmetics.getCosmetics(from: value)
                    completion(.success(cosmetics))
                case .failure:
                    completion(.failure(.decodingError))
                }
            }
    }
    func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    private init() {}
}

