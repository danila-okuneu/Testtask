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
	
	private let contentView = UIView()
	
	
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
		scrollView.addSubview(contentView)
		setupScrollView()
		
		contentView.addSubview(fieldsStackView)
		fieldsStackView.addArrangedSubview(nameTextField)
		fieldsStackView.addArrangedSubview(emailTextField)
		fieldsStackView.addArrangedSubview(phoneTextField)
		
		contentView.addSubview(selectTitle)
		contentView.addSubview(positionsList)
		setupConstraints()
		
	}
	
	private func setupConstraints() {
		
		fieldsStackView.snp.makeConstraints { make in
			make.left.right.equalToSuperview()
			make.top.equalToSuperview()

		
		}
		contentView.clipsToBounds = true
		
		selectTitle.snp.makeConstraints { make in
			make.top.equalTo(fieldsStackView.snp.bottom).offset(24)
			make.horizontalEdges.equalToSuperview()
			
		}
		
		positionsList.snp.makeConstraints { make in
			make.top.equalTo(selectTitle.snp.bottom).offset(24)
			make.horizontalEdges.equalToSuperview()
			make.bottom.equalToSuperview()
			
		}
	}
	
	private func setupScrollView() {
		
		
		scrollView.snp.makeConstraints { make in
			make.horizontalEdges.equalToSuperview().inset(Constants.contentPadding)
			make.verticalEdges.equalToSuperview()
		}
		
		contentView.snp.makeConstraints { make in
			make.width.equalToSuperview()
			make.top.equalToSuperview().offset(Constants.offset)
		}
		
	}
	
	
	
}

// MARK: - Constants
extension SignUpViewController {
	
	private struct Constants {
		
		
		static let contentPadding = 16 * CGFloat.ratio
		static let offset = 32 * CGFloat.ratio
		
		static let selectTitleFontSize = 18 * CGFloat.ratio
		
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
