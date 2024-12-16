//
//  SignUpView.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

import UIKit
import SnapKit

protocol SignUpViewProtocol: AnyObject {
	
	var presenter: SignUpPresenter? { get set }
}

protocol SignUpViewInput: AnyObject {
	
	func loadPositions(_ positions: [Position])
}

protocol SignUpViewOutput: AnyObject {
	
	// Define output methods
}

// MARK: - View
final class SignUpViewController: UIViewController, SignUpViewProtocol {
	
	var presenter: SignUpPresenter?
	
	private var isLoading = true
	private var positions: [Position] = [ ]
	private var selectedIndexPath = IndexPath(row: 0, section: 0)
	
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
		tableView.register(PositionViewCell.self, forCellReuseIdentifier: PositionViewCell.identifire)
		return tableView
	}()
	
	private let uploadView = UploadView()
	
	private let signUpButton = RoundedButton(with: "Sign Up")
	
	// MARK: - Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
	
		uploadView.viewController = self
		setupViews()
		let appearance = UINavigationBarAppearance()
		appearance.backgroundColor = .accent
	
		self.navigationController?.navigationBar.backgroundColor = .accent
		self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.nunitoSans(ofSize: 24)]
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		presenter?.viewWillAppear()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		positions = [ ]
		selectedIndexPath = IndexPath(row: 0, section: 0)
	}
		
	// MARK: - Layout
	private func setupViews() {
		
		navigationItem.title = "Working with POST request"
		
		positionsTableView.delegate = self
		positionsTableView.dataSource = self
		
		view.backgroundColor = .white
		uploadView.uploadButton.addTarget(self, action: #selector(showUploadOptions), for: .touchUpInside)
		signUpButton.addTarget(self, action: #selector(registerUser), for: .touchUpInside)
		
		view.addSubview(scrollView)
		scrollView.addSubview(contentStack)
		setupScrollView()
		
		contentStack.addArrangedSubview(fieldsStackView)
		fieldsStackView.addArrangedSubview(nameTextField)
		fieldsStackView.addArrangedSubview(emailTextField)
		fieldsStackView.addArrangedSubview(phoneTextField)
		
		contentStack.addArrangedSubview(selectTitle)
		contentStack.addArrangedSubview(positionsTableView)
		contentStack.addArrangedSubview(uploadView)
		
		nameTextField.delegate = self
		
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
	
	@objc private func showUploadOptions() {
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
		
		present(alertController, animated: true)
	}
	
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
	
	@objc private func hideKeyboard() {
		self.view.endEditing(true)
	}
	
	@objc private func registerUser() {
		
		Task {
			do {
				guard let photoData = uploadView.photoImageView.image?.jpegData(compressionQuality: 0.8) else { return }
				
				let request = RegisterUserRequest(
					name: nameTextField.text,
					email: emailTextField.text,
					phone: phoneTextField.text,
					positionId: selectedIndexPath.row + 1,
					photo: photoData
				)
				
				
				let token = try await NetworkManager.shared.fetchToken()
				print(token)
				try await NetworkManager.shared.registerUser(userRequest: request, token: token)
				let vc = SignUpResultViewController(true)
				vc.modalPresentationStyle = .fullScreen
				self.present(vc, animated: true)
				
			} catch {
				let vc = SignUpResultViewController(false, message: error.localizedDescription)
				vc.modalPresentationStyle = .fullScreen
				self.present(vc, animated: true)
			}
		}
	}
}

// MARK: - PickerView Delegate
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
			if let editedImage = info[.editedImage] as? UIImage {
				uploadView.loadPhoto(editedImage)
			} else if let originalImage = info[.originalImage] as? UIImage {
				uploadView.loadPhoto(originalImage)
			}
			picker.dismiss(animated: true)
		}
		
		func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
			picker.dismiss(animated: true)
		}
	
}

// MARK: - TableView Delegate & DataSource
extension SignUpViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		isLoading ? 4 : positions.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: PositionViewCell.identifire, for: indexPath) as! PositionViewCell
		
		
		if !isLoading {
			cell.configure(with: positions[indexPath.row])
		}
		
		return cell
	}
	

	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
	
		guard let selectedCell = tableView.cellForRow(at: selectedIndexPath) as? PositionViewCell else { return }
		selectedCell.button.resetAppearance()
		
		selectedIndexPath = indexPath
		
		guard let cell = tableView.cellForRow(at: indexPath) as? PositionViewCell else { return }
		cell.button.selectedAppearance()
		
	}
	
	
	
	
}

extension SignUpViewController: SignUpTextFieldDelegate {
	
	
	func didEndEditing() {
		<#code#>
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
extension SignUpViewController: SignUpViewInput, SignUpViewOutput {
	func loadPositions(_ positions: [Position]) {
		print("Loaded")
		self.positions = positions
		isLoading = false
		DispatchQueue.main.sync {
			self.positionsTableView.reloadData()
			self.positionsTableView.layoutIfNeeded()
			self.positionsTableView.selectRow(at: selectedIndexPath, animated: true, scrollPosition: .none)
			
			guard let cell = positionsTableView.cellForRow(at: selectedIndexPath) as? PositionViewCell else { return }
			cell.select()
			
			self.positionsTableView.snp.updateConstraints { make in
				make.height.equalTo(self.positionsTableView.contentSize.height + 10)
			}
		}
	}
	
	
}



@available(iOS 17.0, *)
#Preview {
	return SignUpViewController()
}
