//
//  Untitled.swift
//  Testtask
//
//  Created by Danila Okuneu on 14.12.24.
//

import UIKit
import SnapKit

final class TableViewCell: UITableViewCell {
	
	static let identifire = "TableViewCell"
	
	
	private let hStack: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.spacing = 16
		return stack
	}()
	
	private let photoImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.backgroundColor = .systemGray6
		imageView.image = .noConnection
		return imageView
	}()
	
	private let vStack: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		return stack
	}()
	
	private let nameLabel: UILabel = {
		let label = UILabel()
		label.textColor = .primaryText
		label.font = .nunitoSans(ofSize: 18)
		label.text = "Danila Okunev"
		label.numberOfLines = 0
		return label
	}()
	
	private let positionLabel: UILabel = {
		let label = UILabel()
		label.textColor = .secondaryText
		label.text = "Junior iOS developer"
		label.font = .nunitoSans(ofSize: 14)
		return label
	}()
	
	private let contactsLabel: UILabel = {
		let label = UILabel()
		label.textColor = .primaryText
		label.font = .nunitoSans(ofSize: 14)
		label.numberOfLines = 2
		label.text = "danila@okuneu.com\n+375 (25) 727-07-03"
		return label
	}()
	
	// MARK: - Initializers
	init() {
		super.init(style: .default, reuseIdentifier: nil)
		
		
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Layout
	private func setupViews() {
		
		contentView.addSubview(hStack)
		
		let imageContainer = UIView()
		imageContainer.addSubview(photoImageView)
		
		hStack.addArrangedSubview(imageContainer)
		hStack.addArrangedSubview(vStack)
		
		vStack.addArrangedSubview(nameLabel)
		vStack.addArrangedSubview(positionLabel)
		vStack.addArrangedSubview(contactsLabel)
		
		
		
		setupConstraints()
	}
	
	private func setupConstraints() {
		
		hStack.snp.makeConstraints { make in
			make.verticalEdges.equalToSuperview().inset(24)
			make.horizontalEdges.equalToSuperview()
		}
		
		photoImageView.snp.makeConstraints { make in
			make.size.equalTo(Constants.photoSize)
			make.horizontalEdges.equalToSuperview()
		}
		
		
		
	}
	
	
}

extension TableViewCell {
	
	private struct Constants {
		
		private static let ratio = CGFloat.ratio
		
		static let photoSize = 50 * ratio
		
		
		
	}
	
}
