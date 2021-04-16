//
//  NutritionCollectionViewCell.swift
//  W5-Project1-Gumi
//
//  Created by Thành Nguyên on 12/04/2021.
//

import UIKit

class NutritionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nutriLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = (frame.height - 4) / 2
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = UIColor(named: "orange")
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.white.cgColor
        layer.shadowColor = UIColor(named: "label")?.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
    }
    
    func bindData(nutri: String) {
        nutriLabel.text = nutri
        nutriLabel.sizeToFit()
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib : UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
