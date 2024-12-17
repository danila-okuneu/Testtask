//
//  SplashView.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

import UIKit

protocol SplashViewProtocol: AnyObject {
	
	var presenter: SplashViewOutputs? { get set }
}

protocol SplashViewOutputs: AnyObject {
	
	func viewWillAppear()
}

// MARK: - View
final class SplashViewController: UIViewController, SplashViewProtocol {
	
	var presenter: SplashViewOutputs?
	
	
	// UI Components
	private let logoImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.image = .logo
		return imageView
	}()
	
	// Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupViews()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		presenter?.viewWillAppear()
		
	}
	
	// Layout
	private func setupViews() {
		
		view.backgroundColor = .accent
		view.addSubview(logoImageView)
		
		setupConstraints()
	}
	
	private func setupConstraints() {
		
		logoImageView.snp.makeConstraints { make in
			make.center.equalToSuperview()
			make.width.equalToSuperview().multipliedBy(0.444444)
		}
		
	}
}

