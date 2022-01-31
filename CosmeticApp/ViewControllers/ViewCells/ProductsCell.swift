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
        
        DispatchQueue.global().async {
            guard let stringURL = products.image_link else { return }
            guard let url = URL(string: stringURL) else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.productsImage.image = UIImage(data: imageData)
            }
        }
    }
}
