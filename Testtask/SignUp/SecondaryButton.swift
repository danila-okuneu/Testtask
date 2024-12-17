//
//  SecondaryButton.swift
//  Testtask
//
//  Created by Danila Okuneu on 14.12.24.
//

import UIKit
import SnapKit

final class SecondaryButton: UIButton {
	
	// Initializers
	init(with title: String) {
		super.init(frame: .zero)
		
		setTitle(title, for: .normal)
		setupButton()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// Life cycle
	override func layoutSubviews() {
		super.layoutSubviews()
		layer.cornerRadius = frame.height / 2
	}
	
	// Methods
	private func setupButton() {
		
		setTitleColor(.secondaryTint, for: .normal)
		setTitleColor(.primaryTintDisabled, for: .disabled)
		setTitleColor(.primaryTintPressed, for: .highlighted)
		
		titleLabel?.font = C.SecondaryButton.font
			
		snp.makeConstraints { make in
			
			make.height.equalTo(C.SecondaryButton.width)
			make.width.equalTo(C.SecondaryButton.height)
		}
	}
	
	func didTapped() {
		backgroundColor = .secondaryPressed
		UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseInOut) {
			self.backgroundColor = .clear
		}
	}
}
