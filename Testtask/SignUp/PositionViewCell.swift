//
//  PositionViewCell.swift
//  Testtask
//
//  Created by Danila Okuneu on 16.12.24.
//

import UIKit
import SnapKit

final class PositionViewCell: UITableViewCell {
	
	static let identifire = "PositionViewCell"
	
	// MARK: - UI Components
	let button = RadioButton()
	
	private let hStack: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.spacing = 16
		return stack
	}()
	
	private let positionLabel: UILabel = {
		let label = UILabel()
		label.textColor = .primaryText
		label.font = .nunitoSans(ofSize: 16)
		return label
	}()
	
	// MARK: - Initializers
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		setupViews()
	}
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(false, animated: false)
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		button.resetAppearance()
	}
	// MARK: - Layout
	private func setupViews() {
		
		contentView.addSubview(hStack)
		
		hStack.addArrangedSubview(button)
		hStack.addArrangedSubview(positionLabel)
		
		
		setupConstraints()
	}
	
	private func setupConstraints() {
		
		hStack.snp.makeConstraints { make in
			make.edges.equalToSuperview().priority(.required)
		}
		
		button.snp.makeConstraints { make in
			make.size.equalTo(48)
		}
	}
	

	
	// MARK: - Methods
	func configure(with position: Position) {
		positionLabel.text = position.name
	}
	
	@objc func select() {
		button.selectedAppearance()
	}
}
