//
//  DetailsViewController.swift
//  W5-Project1-Gumi
//
//  Created by Thành Nguyên on 12/04/2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet var startsRatingButton: [UIButton]!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountView: UIView!
    @IBOutlet weak var nutritionCollectionView: UICollectionView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var cartView: UIView!
    
    
    var item: Item?
    var amount = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        navigationController?.navigationBar.tintColor = .black
        
        priceView.layer.cornerRadius = priceView.frame.height / 2
        priceView.layer.borderWidth = 2
        priceView.layer.borderColor = UIColor.white.cgColor
        priceView.layer.shadowColor = UIColor.black.cgColor
        priceView.layer.shadowRadius = 20
        priceView.layer.shadowOffset = CGSize(width: 8, height: 8)
        priceView.layer.shadowOpacity = 0.2
        
        cartView.layer.cornerRadius = cartView.frame.height / 2
        cartView.layer.borderWidth = 2
        cartView.layer.borderColor = UIColor.white.cgColor
        
        amountView.layer.cornerRadius = amountView.frame.height / 2
        amountView.layer.shadowColor = UIColor.black.cgColor
        amountView.layer.shadowRadius = 20
        amountView.layer.shadowOffset = CGSize(width: 8, height: 8)
        amountView.layer.shadowOpacity = 0.2
        
        nutritionCollectionView.delegate = self
        nutritionCollectionView.dataSource = self
        nutritionCollectionView.register(NutritionCollectionViewCell.nib, forCellWithReuseIdentifier: NutritionCollectionViewCell.identifier)
        nutritionCollectionView.reloadData()
        
        thumbnailImageView.image = item?.image
        thumbnailImageView.layer.cornerRadius = priceView.layer.cornerRadius
        thumbnailImageView.layer.borderWidth = 3
        thumbnailImageView.layer.borderColor = UIColor.white.cgColor
        
        nameLabel.text = item?.name
        ratingLabel.text = "\(item?.rating ?? 0.0)"
        for i in 0..<5 {
            startsRatingButton[i].tintColor = i < Int((item?.rating! ?? 0) / 2) ? UIColor(named: "orange")! : UIColor.systemGray2
            startsRatingButton[i].isSelected = false
        }
        descriptionTextView.text = item?.description
        amountLabel.text = "\(amount)"
        priceLabel.text = "$\(item?.price ?? 0.0)"
        
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = true
        descriptionTextView.sizeToFit()
        descriptionTextView.isScrollEnabled = false
        
        let maskPathRemoveButton = UIBezierPath(roundedRect: removeButton.bounds, byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: 4, height: 4))
        let maskLayerRemoveButton = CAShapeLayer()
        maskLayerRemoveButton.path = maskPathRemoveButton.cgPath
        removeButton.layer.cornerRadius = removeButton.frame.height / 2
        removeButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        removeButton.layer.mask = maskLayerRemoveButton
        
        let maskPathAddButton = UIBezierPath(roundedRect: addButton.bounds, byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: 4, height: 4))
        let maskLayerAddButton = CAShapeLayer()
        maskLayerAddButton.path = maskPathAddButton.cgPath
        addButton.layer.cornerRadius = addButton.frame.height / 2
        addButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        addButton.layer.mask = maskLayerAddButton
    }
    
    func reloadAmount() {
        removeButton.isSelected = amount > 0
        priceLabel.text = "$\((item?.price ?? 1) * Double(amount))"
        amountLabel.text = "\(amount >= 0 ? amount : 0)"
    }
    
    func bindData(item: Item) {
        self.item = item
        
        self.title = item.name
    }
    
    @IBAction func removeButtonTouched(_ sender: Any) {
        amount -= amount > 0 ? 1 : 0
        reloadAmount()
    }
    
    @IBAction func addButtonTouched(_ sender: Any) {
        amount += 1
        reloadAmount()
    }
}

extension DetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(item?.nutrition?.count ?? 0)
        return item?.nutrition?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NutritionCollectionViewCell.identifier, for: indexPath) as! NutritionCollectionViewCell
        cell.bindData(nutri: item?.nutrition?[indexPath.row] ?? "")
        return cell
    }
}

extension DetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = item?.nutrition?[indexPath.row].size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .regular)])
        return CGSize(width: (size?.width ?? 100) + 50, height: 40)
    }
}
