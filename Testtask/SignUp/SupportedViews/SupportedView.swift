//
//  HintedView.swift
//  Testtask
//
//  Created by Danila Okuneu on 14.12.24.
//

import UIKit
import SnapKit

class SupportedView: UIView {
	
	let supporting: String
	
	// MARK: - UI Components
	let primaryView: UIView = {
		let view = UIView()
		view.backgroundColor = .white
		view.layer.cornerRadius = Constants.cornerRadius
		view.layer.borderWidth = 1.5
		view.layer.borderColor = UIColor.fieldBorderNormal.cgColor
		return view
	}()
	
	let supportingLabel: UILabel = {
		let label = UILabel()
		label.text = "Supporting text"
		label.textColor = .fieldHint
		label.font = .nunitoSans(ofSize: Constants.supportingFontSyze)
		label.numberOfLines = 1
		return label
	}()
	
	let titleLabel: UILabel = {
		let label = UILabel()
		label.text = "Title"
		label.adjustsFontSizeToFitWidth = true
		label.minimumScaleFactor = 0.2
		label.textColor = .secondaryTitle
		label.font = .nunitoSans(ofSize: Constants.titleFontSize)
		return label
	}()
	
	
	// MARK: - Initializers
	init(title: String, supporting: String = "") {
		self.supporting = supporting
		super.init(frame: .zero)
		
		titleLabel.text = title
		supportingLabel.text = supporting
		
		setupViews()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Life cycle
	override func layoutSubviews() {
		super.layoutSubviews()
		
		
	}
	
	// MARK: - Layout
	private func setupViews() {
		
		addSubview(primaryView)
		addSubview(supportingLabel)
		addSubview(titleLabel)
		
		setupConstraints()
	}
	
	private func setupConstraints() {
		
		primaryView.snp.makeConstraints { make in
			make.top.left.right.equalToSuperview()
			make.height.equalTo(Constants.primaryViewHeight)
		}
				
		titleLabel.snp.makeConstraints { make in
			make.centerY.equalTo(primaryView)
			make.left.equalToSuperview().offset(Constants.padding)
		}
		
		supportingLabel.snp.makeConstraints { make in
			make.top.equalTo(primaryView.snp.bottom).offset(5)
			make.left.equalToSuperview().offset(Constants.padding)
			make.bottom.equalToSuperview()
			make.height.equalTo(Constants.supportingFontSyze)
		}
	}
	
	// MARK: - Methods
	
	/// Shows error appearance with Message in supporting label
	func showError(with message: String?) {
		UIView.animate(withDuration: 0.3) {
			self.titleLabel.textColor = .fieldWrong
			self.supportingLabel.textColor = .fieldWrong
			self.primaryView.layer.borderColor = UIColor.fieldWrong.cgColor
		}
		if let message {
			supportingLabel.text = message
		}
	}
	
	/// Resets appearance of all views. Also resets supporting text
	func setNormalAppearance() {
		UIView.animate(withDuration: 0.3) {
			self.titleLabel.textColor = .secondaryTitle
			self.supportingLabel.textColor = .secondaryTitle
			self.primaryView.layer.borderColor = UIColor.fieldBorderNormal.cgColor
		}
		resetSupporting()
	}
	
	func resetSupporting() {
		if supportingLabel.text != supporting {
			UIView.transition(with: supportingLabel, duration: 0.1, options: .transitionCrossDissolve) {
				self.supportingLabel.text = self.supporting
			}
		}
	}
	
}

// MARK: - Constants
extension SupportedView {
	
	private struct Constants {
		
		private static let ratio = CGFloat.ratio
		
		static let cornerRadius = 4 * ratio
		static let primaryViewHeight = 56 * ratio
		
		
		static let fieldHeight = 56 * ratio
		static let padding = 16 * ratio
		
		static let titleFontSize = 16 * ratio
		
		static let supportingFontSyze = 12 * ratio
	}
}
