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
	
	// MARK: - UI Components
	private let scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.alwaysBounceVertical = true
		scrollView.showsVerticalScrollIndicator = false
		scrollView.contentInset = UIEdgeInsets(
			top: Constants.offset,
			left: 0,
			bottom: Constants.offset,
			right: 0
		)
		return scrollView
	}()
	
	private let contentStack: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.spacing = Constants.stackSpacing
		return stack
	}()
	
	
	private let fieldsStackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.spacing = Constants.offset
		return stack
		
	}()
	
	private let nameTextField = SignUpTextField(placeholder: "Your name", ofType: .name)
	private let emailTextField = SignUpTextField(placeholder: "Email", ofType: .email)
	private let phoneTextField = SignUpTextField(placeholder: "Phone", supporting: "+38 (XXX) XXX - XX - XX", ofType: .phone)
	
	private let selectTitle: UILabel = {
		let label = UILabel()
		label.text = "Select your position"
		label.textColor = .primaryText
		label.font = .nunitoSans(ofSize: Constants.selectTitleFontSize)
		return label
	}()
	
	private let positionsList = PositionsList(
		positions: "Frontend developer",
		"Backend developer",
		"Designer",
		"QA"
	)
	
	private let uploadView = UploadView()
	
	private let signUpButton = RoundedButton(with: "Sign Up")
	
	// MARK: - Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
	
		setupViews()
		let appearance = UINavigationBarAppearance()
		appearance.backgroundColor = .accent
	
		self.navigationController?.navigationBar.backgroundColor = .accent
		self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.nunitoSans(ofSize: 24)]
	}
	
	// MARK: - Layout
	private func setupViews() {
		
		
		
		navigationItem.title = "Working with POST request"
		
		view.backgroundColor = .white
		
		view.addSubview(scrollView)
		scrollView.addSubview(contentStack)
		setupScrollView()
		
		contentStack.addArrangedSubview(fieldsStackView)
		fieldsStackView.addArrangedSubview(nameTextField)
		fieldsStackView.addArrangedSubview(emailTextField)
		fieldsStackView.addArrangedSubview(phoneTextField)
		
		contentStack.addArrangedSubview(selectTitle)
		contentStack.addArrangedSubview(positionsList)
		contentStack.addArrangedSubview(uploadView)
		
		let buttonContainer = UIView()
		buttonContainer.addSubview(signUpButton)
		
		contentStack.addArrangedSubview(buttonContainer)
		
	
		setupConstraints()
		
	}
	
	private func setupConstraints() {
		
		signUpButton.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.verticalEdges.equalToSuperview()
		}
	}
	
	private func setupScrollView() {
		
		
		scrollView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide)
			make.horizontalEdges.equalToSuperview().inset(Constants.contentPadding)
			make.bottom.equalToSuperview()
		}
		
		contentStack.snp.makeConstraints { make in
			make.width.equalToSuperview()
			make.top.equalToSuperview()
			make.bottom.equalToSuperview()
		}
		
		
	}
	
	
	
}

// MARK: - Constants
extension SignUpViewController {
	
	private struct Constants {
		
		private static let ratio = CGFloat.ratio
		
		static let contentPadding = 16 * ratio
		static let offset = 32 * ratio
		static let stackSpacing = 24 * ratio
		static let selectTitleFontSize = 18 * ratio
		
	}
	
}

// MARK: - Input & Output
extension SignUpViewController: SignUpViewInputs, SignUpViewOutputs {
	
	// Extend functionality
}



@available(iOS 17.0, *)
#Preview {
	return SignUpViewController()
}
