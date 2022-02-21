//
//  CategoriesController.swift
//  CosmeticApp
//
//  Created by Kristel Maximova on 28.01.2022.
//

import UIKit

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
}
    
//MARK: - UICollectionViewDelegateFlowLayout

extension CategoriesController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 150)
    }
}
