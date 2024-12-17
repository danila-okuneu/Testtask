//
//  SignUpView.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

import UIKit
import SnapKit

protocol SignUpViewProtocol: AnyObject {
	
	var presenter: SignUpViewOutput? { get set }
}

protocol SignUpViewInputs: AnyObject {
	
	func displayPositions(_ positions: [Position])
	func displayError(_ message: String, for type: TextFieldType)
	func clearFieldError(_ type: TextFieldType)
	func displayUploadOptions()
	func displayPhoto(_ image: UIImage)
	func displayRegisterActivity()
	func hideRegisterActivity()
	func displaySuccessScreen()
	func displayFailureScreen(_ message: String)
	func updateSignUpButton(_ isActive: Bool)
}

protocol SignUpViewOutput: AnyObject {
	
	func viewWillAppear()
	func didTabSignUpButton()
	func didChangeField(_ text: String, ofType type: TextFieldType)
	func didSelectPosition(at index: Int)
	func didTapUpload()
	func didPickPhoto(_ image: UIImage?)
}

// MARK: - View
final class SignUpViewController: UIViewController, SignUpViewProtocol {
	
	var presenter: SignUpViewOutput?
	
	private var isLoading = true
	private var positions: [Position] = [ ]
	private var selectedIndexPath = IndexPath(row: 0, section: 0)
	private var registerActivityAlert: UIAlertController?
	
	// MARK: - UI Components
	private let imageView = UIImageView()
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
	
	private let positionsTableView: UITableView = {
		let tableView = UITableView()
		tableView.separatorStyle = .none
		tableView.isScrollEnabled = false
		tableView.selectionFollowsFocus = true
		tableView.backgroundColor = .white
		tableView.register(PositionViewCell.self, forCellReuseIdentifier: PositionViewCell.identifire)
		return tableView
	}()
	
	private let uploadPhotoView = UploadView()
	
	private let signUpButton = MainButton(with: "Sign Up")
	
	// MARK: - Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
	
		uploadPhotoView.viewController = self
		setupViews()
		signUpButton.disable()
		let appearance = UINavigationBarAppearance()
		appearance.backgroundColor = .accent
	
