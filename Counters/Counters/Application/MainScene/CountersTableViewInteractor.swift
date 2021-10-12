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
    private let presenter: CountersTableViewPresentable
    private let service: CountersService
    
    init(presenter: CountersTableViewPresentable,
         service: CountersService) {
        self.presenter = presenter
        self.service = service
    }
}

extension CountersTableViewInteractor: CountersTableViewInteractable {
    func loadInitialInfo() {
        getCounters()
    }

    func getCounters() {
        presenter.presentLoading(true)
        service.retrieveAll() { result in
            self.presenter.presentLoading(false)
            switch result {
            case .success(let counters):
                self.presenter.presentCounters(with: counters)
            case .failure(let error):
                print("### Error ##############")
                print(error)
            }
        }
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
}


