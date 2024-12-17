//
//  UploadView.swift
//  Testtask
//
//  Created by Danila Okuneu on 14.12.24.
//

import UIKit
import SnapKit

final class UploadView: SupportedView {
	
	
	var delegate: UploadViewDelegate?
	
	var viewController: UIViewController?
	
	// MARK: - UI Components
	let photoImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.backgroundColor = .fieldBorderNormal
		imageView.isHidden = true
		imageView.layer.masksToBounds = true
		imageView.layer.cornerRadius = 8
		return imageView
	}()
	
	let uploadButton = SecondaryButton(with: "Upload")
	private let removeButton = SecondaryButton(with: "Remove")
	
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
		removeButton.isHidden = true
		removeButton.addTarget(self, action: #selector(removePhoto), for: .touchUpInside)
	}
	
	private func setupConstraints() {
		
		photoImageView.snp.makeConstraints { make in
			make.left.equalTo(C.semipadding)
			make.centerY.equalToSuperview()
			make.height.width.equalTo(primaryView.snp.height).multipliedBy(0.8)
		}
		
		
		removeButton.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.left.equalTo(photoImageView.snp.right).offset(C.semipadding)
		}
		
		
		uploadButton.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.right.equalToSuperview().inset(C.padding)
		}
	}
	
	func loadPhoto(_ image: UIImage) {
		photoImageView.image = image
		photoImageView.isHidden = false
		removeButton.isHidden = false
		titleLabel.isHidden = true
	}
	
	@objc private func removePhoto() {
		
		removeButton.didTapped()
		photoImageView.image = nil
		photoImageView.isHidden = true
		removeButton.isHidden = true
		titleLabel.isHidden = false
		delegate?.didRemovePhoto()
		showError(with: "Required field")
		
		
	}
}

protocol UploadViewDelegate {
	
	func didRemovePhoto()
}
