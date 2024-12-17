//
//  NetworkMonitor.swift
//  Testtask
//
//  Created by Danila Okuneu on 16.12.24.
//

import Network

// MARK: - NetworkMonitor
/// A singleton class to monitor the network connection status using `NWPathMonitor`.
/// Provides real-time updates on the network's availability.
final class NetworkMonitor {
	
	static let shared = NetworkMonitor() // Singleton
	private let monitor = NWPathMonitor()
	private let queue = DispatchQueue.global(qos: .background)
	
	private var isConnected: Bool = false
	
	private init() {
		startMonitoring()
	}
	
	// MARK: - Start Monitoring
	/// Starts monitoring the network status on a background queue.
	/// Updates `isConnected` when the network status changes.
	private func startMonitoring() {
		monitor.start(queue: queue)
		monitor.pathUpdateHandler = { path in
			self.isConnected = path.status == .satisfied
			print("Network status: \(self.isConnected ? "Connected" : "Not connected")")
		}
	}
	
	// MARK: - Check Connection
	/// Checks the current network connection status and provides the result in a completion handler.
	/// - Parameter completion: A closure that returns a `Bool` indicating the network connection status.
	func checkConnection(completion: @escaping (Bool) -> Void) {
		monitor.pathUpdateHandler = { path in
			self.isConnected = path.status == .satisfied
			
			DispatchQueue.main.async {
				completion(self.isConnected)
			}
		}
	}
}
