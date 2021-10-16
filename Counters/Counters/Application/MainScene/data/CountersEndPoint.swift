//
//  CountersEndPoint.swift
//  Counters
//
//  Created by Râmede on 11/10/21.
//

import Foundation

enum CountersEndPoint {
    case all(String)
    case increment(String, String)
    case decrement(String, String)
    case delete(String, String)
    
    var method: String {
        get {
            switch self {
            case .all:
                return "get"
            case .increment,
                 .decrement:
                return "post"
            case .delete:
                return "delete"
            }
        }
    }
    
    var endpoint: String {
        get {
            switch self {
            case .all:
                return "/api/v1/counters"
            case .increment:
                return "/api/v1/counter/inc"
            case .decrement:
                return "/api/v1/counter/dec"
            case .delete:
                return "/api/v1/counter"
            }
        }
    }
    
    var url: URL? {
        get {
            switch self {
            case .all(let baseUrl),
                 .increment(let baseUrl, _),
                 .decrement(let baseUrl, _),
                 .delete(let baseUrl, _):
                return URL(string: "\(baseUrl)\(self.endpoint)")
            }
        }
    }
    
    var parameters: [String: String]? {
        get {
        
            switch self {
            case .increment(_ , let counterId),
                 .decrement(_ , let counterId),
                 .delete(_ , let counterId):
                return ["id": counterId]
            default:
                return nil
            }
        }
    }
}
