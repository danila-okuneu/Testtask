//
//  TabBarItemView.swift
//  Testtask
//
//  Created by Danila Okuneu on 14.12.24.
//

import UIKit
import SnapKit

final class TabBarItemView: UIView {

	private let iconImageView: UIImageView = {
		let iv = UIImageView()
		iv.contentMode = .scaleAspectFit
		return iv
	}()
	
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 10)
		label.textAlignment = .left
		return label
	}()
	
	let button: UIButton = {
		let btn = UIButton()
		return btn
	}()
	
	private var selectedImage: UIImage?
	private var normalImage: UIImage?

	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(button)
		button.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
		
		
		let hStack = UIStackView(arrangedSubviews: [iconImageView, titleLabel])
		hStack.axis = .horizontal
		hStack.spacing = 8
		hStack.alignment = .center
		
		addSubview(hStack)
		hStack.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}
		
		hStack.isUserInteractionEnabled = false
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure(title: String, image: UIImage?, selectedImage: UIImage?) {
		self.titleLabel.text = title
		self.iconImageView.image = image
		self.normalImage = image
		self.selectedImage = selectedImage
	}
	
	func setSelected(_ selected: Bool) {
		if selected, let selImage = selectedImage {
			iconImageView.image = selImage
			titleLabel.textColor = .systemBlue
		} else {
			iconImageView.image = normalImage
			titleLabel.textColor = .label
		}
	}
}
