//
//  SplashView.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

import UIKit

protocol SplashViewProtocol: AnyObject {
	
	var presenter: SplashPresenterProtocol? { get set }
}

protocol SplashViewInputs: AnyObject {
	
	// Define input methods
}

protocol SplashViewOutputs: AnyObject {
	
	// Define output methods
}

// MARK: - View
final class SplashViewController: UIViewController, SplashViewProtocol {
	
	var presenter: SplashPresenterProtocol?
	
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
		
		Task {
			
			try? await Task.sleep(nanoseconds: 3 * 1_000_000_000)
			
		}
		
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

// MARK: - Input & Output
extension SplashViewController: SplashViewInputs, SplashViewOutputs {
	
	// Extend functionality
}


