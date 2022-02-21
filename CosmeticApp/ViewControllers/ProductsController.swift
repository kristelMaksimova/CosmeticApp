//
//  ProductsController.swift
//  CosmeticApp
//
//  Created by Kristel Maximova on 29.01.2022.
//

import UIKit

class ProductsController: UITableViewController {
    
    @IBOutlet var activityIndicatorLarge: UIActivityIndicatorView!
    
    //MARK: - Public properties
    private var products: [Cosmetics] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 150
        activityIndicatorLarge.startAnimating()
        activityIndicatorLarge.hidesWhenStopped = true
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath) as! ProductsCell
        let product = products[indexPath.row]
        
        cell.configure(with: product)
        
        return cell
    }
    
}

// MARK: - Networking
extension ProductsController {
    func fetchProducts(product: Link) {
        NetworkManager.shared.fetchDataWithAlamofire(product.rawValue) { result in
            switch result {
            case .success(let eyeshadow):
                self.products = eyeshadow
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

