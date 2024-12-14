//
//  RoundedButton.swift
//  Testtask
//
//  Created by Danila Okuneu on 14.12.24.
//

import UIKit
import SnapKit

final class RoundedButton: UIButton {
	
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
		titleLabel?.font = .nunitoSans(ofSize: 18, weight: .semibold)
		backgroundColor = .accent
		
		snp.makeConstraints { make in
			make.width.equalTo(Constants.width)
			make.height.equalTo(Constants.height)
		}
	}
	
	
}


extension RoundedButton {
	
	private struct Constants {
		
		private static let ratio = CGFloat.ratio
		
		static let height = 48 * ratio
		static let width = 140 * ratio
		
	}
	
}
