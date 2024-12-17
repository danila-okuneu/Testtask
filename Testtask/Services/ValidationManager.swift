//
//  ValidationManager.swift
//  Testtask
//
//  Created by Danila Okuneu on 16.12.24.
//

import UIKit
import Foundation

struct ValidationManager {
	
	static func validateName(_ text: String) -> String? {
		
		if text.count < 2 {
			return "Too short name"
		}
		
		if text.count > 60 {
			return "Too long name"
		}
		
		return nil
	}
	
	static func validateEmail(_ text: String) -> String? {
		
		let rfc2822Regex = "[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?"
		let predicate = NSPredicate(format: "SELF MATCHES %@", rfc2822Regex)
		guard predicate.evaluate(with: text) else { return "Invalid email format" }
		
		return nil
	}
	
	static func validateNumber(_ text: String) -> String? {
		
		if !text.hasPrefix("+380") {
			return "Invalid number prefix (+380)"
		}
		
		if text.dropFirst(4).count != 9 {
			return "Invalid phone number"
		}
		
		return nil
		
	}
	
	
	static func validatePhoto(_ image: UIImage) -> String? {

		
		return nil
	}
	
	static func validateField(with text: String, ofType type: TextFieldType) -> String? {
		
		var message: String?
		
		if text == "" {
			return "Required field"
		}
		
		switch type {
		case .name:
			message = validateName(text)
		case .email:
			message = validateEmail(text)
		case .phone:
			message = validateNumber(text)
		case .photo:
			return nil
		}
		return message
	}
	
	
	
}
