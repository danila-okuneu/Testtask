//
//  UploadView.swift
//  Testtask
//
//  Created by Danila Okuneu on 14.12.24.
//

import UIKit
import SnapKit

final class UploadView: SupportedView {
	
	// MARK: - UI Components
	private let uploadButton: UIButton = {
		let button = UIButton()
		button.setTitle("Upload", for: .normal)
		button.setTitleColor(.secondaryTint, for: .normal)
		button.titleLabel?.font = .nunitoSans(ofSize: Constants.fontSize, weight: .semibold)
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

		addSubview(uploadButton)
		setupConstraints()
	}
	
	private func setupConstraints() {
		
		uploadButton.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.right.equalToSuperview().inset(Constants.padding)
		}
		
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

