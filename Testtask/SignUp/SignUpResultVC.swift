//
//  SignUpResult.swift
//  Testtask
//
//  Created by Danila Okuneu on 16.12.24.
//

import UIKit
import SnapKit

final class SignUpResultViewController: UIViewController {
	
	private let stackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.spacing = 24
		return stack
	}()
	
	private let resultImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	private let resultLabel: UILabel = {
		let label = UILabel()
		label.font = .nunitoSans(ofSize: 20)
		label.textAlignment = .center
		label.numberOfLines = 0
		label.textColor = .primaryText
		return label
	}()
	
	private let button = MainButton(with: "Got it")
	
	init(_ success: Bool, message: String = "User successfully registered") {
		super.init(nibName: nil, bundle: nil)
		resultLabel .text = message
		
		if success {
			
			button.setTitle("Got it", for: .normal)
			resultImageView.image = .signUpSuccess
		} else {
			button.setTitle("Try again", for: .normal)
			resultImageView.image = .signUpFailure
		}
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
	}
	
	// MARK: - Layout
	private func setupViews() {
		
		view.backgroundColor = .white
		
		view.addSubview(stackView)
		stackView.addArrangedSubview(resultImageView)
		stackView.addArrangedSubview(resultLabel)
		
		let buttonContainter = UIView()
		buttonContainter.addSubview(button)
		button.snp.makeConstraints { make in
			make.center.equalToSuperview()
			make.verticalEdges.equalToSuperview()
		}
		
		stackView.addArrangedSubview(buttonContainter)
		
		button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
		
		setupConstraints()
	}
	
	private func setupConstraints() {
		
		stackView.snp.makeConstraints { make in
			make.center.equalToSuperview()
			
		}
		
		resultImageView.snp.makeConstraints { make in
			make.size.equalTo(200)
		}
	}
	
	@objc private func buttonTapped() {
		button.didTapped()
		dismiss(animated: true)
	}
	
}
