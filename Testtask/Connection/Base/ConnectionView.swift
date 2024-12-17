//
//  ConnectionView.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

import UIKit
import SnapKit

protocol ConnectionViewProtocol: AnyObject {
	
	var presenter: ConnectionViewOutputs? { get set }
}

protocol ConnectionViewInputs: AnyObject {
	
	// Define input methods
}

protocol ConnectionViewOutputs: AnyObject {
	
	func didTapTryAgain()
}

// MARK: - View
final class ConnectionViewController: UIViewController, ConnectionViewProtocol {
	
	var presenter: ConnectionViewOutputs?
	
	private let stackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.spacing = 24
		return stack
	}()
	
	private let connectionImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = .noConnection
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	private let resultLabel: UILabel = {
		let label = UILabel()
		label.font = .nunitoSans(ofSize: 20)
		label.textAlignment = .center
		label.text = "There is no internet connection"
		label.textColor = .primaryText
		return label
	}()
	
	private let button = MainButton(with: "Try again")
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
	}
	
	// MARK: - Layout
	private func setupViews() {
		
		view.backgroundColor = .white
		
		view.addSubview(stackView)
		stackView.addArrangedSubview(connectionImageView)
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
		
		connectionImageView.snp.makeConstraints { make in
			make.size.equalTo(200)
		}
	}
	
	@objc private func buttonTapped() {
		button.didTapped()
		presenter?.didTapTryAgain()
	}
	
}

// MARK: - Input & Output
extension ConnectionViewController: ConnectionViewInputs {
	
	// Extend functionality
}

