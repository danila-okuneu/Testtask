//
//  SubviewsExtension.swift
//  Testtask
//
//  Created by Danila Okuneu on 16.12.24.
//

import UIKit

extension UIView {
	
	func addSubviews(_ views: UIView...) {
		views.forEach { view in
			self.addSubview(view)
		}
	}
}

extension UIStackView {
	
	func addArrangedSubviews(_ views: UIView...) {
		views.forEach { view in
			self.addArrangedSubview(view)
		}
	}
}


