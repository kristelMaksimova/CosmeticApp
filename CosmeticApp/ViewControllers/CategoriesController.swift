//
//  CategoriesController.swift
//  CosmeticApp
//
//  Created by Kristel Maximova on 28.01.2022.
//

import UIKit

enum Link: String {
    case nailPolish = "http://makeup-api.herokuapp.com/api/v1/products.json?product_type=nail_polish"
    case lipstick = "http://makeup-api.herokuapp.com/api/v1/products.json?product_type=lipstick"
    case mascara = "http://makeup-api.herokuapp.com/api/v1/products.json?product_type=mascara"
    case eyeshadow = "http://makeup-api.herokuapp.com/api/v1/products.json?product_type=eyeshadow"
    case blush = "http://makeup-api.herokuapp.com/api/v1/products.json?product_type=blush"
    case bronzer = "http://makeup-api.herokuapp.com/api/v1/products.json?product_type=bronzer"
}

enum UserAction: String, CaseIterable {
    case nailPolish = "NailPolish"
    case lipstick = "Lipstick"
    case mascara = "Mascara"
    case eyeshadow = "Eyeshadow"
    case blush = "Blush"
    case bronzer = "Bronzer"
}

class CategoriesController: UICollectionViewController {
    
    let userActions = UserAction.allCases
    
    var userChoice = Link.lipstick
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CaregoriesCell
        cell.userActionsLabel.text = userActions[indexPath.item].rawValue
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]
        switch userAction {
        case .nailPolish:
            userChoice = Link.nailPolish
            performSegue(withIdentifier: "productsShow", sender: nil)
        case .lipstick:
            userChoice = Link.lipstick
            performSegue(withIdentifier: "productsShow", sender: nil)
        case .mascara:
            userChoice = Link.mascara
            performSegue(withIdentifier: "productsShow", sender: nil)
        case .eyeshadow:
            userChoice = Link.eyeshadow
            performSegue(withIdentifier: "productsShow", sender: nil)
        case .blush:
            userChoice = Link.blush
            performSegue(withIdentifier: "productsShow", sender: nil)
        case .bronzer:
            userChoice = Link.bronzer
            performSegue(withIdentifier: "productsShow", sender: nil)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if userChoice == Link.nailPolish {
            guard let productsVC = segue.destination as? ProductsController else { return }
            productsVC.fetchProducts(product: Link.nailPolish)
        }
        else if userChoice == Link.lipstick {
            guard let productsVC = segue.destination as? ProductsController else { return }
            productsVC.fetchProducts(product: Link.lipstick)
        }
        else if userChoice == Link.mascara {
            guard let productsVC = segue.destination as? ProductsController else { return }
            productsVC.fetchProducts(product: Link.mascara)
        }
        else if userChoice == Link.eyeshadow {
            guard let productsVC = segue.destination as? ProductsController else { return }
            productsVC.fetchProducts(product: Link.eyeshadow)
        }
        else if userChoice == Link.blush {
            guard let productsVC = segue.destination as? ProductsController else { return }
            productsVC.fetchProducts(product: Link.blush)
        }
        else {
            guard let productsVC = segue.destination as? ProductsController else { return }
            productsVC.fetchProducts(product: Link.bronzer)
        }
    }
    
    // MARK: - Private Methods
    private func successAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Success",
                message: "You can see the results in the Debug aria",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
    private func failedAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Failed",
                message: "You can see error in the Debug aria",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
}

//MARK: - Networking
extension CategoriesController {
    private func nailPolishButtonPressed() {
        buttonPressed(product: Link.nailPolish)
    }

    private func lipstickButtonPressed() {
        buttonPressed(product: Link.lipstick)
    }
    
    private func mascaraButtonPressed() {
        buttonPressed(product: Link.mascara)
    }
    
    private func eyeshadowButtonPressed() {
        buttonPressed(product: Link.eyeshadow)
    }
    
    private func blushButtonPressed() {
        buttonPressed(product: Link.blush)
    }
    
    private func bronzerButtonPressed() {
        buttonPressed(product: Link.bronzer)
    }
    
    private func buttonPressed(product: Link) {
        guard let url = URL(string: product.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let products = try JSONDecoder().decode(Cosmetics.self, from: data)
                self.successAlert()
                print(products)
            } catch {
                self.failedAlert()
                print(error.localizedDescription)
            }
        }.resume()
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension CategoriesController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 150)
    }
}
