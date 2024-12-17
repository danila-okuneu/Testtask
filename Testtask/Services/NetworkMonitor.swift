//
//  NetworkMonitor.swift
//  Testtask
//
//  Created by Danila Okuneu on 16.12.24.
//

import Network

final class NetworkMonitor {
	
	static let shared = NetworkMonitor() // Singleton
	private let monitor = NWPathMonitor()
	private let queue = DispatchQueue.global(qos: .background)
	
	private var isConnected: Bool = false
	
	private init() {
		startMonitoring()
	}
	
	private func startMonitoring() {
		monitor.start(queue: queue)
		monitor.pathUpdateHandler = { path in
			self.isConnected = path.status == .satisfied
			print("Network status: \(self.isConnected ? "Connected" : "Not connected")")
		}
	}
	
	func checkConnection(completion: @escaping (Bool) -> Void) {
		monitor.pathUpdateHandler = { path in
			self.isConnected = path.status == .satisfied
			DispatchQueue.main.async {
				completion(self.isConnected)
			}
		}
	}
}
