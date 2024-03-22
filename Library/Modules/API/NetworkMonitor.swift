//
//  NetworkMonitor.swift
//  Neds
//
//  Created by Wael Saad on 17/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Network
import Combine
import UIKit

protocol NetworkMonitorProtocol {
    func start()
    func stop()
    var isConnected: Bool { get }
    var isExpensive: Bool { get }
    var currentConnectionType: NWInterface.InterfaceType? { get }
}

// MARK: - Interface Type

extension NWInterface.InterfaceType: CaseIterable {
    
    public static var allCases: [NWInterface.InterfaceType] = [
        .other,
        .wifi,
        .cellular,
        .loopback,
        .wiredEthernet
    ]
    
}

final class NetworkMonitor: ObservableObject, NetworkMonitorProtocol {

    // MARK: - Private Properties

    private var cancellables = Set<AnyCancellable>()
    private let monitor: NWPathMonitor
    private let queue = DispatchQueue(label: "InternetConnectivityStatus")
    private(set) var isConnected = true // Defaulting to true for initial state, update as per actual connectivity status
    private(set) var isExpensive = false // Defaulting to false, update based on network cost
    private(set) var currentConnectionType: NWInterface.InterfaceType?

    // MARK: - Lifecycle

    init() {
        monitor = NWPathMonitor()
        setupNotifications() // Set up notifications for app foreground/background events
        start() // Start monitoring network connectivity
    }

    func start() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self else { return }
            self.isConnected = path.status == .satisfied // Update connectivity status based on path status
            self.isExpensive = path.isExpensive // Update network cost status
            self.currentConnectionType = NWInterface
                .InterfaceType.allCases.filter { path.usesInterfaceType($0) }.first // Determine current connection type
            NotificationCenter.default.post(name: .connectivityStatus, object: nil) // Notify observers about connectivity status change
        }
        monitor.start(queue: queue) // Start monitoring
    }

    func stop() {
        monitor.cancel() // Stop monitoring network connectivity
    }

}

// MARK: - Notifications

private extension NetworkMonitor {

    func setupNotifications() {
        
        // Subscribe to foreground notification to start monitoring again
        NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)
            .sink { [weak self] _ in self?.start() } // Start monitoring on app foreground
            .store(in: &cancellables) // Store the subscription for later cleanup
        
        // Subscribe to background notification to stop monitoring
        NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)
            .sink { [weak self] _ in self?.stop() } // Stop monitoring on app background
            .store(in: &cancellables) // Store the subscription for later cleanup

    }

}
