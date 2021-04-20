//
//  HomeViewController.swift
//  W5-Project1-Gumi
//
//  Created by Thành Nguyên on 12/04/2021.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var itemCollectionView: UICollectionView!
    
    lazy var viewModel = HomeViewModel(delegate: self)
    
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        title = "Fruits"
        
        itemCollectionView.register(ItemCollectionViewCell.nib, forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        if let layout = itemCollectionView.collectionViewLayout as? CustomCollectionViewFlowLayout {
            layout.delegate = self
        }
        
        searchBar.delegate = self
        searchBar.placeholder = "Search your fruits"
        let searchButton = UIBarButtonItem.init(image: UIImage.init(systemName: "magnifyingglass"), style: .done, target: self, action: #selector(self.searchTouched(sender: )))
        searchButton.tag = 0 // 0: touch to turn to search mode.    1: Touch to cancel searchmode
        navigationItem.rightBarButtonItem = searchButton
        navigationController?.navigationBar.tintColor = UIColor(named: "label")
        
        self.itemCollectionView.keyboardDismissMode = .onDrag
        
        viewModel.showOriginalList()
    }
    
    @objc func searchTouched(sender: UIBarButtonItem) {
        if sender.tag == 0 {
            sender.image = nil
            sender.title = "Cancel"
            sender.tag = 1
            navigationItem.titleView = searchBar
            searchBar.sizeToFit()
        } else {
            viewModel.showOriginalList()
            itemCollectionView.reloadData()
            sender.image = UIImage.init(systemName: "magnifyingglass")
            sender.title = nil
            sender.tag = 0
            searchBar.text = ""
            let titleLabel = UILabel()
            titleLabel.text = self.title
            titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            navigationItem.titleView = titleLabel
        }
    }
}

extension HomeViewController: HomeViewModelEvents{
    func reloadCollection() {
        itemCollectionView.reloadData()
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailsViewController(nibName: "DetailsViewController", bundle: nil)
        vc.bindData(item: viewModel.listOfItem[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.listOfItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as! ItemCollectionViewCell
        cell.setupView(item: viewModel.listOfItem[indexPath.row])
        cell.delegate = self
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 45) / 2, height: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}

extension HomeViewController: ItemCollectionViewCellDelegate {
    func itemCollectionViewCell(_ itemCollectionViewCell: ItemCollectionViewCell, likeAction: Bool) {
        let index = itemCollectionView.indexPath(for: itemCollectionViewCell)
        viewModel.changeLoveStateAt(index?.row)
    }
}

extension HomeViewController: CustomCollectionViewLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
       let width = (collectionView.frame.width - 45) / 2
        return (viewModel.listOfItem[indexPath.row].image.size.height / viewModel.listOfItem[indexPath.row].image.size.width) * width + 122
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let key = searchBar.text ?? ""
        viewModel.search(keyWord: key)
    }
}

