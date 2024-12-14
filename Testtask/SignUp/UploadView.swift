//
//  UploadView.swift
//  Testtask
//
//  Created by Danila Okuneu on 14.12.24.
//

import UIKit
import SnapKit

final class UploadView: UIView {
	
	// MARK: - UI Components
	private let uploadTitle: UILabel = {
		let label = UILabel()
		label.text = "Upload your photo"
		label.font = .nunitoSans(ofSize: Constants.fontSize)
		label.textColor = .secondary
		return label
	}()
	
	private let uploadButton: UIButton = {
		let button = UIButton()
		button.setTitle("Upload", for: .normal)
		button.setTitleColor(.secondaryTint, for: .normal)
		button.titleLabel?.font = .nunitoSans(ofSize: Constants.fontSize, weight: .semibold)
		return button
	}()
	
	// MARK: - Initializer
	init() {
		super.init(frame: .zero)
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	// MARK: - Layout
	private func setupViews() {
		
		layer.cornerRadius = Constants.cornerRadius
		layer.borderWidth = Constants.borderWidth
		layer.borderColor = UIColor.fieldBorderNormal.cgColor
		
		addSubview(uploadTitle)
		addSubview(uploadButton)
		
		
		setupConstraints()
	}
	
	private func setupConstraints() {
		
		uploadTitle.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.left.equalToSuperview().inset(Constants.padding)
		}
		
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
		
		static let cornerRadius = 4 * ratio
		static let borderWidth = 1.5 * ratio
		
		static let fontSize = 16 * ratio
		
		static let padding = 16 * ratio
		
	}
	
}

