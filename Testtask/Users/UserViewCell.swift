//
//  UserViewCell.swift
//  Testtask
//
//  Created by Danila Okuneu on 14.12.24.
//

import UIKit
import SnapKit
import Kingfisher
import SkeletonView

final class UserViewCell: UITableViewCell {
	
	static let identifire = "UserCell"
	
	let stackContainer = UIView()
	
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
		imageView.isSkeletonable = true
		imageView.layer.cornerRadius = Constants.photoSize / 2
		imageView.layer.masksToBounds = true
		return imageView
	}()
	
	private let vStack: UIStackView = {
		let stack = UIStackView()
		stack.spacing = 4
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
	
	private let emailLabel: UILabel = {
		let label = UILabel()
		label.textColor = .primaryText
		label.font = .nunitoSans(ofSize: 14)
		label.numberOfLines = 2
		label.text = "danila_okuneu@gmail.com"
		return label
	}()
	
	private let phoneLabel: UILabel = {
		let label = UILabel()
		label.textColor = .primaryText
		label.font = .nunitoSans(ofSize: 14)
		label.numberOfLines = 2
		label.text = "+375 (25) 727-07-03"
		return label
	}()
	
	// MARK: - Initializers
	init() {
		super.init(style: .default, reuseIdentifier: nil)
		
		setupViews()
		setupTextSkeletons()
		self.layoutIfNeeded()
		showTextSkeletons()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Layout
	private func setupViews() {
		
		
		stackContainer.addSubview(hStack)
		
		contentView.addSubview(stackContainer)

		let imageContainer = UIView()
		imageContainer.addSubview(photoImageView)
		
		hStack.addArrangedSubview(imageContainer)
		hStack.addArrangedSubview(vStack)
		
		vStack.addArrangedSubview(nameLabel)
		vStack.addArrangedSubview(positionLabel)
		vStack.addArrangedSubview(emailLabel)
		vStack.addArrangedSubview(phoneLabel)
		
		vStack.setCustomSpacing(8, after: positionLabel)
		
		
		setupConstraints()
	}
	
	private func setupConstraints() {
		
		stackContainer.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		
		
		hStack.snp.makeConstraints { make in
			make.verticalEdges.equalToSuperview().inset(24).priority(999)
			make.horizontalEdges.equalToSuperview()
		}
		
		photoImageView.snp.makeConstraints { make in
			make.size.equalTo(Constants.photoSize)
			make.horizontalEdges.equalToSuperview()
		}
	}
	
	// MARK: - Methods
	func update(with user: User) {
		nameLabel.text = user.name
		positionLabel.text = user.position
		emailLabel.text = user.email
		phoneLabel.text = user.phone
		
		guard let url = URL(string: user.photo) else { return }
		photoImageView.kf.setImage(with: url)
	}
	
	private func setupTextSkeletons() {
		[nameLabel, positionLabel, emailLabel, phoneLabel].forEach { label in
			label.isSkeletonable = true
			
			label.skeletonTextNumberOfLines = 1
			
			let randomOffset = CGFloat((0...100).randomElement()!)
			label.skeletonPaddingInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: randomOffset)
		}
	}
	
	func showTextSkeletons() {
	
		[nameLabel, positionLabel, emailLabel, phoneLabel].forEach { label in
			label.showAnimatedGradientSkeleton()
		}
		
		
	}
	
}

// MARK: - Constants
extension UserViewCell {
	
	private struct Constants {
		
		private static let ratio = CGFloat.ratio
		
		static let photoSize = 50 * ratio
		
		
		
	}
	
}
