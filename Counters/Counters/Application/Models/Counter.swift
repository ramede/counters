//
//  Counter.swift
//  Counters
//
//  Created by Râmede on 11/10/21.
//

struct Counter: Decodable {
    var id: String
    var title: String
    var count: Int
}

extension Counter {
    init(dict : [String: Any]) {
        title = dict["title"] as? String ?? ""
        id = dict["id"] as? String ?? ""
        count = dict["count"] as? Int ?? 0
    }
}
