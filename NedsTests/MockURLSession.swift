//
//  MockURLSession.swift
//  Neds
//
//  Created by Wael Saad on 20/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

@testable import Neds
import XCTest
import Combine

// Extension to swizzle and unswizzle URLSession.shared for testing.

// swiftlint:disable force_unwrapping

extension URLSession {
    static func swizzleSession() {
        URLProtocol.registerClass(MockURLProtocol.self)
    }
    
    static func unswizzleSession() {
        URLProtocol.unregisterClass(MockURLProtocol.self)
    }
}

class MockURLProtocol: URLProtocol {
    
    static var mockData: (Data, HTTPURLResponse)?
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        if let (data, response) = MockURLProtocol.mockData {
            self.client?.urlProtocol(
                self, didReceive: response, cacheStoragePolicy: .notAllowed
            )
            self.client?.urlProtocol(self, didLoad: data)
        }
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() { }
    
}

// Mock URLSession for testing purposes.

class MockURLSession: URLSession {

    static func makeMockSession(with data: Data, statusCode: Int) -> URLSession {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let mockSession = URLSession(configuration: config)
        
        let mockUrl = URL(string: "https://neds.com")!
        let response = HTTPURLResponse(url: mockUrl, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
        
        MockURLProtocol.mockData = (data, response)
        
        return mockSession
    }
    
}

// Mock URLSessionDataTask for testing purposes.

class MockURLSessionDataTask: URLSessionDataTask {
    override func resume() {
        // Do nothing for testing purposes.
    }
}
