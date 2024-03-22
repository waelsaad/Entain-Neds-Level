//
//  Decodable+.swift
//  Library
//
//  Created by Wael Saad on 15/12/2020.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation

// MARK: Usage

//    if let form = try? request?.body.data(using: .utf8)?.decodeJSON(type: API.Request.self) {
//        fields = form.fields
//        print(form.fields)
//    }
//
//    if let form = try? API.Request(data: request?.body.data(using: .utf8) ?? .defaultValue) {
//        fields = form.fields
//        print(form.fields)
//    }

extension Decodable {
    
    //    init(data: Data, using decoder: JSONDecoder = JSONDecoder()) throws {
    //        self = try decoder.decode(Self.self, from: data)
    //    }
    
    init(data: Data, using decoder: JSONDecoder = JSONDecoder()) throws {
        do {
            _ = try decoder.decode(Self.self, from: data)
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
        self = try decoder.decode(Self.self, from: data)
    }
    
    static func decodeDebug(value: String) -> Self? {
        let data = value.data
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            _ = try decoder.decode(self, from: data)
            // print("result:", result)
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("Error: failed to parse data", error)
        }
        
        guard
            let output = try? decoder.decode(self, from: data)
        else {
            print("Error: failed to decodeDebug")
            return nil
        }
        
        return output
    }
    
    static func decode(value: String) -> Self? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard
            let output = try? decoder.decode(self, from: Data(value.utf8))
        else { return nil }
        return output
    }
    
    static func decode(fileName: String) -> Self? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard
            let url = Bundle.main.url(
                forResource: fileName,
                withExtension: FileExtension.json.value
            ),
            let data = try? Data(contentsOf: url),
            let output = try? decoder.decode(self, from: data)
        else {
            print("Error: failed to decode " + fileName)
            return nil
        }
        
        return output
    }
    
    static func parse(fileName: String) -> String {
        guard
            let url = Bundle.main.url(
                forResource: fileName,
                withExtension: FileExtension.json.value
            ),
            let data = try? Data(contentsOf: url)
        else {
            print("Error: failed to parse " + fileName)
            return .empty
        }
        return String(decoding: data, as: UTF8.self)
    }
    
}
