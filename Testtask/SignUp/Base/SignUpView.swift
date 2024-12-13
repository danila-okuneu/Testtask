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
	
	let textField = CustomTextField(placeholder: "Phone", hint: "+375 (25) 727-07-03")
		
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(textField)
		textField.snp.makeConstraints { make in
			make.height.equalTo(90)
			make.center.equalToSuperview()
			make.horizontalEdges.equalToSuperview().inset(20)
		}
		
	}
	
	
	var presenter: SignUpPresenterProtocol?
	
}

// MARK: - Input & Output
extension SignUpViewController: SignUpViewInputs, SignUpViewOutputs {
	
	// Extend functionality
}



@available(iOS 17.0, *)
#Preview {
	return SignUpViewController()
}
