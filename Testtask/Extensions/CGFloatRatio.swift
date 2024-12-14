//
//  CGFloatRatio.swift
//  Testtask
//
//  Created by Danila Okuneu on 14.12.24.
//

import UIKit

extension CGFloat {
	
	static let ratio: CGFloat = {
		
		guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return 1.0 }
		   guard let window = windowScene.windows.first else { return 1.0 }
			   
		   return window.bounds.width / 360
	   }()
	
}
