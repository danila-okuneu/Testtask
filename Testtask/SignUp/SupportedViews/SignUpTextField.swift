//
//  SignUpTextField.swift
//  Testtask
//
//  Created by Danila Okuneu on 13.12.24.
//

import UIKit


final class SignUpTextField: SupportedView {
	
	
	let type: TextFieldType
	var validationHandler: ((String) -> String?)?
	var text: String { textField.text ?? "" }
	
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
	

	
	func resetAppearance() {
		UIView.animate(withDuration: 0.3) {
			self.titleLabel.textColor = .secondaryTitle
			self.supportingLabel.textColor = .secondaryTitle
			self.primaryView.layer.borderColor = UIColor.fieldBorderNormal.cgColor
		}
		resetSupporting()
	}
	
	
	
	private func configure() {
		switch type {
		case .name:
			textField.textContentType = .name
			textField.autocapitalizationType = .words
			validationHandler = ValidationRules.validateName(_:)
		case .email:
			textField.textContentType = .emailAddress
			textField.keyboardType = .emailAddress
			textField.autocorrectionType = .no
			textField.autocapitalizationType = .none
			validationHandler = ValidationRules.validateEmail(_:)
		case .phone:
			textField.keyboardType = .phonePad
			textField.textContentType = .telephoneNumber
			validationHandler = ValidationRules.validateNumber(_:)
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
		
		guard let text = textField.text, !text.isEmpty else {
			resetPlaceholder()
			showError(with: "Required field")
			return
		}

		if let validationHandler, let description = validationHandler(text) {
			showError(with: description)
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
