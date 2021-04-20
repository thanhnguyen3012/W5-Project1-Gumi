//
//  ItemCollectionViewCell.swift
//  W5-Project1-Gumi
//
//  Created by Thành Nguyên on 12/04/2021.
//

import UIKit

protocol ItemCollectionViewCellDelegate {
    func itemCollectionViewCell(_ itemCollectionViewCell: ItemCollectionViewCell, likeAction: Bool)
}

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var rawPriceLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    
    var delegate: ItemCollectionViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 10
        
        layer.cornerRadius = 10
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.shadowOpacity = 0.1
        
        image.clipsToBounds = true
        
        addToCartButton.layer.cornerRadius = 14
        addToCartButton.layer.shadowColor = UIColor(named: "main_green")!.cgColor
        addToCartButton.layer.shadowOpacity = 0.3
        addToCartButton.layer.shadowRadius = 6
        addToCartButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        likeButton.layer.cornerRadius = 14
        likeButton.backgroundColor = UIColor(white: 0, alpha: 0.3)
    }
    
    func setupView(item: Item) {
        image.image = item.image
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        likeButton.isSelected = item.isLoved
        nameLabel.text = item.name
        priceLabel.text = "$\(item.price)"
        priceLabel.sizeToFit()
        rawPriceLabel.text = "$\(NSString(format: "%.2f", item.price * 1.1))"
        rawPriceLabel.sizeToFit()
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib : UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    @IBAction func likeButtonTouched(_ sender: Any) {
        likeButton.isSelected = !likeButton.isSelected
        delegate?.itemCollectionViewCell(self, likeAction: !likeButton.isSelected)
    }
}
