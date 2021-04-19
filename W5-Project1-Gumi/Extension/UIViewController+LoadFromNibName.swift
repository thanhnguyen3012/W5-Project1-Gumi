//
//  UIViewControllerExtension.swift
//  W5-Project1-Gumi
//
//  Created by Thành Nguyên on 12/04/2021.
//

import UIKit

extension UIViewController {
    class func loadFromNibNamed(nibNamed: String, bundle : Bundle? = nil) -> UIViewController? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
        ).instantiate(withOwner: nil, options: nil)[0] as? UIViewController
    }
}
