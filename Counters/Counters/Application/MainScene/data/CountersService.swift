//
//  CountersService.swift
//  Counters
//
//  Created by Râmede on 11/10/21.
//

import Foundation

enum CountersError: Error {
    case parsing
}

protocol CountersService {
    func retrieveAll(
        completion: @escaping (Result<[Counter], Error>) -> Void
    )
}

final class CountersApiService {
    private let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
}

extension CountersApiService: CountersService {
    func from(data: Data) -> Counter? {
        let decoder = JSONDecoder()
        return try? decoder.decode(Counter.self, from: data)
    }
    
    func retrieveAll(
        completion: @escaping (Result<[Counter], Error>) -> Void
    ) {
        DispatchQueue.global().async {
            let endpoint = CountersEndPoint.all(self.networking.getBaseURL())
            self.networking.jsonRequest(
                endpoint.url!,
                httpMethod: endpoint.method,
                parameters: [:],
                completionHandler: {data, error in
                    if let result = data as? [[String: Any]] {
                        let counters = result.map({ el in Counter(dict: el) })
                        completion(.success(counters))
                        return
                    }
                    completion(.failure(CountersError.parsing))
            }).resume()
        }
    }
}