		self.navigationController?.navigationBar.backgroundColor = .accent
		self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.nunitoSans(ofSize: 24)]
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		presenter?.viewWillAppear()
	}
	// MARK: - Layout
	private func setupViews() {
		
		view.backgroundColor = .white
		navigationItem.title = "Working with POST request"
		
		positionsTableView.delegate = self
		positionsTableView.dataSource = self
		
		
		uploadPhotoView.uploadButton.addTarget(self, action: #selector(showUploadOptions), for: .touchUpInside)
		signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
		
		view.addSubview(scrollView)
		scrollView.addSubview(contentStack)
		setupScrollView()
		contentStack.addArrangedSubviews(fieldsStackView, selectTitle, positionsTableView, uploadPhotoView)
		fieldsStackView.addArrangedSubviews(nameTextField, emailTextField, phoneTextField)
		
		nameTextField.delegate = self
		emailTextField.delegate = self
		phoneTextField.delegate = self
		uploadPhotoView.delegate = self
		
		let buttonContainer = UIView()
		buttonContainer.addSubview(signUpButton)
		
		contentStack.addArrangedSubview(buttonContainer)
		
		let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
		gesture.cancelsTouchesInView = false
		contentStack.addGestureRecognizer(gesture)
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
	
	// MARK: - Methods
	private func openImagePicker(sourceType: UIImagePickerController.SourceType) {
		guard UIImagePickerController.isSourceTypeAvailable(sourceType) else { return }
		
		if CameraManager.shared.isAllowed {
			let picker = UIImagePickerController()
			picker.sourceType = sourceType
			picker.allowsEditing = true
			picker.delegate = self
			present(picker, animated: true)
		} else {
			Task {
				await CameraManager.shared.requestPermission()
			}
		}
	}
	
	// MARK: - Button Targets
	@objc private func showUploadOptions() {
		
		uploadPhotoView.uploadButton.didTapped()
		uploadPhotoView.setNormalAppearance()
		presenter?.didTapUpload()
	}

	@objc private func hideKeyboard() {
		self.view.endEditing(true)
	}
	
	@objc private func signUpButtonTapped() {
		signUpButton.didTapped()
		presenter?.didTabSignUpButton()
	}
}

// MARK: - View Inputs
extension SignUpViewController: SignUpViewInputs {
	
	func displayRegisterActivity() {
		let alert = UIAlertController(title: "Registering user", message: nil, preferredStyle: .alert)
		
		let activityView = UIActivityIndicatorView(style: .medium)
		activityView.color = .gray
		activityView.startAnimating()
		
		alert.view.addSubview(activityView)
		activityView.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.bottom.equalToSuperview().offset(-30)
		}
		alert.view.snp.makeConstraints { make in
			make.height.equalTo(120)
		}
		
		self.registerActivityAlert = alert
		present(alert, animated: true)
		
	}
	
	func hideRegisterActivity() {
		DispatchQueue.main.sync {
			registerActivityAlert?.dismiss(animated: true)
		}
		registerActivityAlert = nil
	}
	
	func displayPhoto(_ image: UIImage) {
		uploadPhotoView.loadPhoto(image)
	}
	
	
	func displayError(_ message: String, for type: TextFieldType) {
		switch type {
		case .name:
			nameTextField.showError(with: message)
			nameTextField.resetPlaceholder()
		case .email:
			emailTextField.showError(with: message)
			emailTextField.resetPlaceholder()
		case .phone:
			phoneTextField.showError(with: message)
			phoneTextField.resetPlaceholder()
		case .photo:
			uploadPhotoView.showError(with: message)
		}
	}

	func clearFieldError(_ type: TextFieldType) {
		switch type {
		case .name:
			nameTextField.setNormalAppearance()
			nameTextField.resetPlaceholder()
		case .email:
			emailTextField.setNormalAppearance()
			emailTextField.resetPlaceholder()
		case .phone:
			phoneTextField.setNormalAppearance()
			phoneTextField.resetPlaceholder()
		case .photo:
			uploadPhotoView.setNormalAppearance()
		}
	}
	
	func displayPositions(_ positions: [Position]) {
		guard self.positions != positions else { return }
		self.positions = positions
		
		DispatchQueue.main.sync {
			self.positionsTableView.reloadData()
			self.positionsTableView.layoutIfNeeded()
			self.positionsTableView.selectRow(at: selectedIndexPath, animated: true, scrollPosition: .none)
			presenter?.didSelectPosition(at: 0)
			
			guard let cell = positionsTableView.cellForRow(at: selectedIndexPath) as? PositionViewCell else { return }
			cell.select()
			
			self.positionsTableView.snp.updateConstraints { make in
				make.height.equalTo(self.positionsTableView.contentSize.height + 10)
			}
		}
	}
	
	func displayTextFieldError(_ message: String, for supportedView: SupportedView) {
		supportedView.showError(with: message)
	}
	
	func displayUploadOptions() {
		let alertController = UIAlertController(title: "Choose how you want to add a photo", message: nil, preferredStyle: .actionSheet)
		let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
			self.openImagePicker(sourceType: .camera)
		}
		let galleryAction = UIAlertAction(title: "Gallery", style: .default) { _ in
			self.openImagePicker(sourceType: .photoLibrary)
		}
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
		alertController.addAction(cameraAction)
		alertController.addAction(galleryAction)
		alertController.addAction(cancelAction)
		alertController.view.tintColor = .systemBlue
		
		present(alertController, animated: true)
	}
	
	func displaySuccessScreen() {
		DispatchQueue.main.sync {
			let vc = SignUpResultViewController(true)
			vc.modalPresentationStyle = .fullScreen
			present(vc, animated: true)
		}
	}
	
	func displayFailureScreen(_ message: String) {
		DispatchQueue.main.sync {
			let vc = SignUpResultViewController(false, message: message)
			vc.modalPresentationStyle = .fullScreen
			present(vc, animated: true)
		}
	}
	
	func updateSignUpButton(_ isActive: Bool) {
		if isActive {
			signUpButton.enable()
		} else {
			signUpButton.disable()
		}

		
	}
}

// MARK: - PickerView Delegate
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
			if let editedImage = info[.editedImage] as? UIImage {
				presenter?.didPickPhoto(editedImage)
			} else if let originalImage = info[.originalImage] as? UIImage {
				presenter?.didPickPhoto(originalImage)
			}
			picker.dismiss(animated: true)
		}
		
		func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
			picker.dismiss(animated: true)
		}
}

// MARK: - TableView DataSource
extension SignUpViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		positions.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: PositionViewCell.identifire, for: indexPath) as! PositionViewCell
		
			cell.configure(with: positions[indexPath.row])
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
	
		guard let cell = tableView.cellForRow(at: indexPath) as? PositionViewCell else { return }
		presenter?.didSelectPosition(at: indexPath.row)
		cell.button.selectedAppearance()
		
	}
	
	func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		guard let cell = tableView.cellForRow(at: indexPath) as? PositionViewCell else { return }
		cell.button.resetAppearance()
	}
}

// MARK: - TextField Delegate
extension SignUpViewController: SignUpTextFieldDelegate {
	func didEndEditing(_ sender: SignUpTextField) {
		presenter?.didChangeField(sender.text, ofType: sender.type)
	}
}

extension SignUpViewController: UploadViewDelegate {	
	
	
	func didRemovePhoto() {
		presenter?.didPickPhoto(nil)
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


@available(iOS 17.0, *)
#Preview {
	return SignUpViewController()
}
