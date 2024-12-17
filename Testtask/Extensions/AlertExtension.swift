//
//  AlertExtension.swift
//  Testtask
//
//  Created by Danila Okuneu on 16.12.24.
//

import UIKit


extension UIViewController {
	func showErrorAlert(message: String, title: String = "Error") {
		let alertController = UIAlertController(
			title: title,
			message: message,
			preferredStyle: .alert
		)
		alertController.editButtonItem.tintColor = .systemBlue
		
		let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
		alertController.addAction(okAction)
		
		self.present(alertController, animated: true)
	}
}
