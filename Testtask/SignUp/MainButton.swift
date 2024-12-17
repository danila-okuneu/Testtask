//
//  MainButton.swift
//  Testtask
//
//  Created by Danila Okuneu on 14.12.24.
//

import UIKit
import SnapKit

final class MainButton: UIButton {
	
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
		
		setTitleColor(.primaryText, for: .normal)
		setTitleColor(.primaryTintDisabled, for: .disabled)
		setTitleColor(.primaryTintPressed, for: .highlighted)
		
		titleLabel?.font = C.MainButton.font
		backgroundColor = .accent
		
		snp.makeConstraints { make in
			make.width.equalTo(C.MainButton.width)
			make.height.equalTo(C.MainButton.height)
		}
	}
	
	
	func disable() {
		
		
		self.isEnabled = false
		UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut) {
			self.backgroundColor = .primaryBgDisabled
		}
	}
	
	func enable() {
		self.isEnabled = true
		UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut) {
			self.backgroundColor = .accent
		}
	}
	
	func didTapped() {
		backgroundColor = .primaryBgPressed
		UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseInOut) {
			self.backgroundColor = .accent
		}
		
	}
}
