//
//  CountersEndPoint.swift
//  Counters
//
//  Created by Râmede on 11/10/21.
//

import Foundation

enum CountersEndPoint {
    case all(String)

    var method: String {
        get {
          switch self {
          case .all:
             return "get"
          }
        }
    }

    var endpoint: String {
        get {
          switch self {
          case .all:
             return "/api/v1/counters"
          }
        }
    }
    
    var url: URL? {
        get {
          switch self {
          case .all(let baseUrl):
            return URL(string: "\(baseUrl)\(self.endpoint)")
          }
        }
    }
}
