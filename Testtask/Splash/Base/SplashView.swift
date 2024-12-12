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
	
}

// MARK: - Input & Output
extension SplashViewController: SplashViewInputs, SplashViewOutputs {
	
	// Extend functionality
}

