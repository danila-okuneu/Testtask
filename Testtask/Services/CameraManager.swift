//
//  CameraManager.swift
//  Testtask
//
//  Created by Danila Okuneu on 15.12.24.
//

import AVFoundation
import UIKit

// MARK: - CameraManager Class
/// A singleton class to manage camera permissions and access status.
final class CameraManager {
	
	static let shared = CameraManager()
	private init() { }
	
	// MARK: - Authorization Status
	/// Stores the current authorization status for the camera.
	/// It initializes with the current permission status when the CameraManager is first accessed.
	private var status = AVCaptureDevice.authorizationStatus(for: .video)
	var isAllowed: Bool {
		let currentStatus = AVCaptureDevice.authorizationStatus(for: .video)
		return currentStatus == .authorized
	}
	
	// MARK: - Request Permission
	/// Requests access to the camera.
	/// If access is denied, it opens the app settings; otherwise, it requests access asynchronously.
	func requestPermission() async {
		if status == .denied {
			openSettings()
		} else {
			let granted = await AVCaptureDevice.requestAccess(for: .video)
			status = AVCaptureDevice.authorizationStatus(for: .video)
		}
	}

	// MARK: - Open Settings
	/// Opens the app settings in case the user has denied camera permissions.
	func openSettings() {
		if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
			UIApplication.shared.open(url)
		}
	}
}
