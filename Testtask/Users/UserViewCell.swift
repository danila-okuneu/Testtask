//
//  UserViewCell.swift
//  Testtask
//
//  Created by Danila Okuneu on 14.12.24.
//

import UIKit
import SnapKit
import Kingfisher

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
		imageView.layer.cornerRadius = C.UserCell.photoCornerRadius
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
		label.font = C.Font.bodyLarge
		label.text = "name"
		label.numberOfLines = 0
		return label
	}()
	
	private let positionLabel: UILabel = {
		let label = UILabel()
		label.textColor = .secondaryText
		label.text = "position"
		label.font = C.Font.bodySmall
		return label
	}()
	
	private let emailLabel: UILabel = {
		let label = UILabel()
		label.textColor = .primaryText
		label.font = C.Font.bodySmall
		label.numberOfLines = 1
		label.text = "email adress"
		return label
	}()
	
	private let phoneLabel: UILabel = {
		let label = UILabel()
		label.textColor = .primaryText
		label.font = C.Font.bodySmall
		label.numberOfLines = 1
		label.text = "phone number"
		return label
	}()
	
	// MARK: - Initializers
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		setupViews()
		self.layoutIfNeeded()
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

		super.prepareForReuse()
	}
	
	// MARK: - Layout
	private func setupViews() {
		
		backgroundColor = .white
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
			make.verticalEdges.equalToSuperview().inset(C.padding).priority(999)
			make.horizontalEdges.equalToSuperview()
		}
		
		photoImageView.snp.makeConstraints { make in
			make.size.equalTo(C.UserCell.photoSize)
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
}
