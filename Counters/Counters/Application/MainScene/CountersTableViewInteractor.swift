//
//  CountersTableViewInteractor.swift
//  Counters
//
//  Created by Râmede on 11/10/21.
//

import Foundation

protocol CountersTableViewInteractable: AnyObject {
    func loadInitialInfo()
    func getCounters()
    func deleteCounters()
    func filterCounters()
}

final class CountersTableViewInteractor {
    private let service: CountersService
    
    init(service: CountersService) {
        self.service = service
    }
}

extension CountersTableViewInteractor: CountersTableViewInteractable {
    func loadInitialInfo() {
        
    }

    func deleteCounters() {
        //TODO:
    }
    
    func filterCounters() {
        //TODO:
    }
    
    func createCounter() {
        //TODO:
    }
        
    func getCounters() {
        service.retrieveAll() { result in
            switch result {
            case .success(let response):
                print("### Response ##############")
                print(response)
            case .failure(let error):
                print("### Error ##############")
                print(error)
            }
        }
    }
}


