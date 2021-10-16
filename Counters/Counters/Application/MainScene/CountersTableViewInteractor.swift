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
    func filterCounters()
    func countIncrement(countId: String?, counterIndex: IndexPath)
    func countDecrement(countId: String?, counterIndex: IndexPath)
    func deleteCounters(countersId: [String?], countersIndexes: [IndexPath?])
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

    func deleteCounters(countersIndexes: [IndexPath]) {
        presenter.dismissDeletedCounters(countersIndexes)
    }
    
    func filterCounters() {
        //TODO:
    }
    
    func createCounter() {
        //TODO:
    }
    
    func countIncrement(countId: String?, counterIndex: IndexPath) {
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
                self.presenter.presentCount(indexPath: counterIndex, count: counter.count)
            case .failure(let error):
                print("### Error ##############")
                print(error)
            }
        }
    }
    
    func countDecrement(countId: String?, counterIndex: IndexPath) {
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
                self.presenter.presentCount(indexPath: counterIndex, count: counter.count)
            case .failure(let error):
                print("### Error ##############")
                print(error)
            }
        }
    }
    
    func deleteCounters(countersId: [String?], countersIndexes: [IndexPath?]) {
        presenter.presentLoading(true)
        
        let group = DispatchGroup()
        var countersIndexesDeleted: [IndexPath] = []

        for (idx, counterId) in countersId.enumerated() {
            group.enter()
            guard let id = counterId else { return }
            
            service.delete(counterId: id) { result in
                self.presenter.presentLoading(false)
                switch result {
                case .success(_ ):
                    guard let index = countersIndexes[idx] else {
                        print("### Error ##############")
                        group.leave()
                        return
                    }
                    countersIndexesDeleted.append(index)
                    group.leave()
                case .failure(let error):
                    print("### Error ##############")
                    print(error)
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) {
            self.presenter.dismissDeletedCounters(countersIndexesDeleted)
        }
    }
}
