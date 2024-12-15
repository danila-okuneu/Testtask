//
//  CameraManager.swift
//  Testtask
//
//  Created by Danila Okuneu on 15.12.24.
//

import AVFoundation
import UIKit

final class CameraManager {
	
	static let shared = CameraManager()
	private init() { }
	
	private var status = AVCaptureDevice.authorizationStatus(for: .video)
	var isAllowed: Bool {
		print(status)
		return status == .authorized
	}
	
	func requestPermission() async {
		
		if status == .denied {
			openSettings()
		} else {
			await AVCaptureDevice.requestAccess(for: .video)
		}
	}


	func openSettings() {
		if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
			UIApplication.shared.open(url)
		}
	}
	
	
	
}
