//
//  NailPolishCell.swift
//  CosmeticApp
//
//  Created by Kristi on 29.01.2022.
//

import UIKit

class ProductsCell: UITableViewCell {

    //MARK: - IB Outlets
    @IBOutlet var productsImage: UIImageView!
    @IBOutlet var productsBrand: UILabel!
    @IBOutlet var productsName: UILabel!
    @IBOutlet var productsPrice: UILabel!
    
    // MARK: - Pablic methods
    func configure(with products: Cosmetics) {
        productsBrand.text = products.brand
        productsName.text = products.name
        productsPrice.text = "$ \(products.price ?? "")"
        
        NetworkManager.shared.fetchImage(from: products.image_link) { result in
            switch result {
            case .success(let imageData):
                self.productsImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
