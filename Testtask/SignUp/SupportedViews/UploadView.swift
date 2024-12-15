//
//  UploadView.swift
//  Testtask
//
//  Created by Danila Okuneu on 14.12.24.
//

import UIKit
import SnapKit

final class UploadView: SupportedView {
	
	
	var viewController: UIViewController?
	
	// MARK: - UI Components
	
	private let photoImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.backgroundColor = .fieldBorderNormal
		imageView.isHidden = true
		imageView.layer.masksToBounds = true
		imageView.layer.cornerRadius = 8
		return imageView
	}()
	
	let uploadButton: UIButton = {
		let button = UIButton()
		button.setTitle("Upload", for: .normal)
		button.setTitleColor(.secondaryTint, for: .normal)
		button.titleLabel?.font = .nunitoSans(ofSize: Constants.fontSize, weight: .semibold)
		
		return button
	}()
	
	private let removeButton: UIButton = {
		let button = UIButton()
		button.setTitle("Remove", for: .normal)
		button.setTitleColor(.secondaryTint, for: .normal)
		button.titleLabel?.font = .nunitoSans(ofSize: Constants.fontSize, weight: .semibold)
		button.isHidden = true
		return button
	}()
	
	
	// MARK: - Initializer
	init() {
		super.init(title: "Upload your photo")
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Layout
	private func setupViews() {

		primaryView.addSubview(photoImageView)
		primaryView.addSubview(removeButton)
		primaryView.addSubview(uploadButton)
		setupConstraints()
		removeButton.addTarget(self, action: #selector(removePhoto), for: .touchUpInside)
	}
	
	private func setupConstraints() {
		
		photoImageView.snp.makeConstraints { make in
			make.left.equalTo(Constants.padding / 2)
			make.centerY.equalToSuperview()
			make.height.width.equalTo(primaryView.snp.height).multipliedBy(0.8)
		}
		
		
		removeButton.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.left.equalTo(photoImageView.snp.right).offset(Constants.padding / 2)
		}
		
		
		uploadButton.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.right.equalToSuperview().inset(Constants.padding)
		}
	}
	
	func loadPhoto(_ image: UIImage) {
		photoImageView.image = image
		photoImageView.isHidden = false
		removeButton.isHidden = false
		titleLabel.isHidden = true
	}
	
	@objc private func removePhoto() {
		photoImageView.image = nil
		photoImageView.isHidden = true
		removeButton.isHidden = true
		titleLabel.isHidden = false
		
		
	}
}


// MARK: - Constants
extension UploadView {
	
	private struct Constants {
		
		static let ratio = CGFloat.ratio
		
		static let fontSize = 16 * ratio
		
		static let padding = 16 * ratio
	}
}

