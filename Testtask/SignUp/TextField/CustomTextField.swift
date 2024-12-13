//
//  CustomTextField.swift
//  Testtask
//
//  Created by Danila Okuneu on 13.12.24.
//

import UIKit

final class SignUpTextField: UIView {
	
	var isPlaceHorderCentered = true
	
	let textFieldView: UIView = {
		let view = UIView()
		view.backgroundColor = .white
		view.layer.cornerRadius = Constants.cornerRadius
		view.layer.borderWidth = 1.5
		view.layer.borderColor = UIColor.fieldBorderNormal.cgColor
		return view
	}()
	
	let textField: UITextField = {
		let field = UITextField()
		return field
	}()
	
	lazy var supportingLabel: UILabel = {
		let label = UILabel()
		label.text = "Hint"
		label.textColor = .fieldHint
		label.font = .nunitoSans(ofSize: Constants.secondaryFontSyze)
		return label
	}()
	
	private let placeholderLabel: UILabel = {
		let label = UILabel()
		label.text = "Placeholder"
		label.adjustsFontSizeToFitWidth = true
		label.minimumScaleFactor = 0.2
		label.textColor = .secondary
		label.font = .nunitoSans(ofSize: Constants.placeholderFontSize)
		return label
	}()
	
	
	// MARK: - Initializers
	init(placeholder: String, hint: String = "") {
		super.init(frame: .zero)
		
		placeholderLabel.text = placeholder
		supportingLabel.text = hint
		
		setupViews()
		

	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Life cycle
	override func layoutSubviews() {
		super.layoutSubviews()
		
		setupConstraints()
	}
	
	// MARK: - Layout
	private func setupViews() {
		
		let paddingView = UIView()
		paddingView.frame.size = CGSize(width: Constants.leftPadding, height: 1)
		textField.leftView = paddingView
		textField.leftViewMode = .always
		
		addSubview(textFieldView)
		addSubview(supportingLabel)
		
		textFieldView.addSubview(textField)
		textFieldView.addSubview(placeholderLabel)
		
		textField.delegate = self
		
		
		
	}
	
	private func setupConstraints() {
		
		textFieldView.snp.makeConstraints { make in
			make.top.left.right.equalToSuperview()
			make.height.equalTo(70)
		}
		
		textField.snp.makeConstraints { make in
			make.left.bottom.right.equalToSuperview()
			make.height.equalTo(Constants.fieldHeight)
		}
		
		placeholderLabel.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.left.equalToSuperview().offset(Constants.leftPadding)
		}
		
		supportingLabel.snp.makeConstraints { make in
			make.top.equalTo(textField.snp.bottom).offset(5)
			make.left.equalToSuperview().offset(Constants.leftPadding)
			make.bottom.equalToSuperview()
		}
		
	}

	// MARK: - Methods
	func movePlaceholder() {
		
		
		let scale = Constants.placeholderRatio
		let translationX = -placeholderLabel.bounds.width * (1 - scale) / 2
		let translationY = -self.textFieldView.bounds.height / 2 + placeholderLabel.bounds.height / 2 + Constants.placeholderTopOffset
		
		
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

// MARK: - Constants
extension SignUpTextField {
	
	
	// xO
	// O - offset
	// x - Top, Left, Bottom, Right
	
	private struct Constants {
		
		
		static let cornerRadius = 4 * CGFloat.ratio
		
		
		static let fieldHeight = 56 * CGFloat.ratio
		static let leftPadding = 16 * CGFloat.ratio
		
		static let placeholderFontSize = 16 * CGFloat.ratio
		static let placeholderRatio = 12 / placeholderFontSize
		static let placeholderTopOffset = 8 * CGFloat.ratio
		
		static let secondaryFontSyze = 12 / CGFloat.ratio
	}
	
}

extension CGFloat {
	
	static let ratio: CGFloat = {
		
		guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return 1.0 }
		   guard let window = windowScene.windows.first else { return 1.0 }
			   
		   return window.bounds.width / 360
	   }()
	
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
