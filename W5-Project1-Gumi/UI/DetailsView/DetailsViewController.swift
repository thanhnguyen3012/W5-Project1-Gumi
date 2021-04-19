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
    
    lazy var viewModel = DetailsViewModel(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        navigationController?.navigationBar.tintColor = UIColor(named: "label")
        
        priceView.layer.cornerRadius = priceView.frame.height / 2
        priceView.layer.borderWidth = 2
        priceView.layer.borderColor = UIColor(named: "dark_label")?.cgColor
        priceView.layer.shadowColor = UIColor(named: "label")?.cgColor
        priceView.layer.shadowRadius = 20
        priceView.layer.shadowOffset = CGSize(width: 8, height: 8)
        priceView.layer.shadowOpacity = 0.2
        
        cartView.layer.cornerRadius = cartView.frame.height / 2
        cartView.layer.borderWidth = 2
        cartView.layer.borderColor = UIColor.white.cgColor
        
        amountView.layer.cornerRadius = amountView.frame.height / 2
        amountView.layer.shadowColor = UIColor(named: "label")?.cgColor
        amountView.layer.shadowRadius = 20
        amountView.layer.shadowOffset = CGSize(width: 8, height: 8)
        amountView.layer.shadowOpacity = 0.2
        
        nutritionCollectionView.delegate = self
        nutritionCollectionView.dataSource = self
        nutritionCollectionView.register(NutritionCollectionViewCell.nib, forCellWithReuseIdentifier: NutritionCollectionViewCell.identifier)
        nutritionCollectionView.reloadData()
        
        thumbnailImageView.image = viewModel.item?.image
        thumbnailImageView.layer.cornerRadius = priceView.layer.cornerRadius
        thumbnailImageView.layer.borderWidth = 3
        thumbnailImageView.layer.borderColor = UIColor.white.cgColor
        
        nameLabel.text = viewModel.item?.name
        ratingLabel.text = "\(viewModel.item?.rating ?? 0.0)"
        for i in 0..<5 {
            startsRatingButton[i].tintColor = i < Int(viewModel.item?.rating ?? 0 / 2) ? UIColor(named: "orange")! : UIColor.systemGray2
            startsRatingButton[i].isSelected = false
        }
        descriptionTextView.text = viewModel.item?.description
        amountLabel.text = "\(viewModel.amount)"
        priceLabel.text = "$\(viewModel.item?.price ?? 0.0)"
        
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
    
    
    func bindData(item: Item) {
        viewModel.item = item
        self.title = item.name
    }
    
    @IBAction func removeButtonTouched(_ sender: Any) {
        viewModel.removeAnItem()
    }
    
    @IBAction func addButtonTouched(_ sender: Any) {
        viewModel.addAnButton()
    }
}

extension DetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.item?.nutrition.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NutritionCollectionViewCell.identifier, for: indexPath) as! NutritionCollectionViewCell
        cell.bindData(nutri: viewModel.item?.nutrition[indexPath.row] ?? "")
        return cell
    }
}

extension DetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = viewModel.item?.nutrition[indexPath.row].size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .regular)])
        return CGSize(width: (size?.width ?? 100) + 50, height: 40)
    }
}

extension DetailsViewController: DetailsViewModelEvents {
    func reloadAmount() {
        removeButton.isSelected = viewModel.amount > 0
        priceLabel.text = "$\((viewModel.item?.price ?? 1) * Double(viewModel.amount))"
        amountLabel.text = "\(viewModel.amount >= 0 ? viewModel.amount : 0)"
    }
}
