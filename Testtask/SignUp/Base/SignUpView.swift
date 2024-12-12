//
//  SignUpView.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

import UIKit
import SnapKit

protocol SignUpViewProtocol: AnyObject {
	
	var presenter: SignUpPresenterProtocol? { get set }
}

protocol SignUpViewInputs: AnyObject {
	
	// Define input methods
}

protocol SignUpViewOutputs: AnyObject {
	
	// Define output methods
}

// MARK: - View
final class SignUpViewController: UIViewController, SignUpViewProtocol {
	
	var presenter: SignUpPresenterProtocol?
	
}

// MARK: - Input & Output
extension SignUpViewController: SignUpViewInputs, SignUpViewOutputs {
	
	// Extend functionality
}

