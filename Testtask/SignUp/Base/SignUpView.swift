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
	
	// MARK: - UIComponents
	private let scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.alwaysBounceVertical = true
		scrollView.showsVerticalScrollIndicator = false
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
	
	private let nameTextField = SignUpTextField(placeholder: "Your name")
	private let emailTextField = SignUpTextField(placeholder: "Email")
	private let phoneTextField = SignUpTextField(placeholder: "Phone", hint: "+38 (XXX) XXX - XX - XX")
	
	private let selectTitle: UILabel = {
		let label = UILabel()
		label.text = "Select your position"
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
		setupConstraints()
		
	}
	
	private func setupConstraints() {
		
	}
	
	private func setupScrollView() {
		
		
		scrollView.snp.makeConstraints { make in
			make.horizontalEdges.equalToSuperview().inset(Constants.contentPadding)
			make.verticalEdges.equalToSuperview()
		}
		
		contentStack.snp.makeConstraints { make in
			make.width.equalToSuperview()
			make.top.equalToSuperview().offset(Constants.offset)
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
