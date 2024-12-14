//
//  CustomTextField.swift
//  Testtask
//
//  Created by Danila Okuneu on 13.12.24.
//

import UIKit


final class SignUpTextField: SupportedView {
	
	
	let textField: UITextField = {
		let field = UITextField()
		field.textColor = .primaryText
		return field
	}()
	
	// MARK: - Initializers
	init(placeholder: String, hint: String = "") {
		super.init(title: placeholder, hint: hint)
		
		setupViews()
		setupGesture()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Layout
	private func setupViews() {
		
		addSubview(primaryView)
		addSubview(supportingLabel)
		
		primaryView.addSubview(textField)
		primaryView.addSubview(titleLabel)
		
		textField.delegate = self
		
		
		setupConstraints()
	}
	
	private func setupConstraints() {
		
		textField.snp.makeConstraints { make in
			make.left.equalToSuperview().offset(Constants.padding)
			make.bottom.equalToSuperview().offset(-Constants.fieldBottomOffset)
		}
	}

	// MARK: - Methods
	func movePlaceholder() {
		
		
		let scale = Constants.placeholderRatio
		let translationX = -titleLabel.bounds.width * (1 - scale) / 2
		let translationY = -self.primaryView.bounds.height / 2 + titleLabel.bounds.height / 2 + Constants.placeholderTopOffset
		
		
		UIView.animate(withDuration: 0.3) {
			self.titleLabel.transform = CGAffineTransform(scale, 0, 0, scale, translationX, translationY)
		}
	}
	
	func resetPlaceholder() {
		UIView.animate(withDuration: 0.3) {
			self.titleLabel.transform = .identity
		}
	}
	
	private func setupGesture() {
		
		let gesture = UITapGestureRecognizer(target: self, action: #selector(gestureTarget))
		
		primaryView.addGestureRecognizer(gesture)
		
	}
	
	@objc private func gestureTarget() {
		textField.becomeFirstResponder()
		
	}
	
}

// MARK: - Constants
extension SignUpTextField {
	
	
	// xO
	// O - offset
	// x - Top, Left, Bottom, Right
	private struct Constants {
		
		private static let ratio = CGFloat.ratio
		
		static let padding = 16 * ratio
		
		static let placeholderRatio = 12 / 16 * ratio
		static let placeholderTopOffset = 8 * ratio
		
		static let fieldBottomOffset = 8 * ratio
		
	}
	
}

// MARK: - TextField Delegate
extension SignUpTextField: UITextFieldDelegate {
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
		movePlaceholder()
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		
		if textField.text!.isEmpty {
			resetPlaceholder()
		}
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.endEditing(true)
		return false
	}
	
	
}
