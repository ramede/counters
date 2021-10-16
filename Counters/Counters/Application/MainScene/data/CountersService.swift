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
    
    func increment(
        counterId: String,
        completion: @escaping (Result<[Counter], Error>) -> Void
    )
    
    func decrement(
        counterId: String,
        completion: @escaping (Result<[Counter], Error>) -> Void
    )

    func delete(
        counterId: String,
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
    func retrieveAll(
        completion: @escaping (Result<[Counter], Error>) -> Void
    ) {
        DispatchQueue.global().async {
            let endpoint = CountersEndPoint.all(self.networking.getBaseURL())
            self.networking.jsonRequest(
                endpoint.url!,
                httpMethod: endpoint.method,
                parameters: endpoint.parameters,
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
    
    func increment(
        counterId: String,
        completion: @escaping (Result<[Counter], Error>) -> Void
    ) {
        DispatchQueue.global().async {
            let endpoint = CountersEndPoint.increment(self.networking.getBaseURL(), counterId)
            self.networking.jsonRequest(
                endpoint.url!,
                httpMethod: endpoint.method,
                parameters: endpoint.parameters,
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

    func decrement(
        counterId: String,
        completion: @escaping (Result<[Counter], Error>) -> Void
    ) {
        DispatchQueue.global().async {
            let endpoint = CountersEndPoint.decrement(self.networking.getBaseURL(), counterId)
            self.networking.jsonRequest(
                endpoint.url!,
                httpMethod: endpoint.method,
                parameters: endpoint.parameters,
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
    
    func delete(
        counterId: String,
        completion: @escaping (Result<[Counter], Error>) -> Void
    ) {
        DispatchQueue.global().async {
            let endpoint = CountersEndPoint.delete(self.networking.getBaseURL(), counterId)
            self.networking.jsonRequest(
                endpoint.url!,
                httpMethod: endpoint.method,
                parameters: endpoint.parameters,
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
