//
//  PositionsList.swift
//  Testtask
//
//  Created by Danila Okuneu on 14.12.24.
//

import UIKit
import SnapKit

final class PositionsList: UIStackView {
	

	private let positions: [String]
	private var buttons: [RadioButton] = []
	private var selectedButton: RadioButton?
	
	// MARK: - Initializers
	init(positions: String...) {
		self.positions = positions
		super.init(frame: .zero)

		axis = .vertical
		distribution = .fillEqually
			
		for position in positions {
			addPostion(position)
		}
		
		selectedButton = buttons.first
		selectedButton?.select()
		
		
	}
	
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Methods
	func addPostion(_ position: String) {
		
		let button = RadioButton()
		buttons.append(button)
		button.addTarget(self, action: #selector(selectPosition), for: .touchUpInside)
		button.snp.makeConstraints { make in
			make.width.equalTo(Constants.radioButtonWidth)
		}
		
		let label = UILabel()
		label.text = position
		label.font = .nunitoSans(ofSize: Constants.positionFontSize)
		
		let hStack = UIStackView()
		hStack.axis = .horizontal
		hStack.spacing = Constants.hSpacing
		
		hStack.snp.makeConstraints { make in
			make.height.equalTo(Constants.positionHeight)
		}
		hStack.addArrangedSubview(button)
		hStack.addArrangedSubview(label)
		addArrangedSubview(hStack)
	}
	
	// MARK: - Button Target
	@objc private func selectPosition(_ sender: RadioButton) {
		guard selectedButton !== sender else { return }
		selectedButton?.reset()
		sender.select()
		selectedButton = sender
	}
}

// MARK: - Constants
extension PositionsList {
	
	private struct Constants {
		
		static let hSpacing = 12 * CGFloat.ratio
		static let positionHeight = 48
		static let radioButtonWidth = 48 * CGFloat.ratio
		
		static let positionFontSize = 16 * CGFloat.ratio
	}
}
