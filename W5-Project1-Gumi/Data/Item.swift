//
//  CommonModels.swift
//  W5-Project1-Gumi
//
//  Created by Thành Nguyên on 12/04/2021.
//

import UIKit

class Item {
    var image: UIImage
    var name: String
    var price: Double
    var rating: Double
    var isLoved = false
    var description: String
    var nutrition = [String]()
    
    init(image: UIImage, name: String, price: Double, rating: Double, description: String, nutrition: [String]) {
        self.image = image
        self.name = name
        self.price = price
        self.rating = rating
        self.description = description
        self.nutrition = nutrition
    }
}
