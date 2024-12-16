//
//  SignUpPresenter.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

import UIKit
import Dispatch

// MARK: - Presenter Protocol
protocol SignUpPresenterProtocol: AnyObject {
	
	var view: SignUpViewController? { get set }
	var interactor: SignUpInteractorInput? { get set }
	
}

protocol SignUpPresenterInputs: AnyObject {
	
}

protocol SignUpPresenterOutputs: AnyObject {
	
	// Define output methods
}

// MARK: - Presenter
final class SignUpPresenter: SignUpPresenterProtocol {
	
	weak var view: SignUpViewController?
	var interactor: SignUpInteractorInput?
	
	var name: String?
	var email: String?
	var phone: String?
	var photo: UIImage?
	var position: Int?
	
	init(view: SignUpViewController?, interactor: SignUpInteractor?) {
		self.view = view
		self.interactor = interactor
	}
}

// MARK: - Input
extension SignUpPresenter: SignUpPresenterInputs {
	
	func viewWillAppear() {
		Task {
			await interactor?.fetchPositions()
		}
	}
	
	func didTabSignUpButton() {
		
		guard let name, let email, let phone, let photo, let position else {
			view?.updateSignUpButton(false)
			return
		}

		guard let data = photo.jpegData(compressionQuality: 0.8) else { return }
		
		
		let request = RegisterUserRequest(name: name, email: email, phone: phone, positionId: position, photo: data)
		Task {
			await interactor?.registerUser(request)
		}
		
		
	}
	

	
	func didSelectPosition(at index: Int) {
		self.position = index + 1
		updateSignUpButton()
	}
	
	func didPickPhoto(_ image: UIImage) {
		if let message = ValidationManager.validatePhoto(image) {
			view?.displayError(message, for: .photo)
			return
		}
		self.photo = image
	}
	
}


// MARK: - Interactor Output
extension SignUpPresenter: SignUpInteractorOutput {
	
	func didRegisterUser() {
		view?.displaySuccessScreen()
	}
	
	func didFailureToRegisterUser(_ message: String) {
		view?.displayFailureScreen(message)
	}
	
	
	func didFetchPositions(_ positions: [Position]) {
		view?.displayPositions(positions)
	}
	
	func didFailureToFetchPositions(_ message: String = "Failure to fetch positions") {
		print("Failure")
		DispatchQueue.main.sync {
			view?.showErrorAlert(message: message)
		}
	}

}

// MARK: - View Output
extension SignUpPresenter: SignUpViewOutput {
	
	func didChangeField(_ text: String, ofType type: TextFieldType) {
		
		if let message = ValidationManager.validateField(with: text, ofType: type) {
			view?.displayError(message, for: type)
		} else {
			view?.clearFieldError(type)
			
			
			switch type {
			case .name:
				self.name = text
			case .email:
				self.email = text
			case .phone:
				self.phone = text
			case .photo:
				return
			}
		}
		updateSignUpButton()
	}
	
	func didPickPhoto(_ image: UIImage?) {
		photo = image
		if let image {
			view?.displayPhoto(image)			
		}
		updateSignUpButton()
	}
	
	func updateSignUpButton() {
		guard let _ = name, let _ = email, let _ = phone, let _ = photo, let _ = position else {
			view?.updateSignUpButton(false)
			return
		}
		view?.updateSignUpButton(true)
	}
}
