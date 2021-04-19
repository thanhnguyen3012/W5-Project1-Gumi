//
//  DetailsViewModel.swift
//  W5-Project1-Gumi
//
//  Created by Thành Nguyên on 19/04/2021.
//

import UIKit

protocol DetailsViewModelEvents: class {
    func reloadAmount()
}

class DetailsViewModel {
    weak var delegate: DetailsViewModelEvents?
    weak var item: Item?
    var amount : Int
    
    init(delegate: DetailsViewModelEvents) {
        amount = 1
        self.delegate = delegate
    }
    
    func removeAnItem() {
        amount -= amount > 0 ? 1 : 0
        delegate?.reloadAmount()
    }
    
    func addAnButton() {
        amount += 1
        delegate?.reloadAmount()
    }
}
