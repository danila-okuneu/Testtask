//
//  CustomTextField.swift
//  Testtask
//
//  Created by Danila Okuneu on 13.12.24.
//

import UIKit

final class CustomTextField: UIView {
	
	var isPlaceHorderCentered = true
	
	let textFieldView: UIView = {
		let view = UIView()
		view.backgroundColor = .white
		view.layer.cornerRadius = 10
		view.layer.borderWidth = 2
		return view
	}()
	
	let textField: UITextField = {
		let field = UITextField()
		return field
	}()
	
	lazy var hintLabel: UILabel = {
		let label = UILabel()
		label.text = "Hint"
		label.font = .nunitoSans(ofSize: 12)
		return label
	}()
	
	private let placeholderLabel: UILabel = {
		let label = UILabel()
		label.text = "Placeholder"
		label.adjustsFontSizeToFitWidth = true
		label.minimumScaleFactor = 0.2
		label.font = .systemFont(ofSize: 20)
		return label
	}()
	
	
	// MARK: - Initializers
	init(placeholder: String, hint: String = "") {
		super.init(frame: .zero)
		
		placeholderLabel.text = placeholder
		hintLabel.text = hint
		
		setupViews()
		

	}
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	private func setupViews() {
		
		let paddingView = UIView()
		paddingView.frame.size = CGSize(width: 20, height: 1)
		textField.leftView = paddingView
		textField.leftViewMode = .always
		
		addSubview(textFieldView)
		addSubview(hintLabel)
		
		textFieldView.addSubview(textField)
		textFieldView.addSubview(placeholderLabel)
		
		textField.delegate = self
		
		setupConstraints()
	}
	
	private func setupConstraints() {
		
		textFieldView.snp.makeConstraints { make in
			make.top.left.right.equalToSuperview()
			make.height.equalTo(70)
		}
		
		textField.snp.makeConstraints { make in
			make.left.bottom.right.equalToSuperview()
			make.height.equalTo(50)
		}
		
		placeholderLabel.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.left.equalToSuperview().offset(20)
		}
		
		hintLabel.snp.makeConstraints { make in
			make.top.equalTo(textField.snp.bottom).offset(5)
			make.left.equalToSuperview().offset(15)
		}
		
	}

	
	
	
	func movePlaceholder() {
		
		
		let scale = 0.7
		let translationX = -placeholderLabel.bounds.width * (1 - scale) / 2
		let translationY = -self.textFieldView.bounds.height / 2 + 20
		
		
		UIView.animate(withDuration: 0.3) {
			self.placeholderLabel.transform = CGAffineTransform(scale, 0, 0, scale, translationX, translationY)
			
			
		}
	}
	
	func resetPlaceholder() {
		UIView.animate(withDuration: 0.3) {
			self.placeholderLabel.transform = .identity
			
			
		}
		
		
	}
	
	func animateFontSizeChange(to fontSize: CGFloat) {
		let animation = CABasicAnimation(keyPath: "fontSize")
		animation.fromValue = self.placeholderLabel.font.pointSize
		animation.toValue = fontSize
		animation.duration = 0.3

		if let textLayer = self.placeholderLabel.layer as? CATextLayer {
			textLayer.add(animation, forKey: "fontSize")
			textLayer.fontSize = fontSize // Установить конечное значение
		}
	}
	
}


extension CustomTextField: UITextFieldDelegate {
	
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
