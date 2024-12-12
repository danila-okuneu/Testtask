//
//  FontExtension.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

import UIKit

extension UIFont {

	static func nunitoSans(ofSize size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
		let fontDescriptor = UIFontDescriptor(fontAttributes: [
			.family: "Nunito Sans",
			.traits: [
				UIFontDescriptor.TraitKey.weight: weight
			]
		])

		return UIFont(descriptor: fontDescriptor, size: size)
	}
}
