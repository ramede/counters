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
    func countIncrement(countId: String?, indexPath: IndexPath)
    func countDecrement(countId: String?, indexPath: IndexPath)
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
    
    func countIncrement(countId: String?, indexPath: IndexPath) {
        guard let countId = countId else { return }
        presenter.presentLoading(true)
        service.increment(counterId: countId) { result in
            self.presenter.presentLoading(false)
            switch result {
            case .success(let counters):
                guard let counter = counters.filter({ $0.id == countId}).first else {
                    print("### Error ##############")
                    return
                }
                self.presenter.presentCount(indexPath: indexPath, count: counter.count)
            case .failure(let error):
                print("### Error ##############")
                print(error)
            }
        }
    }
    
    func countDecrement(countId: String?, indexPath: IndexPath) {
        guard let countId = countId else { return }
        presenter.presentLoading(true)
        service.decrement(counterId: countId) { result in
            self.presenter.presentLoading(false)
            switch result {
            case .success(let counters):
                guard let counter = counters.filter({ $0.id == countId}).first else {
                    print("### Error ##############")
                    return
                }
                self.presenter.presentCount(indexPath: indexPath, count: counter.count)
            case .failure(let error):
                print("### Error ##############")
                print(error)
            }
        }
    }
}


