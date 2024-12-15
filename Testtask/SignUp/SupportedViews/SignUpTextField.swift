//
//  SignUpTextField.swift
//  Testtask
//
//  Created by Danila Okuneu on 13.12.24.
//

import UIKit


final class SignUpTextField: SupportedView {
	
	
	let type: TextFieldType
	
	private let textField: UITextField = {
		let field = UITextField()
		field.textColor = .primaryText
		return field
	}()
	
	// MARK: - Initializers
	init(placeholder: String, supporting: String = "", ofType type: TextFieldType) {
		self.type = type
		super.init(title: placeholder, supporting: supporting)
		
		setupViews()
		configure()
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
	
	private func setupGesture() {
		
		let gesture = UITapGestureRecognizer(target: self, action: #selector(gestureTarget))
		
		primaryView.addGestureRecognizer(gesture)
		
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
	
	func showError(with description: String?) {
		UIView.animate(withDuration: 0.3) {
			self.titleLabel.textColor = .fieldWrong
			self.supportingLabel.textColor = .fieldWrong
			self.primaryView.layer.borderColor = UIColor.fieldWrong.cgColor
		}
		if let description {
			supportingLabel.text = description
		}
	}
	
	func showActiveAppearance() {
		UIView.animate(withDuration: 0.3) {
			self.titleLabel.textColor = .fieldTintNormal
			self.supportingLabel.textColor = .fieldHint
			self.primaryView.layer.borderColor = UIColor.fieldActive.cgColor
		}
		resetSupporting()
	}
	
	func resetAppearance() {
		UIView.animate(withDuration: 0.3) {
			self.titleLabel.textColor = .secondaryTitle
			self.supportingLabel.textColor = .secondaryTitle
			self.primaryView.layer.borderColor = UIColor.fieldBorderNormal.cgColor
		}
		resetSupporting()
	}
	
	private func resetSupporting() {
		if supportingLabel.text != supporting {
			UIView.transition(with: supportingLabel, duration: 0.1, options: .transitionCrossDissolve) {
				self.supportingLabel.text = self.supporting
			}
		}
	}
	
	private func configure() {
		switch type {
		case .name:
			textField.textContentType = .name
			textField.autocapitalizationType = .words
		case .email:
			textField.textContentType = .emailAddress
			textField.keyboardType = .emailAddress
			textField.autocorrectionType = .no
			textField.autocapitalizationType = .none
		case .phone:
			textField.keyboardType = .phonePad
			textField.textContentType = .telephoneNumber
		}
		
		
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
		showActiveAppearance()
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		
		if textField.text!.isEmpty {
			resetPlaceholder()
		}
		
		if textField.text!.isEmpty {
			showError(with: "Required field")
			return
			
		}
		
		switch type {
		case .name:
			
			
			if textField.text?.count ?? 0 < 2 {
				showError(with: "Name must have at least 2 letters")
				return
			}
			if textField.text?.count ?? 0 > 60 {
				showError(with: "Name must have maximum 60 letters")
				return
			}
			
		case .email:
			if textField.text?.count(where: { $0 == "@"} ) ?? 0 != 1 {
				showError(with: "Invalid email format")
				return
			}
			
		case .phone:
			return
		}
		
		resetAppearance()
		
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.endEditing(true)
		return false
	}
	
	
}


enum TextFieldType {
	case name
	case email
	case phone
	
	
}
