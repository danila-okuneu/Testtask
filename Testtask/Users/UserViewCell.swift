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
		imageView.isSkeletonable = true
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
		label.text = "name"
		label.numberOfLines = 0
		return label
	}()
	
	private let positionLabel: UILabel = {
		let label = UILabel()
		label.textColor = .secondaryText
		label.text = "position"
		label.font = .nunitoSans(ofSize: 14)
		return label
	}()
	
	private let emailLabel: UILabel = {
		let label = UILabel()
		label.textColor = .primaryText
		label.font = .nunitoSans(ofSize: 14)
		label.numberOfLines = 1
		label.text = "email adress"
		return label
	}()
	
	private let phoneLabel: UILabel = {
		let label = UILabel()
		label.textColor = .primaryText
		label.font = .nunitoSans(ofSize: 14)
		label.numberOfLines = 1
		label.text = "phone number"
		return label
	}()
	
	// MARK: - Initializers
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		setupViews()
		setupTextSkeletons()
		self.layoutIfNeeded()
		showSkeletons()
	}
	

	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func prepareForReuse() {
		photoImageView.image = nil
		nameLabel.text = ""
		positionLabel.text = ""
		emailLabel.text = ""
		phoneLabel.text = ""
		photoImageView.kf.cancelDownloadTask()

		showSkeletons()
		super.prepareForReuse()
		
		
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
		vStack.addArrangedSubview(emailLabel)
		vStack.addArrangedSubview(phoneLabel)
		
		vStack.setCustomSpacing(8, after: positionLabel)
		
		
		setupConstraints()
	}
	
	private func setupConstraints() {
		
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
		hideTextSkeletons()
		nameLabel.text = user.name
		positionLabel.text = user.position
		emailLabel.text = user.email
		phoneLabel.text = user.phone
		
		guard let url = URL(string: user.photo) else { return }
		photoImageView.kf.setImage(with: url)
		photoImageView.hideSkeleton()
	}
	
	private func setupTextSkeletons() {
		[nameLabel, positionLabel, emailLabel, phoneLabel].forEach { label in
			label.isSkeletonable = true
			
			let randomOffset = CGFloat((0...100).randomElement()!)
			label.skeletonPaddingInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: randomOffset)
		}
	}
	
	func showSkeletons() {
		[nameLabel, positionLabel, emailLabel, phoneLabel, photoImageView].forEach { view in
			view.showAnimatedGradientSkeleton()
		}
	}
	
	func hideTextSkeletons() {
		[nameLabel, positionLabel, emailLabel, phoneLabel].forEach { view in
			view.hideSkeleton(transition: .crossDissolve(0.2))
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
