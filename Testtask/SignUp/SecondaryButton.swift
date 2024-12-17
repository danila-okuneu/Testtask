//
//  SecondaryButton.swift
//  Testtask
//
//  Created by Danila Okuneu on 14.12.24.
//

import UIKit
import SnapKit

final class SecondaryButton: UIButton {
	
	// MARK: - Initializers
	init(with title: String) {
		super.init(frame: .zero)
		
		setTitle(title, for: .normal)
		setupButton()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		layer.cornerRadius = frame.height / 2
	}
	
	private func setupButton() {
		
		setTitleColor(.secondaryTint, for: .normal)
		setTitleColor(.primaryTintDisabled, for: .disabled)
		setTitleColor(.primaryTintPressed, for: .highlighted)
		
		titleLabel?.font = .nunitoSans(ofSize: 18, weight: .semibold)
			
		snp.makeConstraints { make in
			
			make.height.equalTo(Constants.height)
			make.width.equalTo(Constants.width)
		}
	}
	
	
	func didTapped() {
		backgroundColor = .secondaryPressed
		UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseInOut) {
			self.backgroundColor = .clear
		}
		
	}
}

extension SecondaryButton {
	private struct Constants {
		
		static let height = 40 * CGFloat.ratio
		static let width = 91 * CGFloat.ratio
		
	}
	
}
