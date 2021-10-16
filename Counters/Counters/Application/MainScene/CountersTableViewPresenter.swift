//
//  CountersTableViewPresenter.swift
//  Counters
//
//  Created by Râmede on 12/10/21.
//

import Foundation

protocol CountersTableViewPresentable: AnyObject {
    var viewController: CountersTableViewDisplayable? { get set }
    func presentCounters(with counters: [Counter])
    func presentDeleteActionSheet()
    func presentLoading(_ isLoading: Bool)
    func presentCount(indexPath: IndexPath, count: Int)
    func dismissDeletedCounters(_ countersIndex: [IndexPath?])
    func presentSummaryInfo()
    func presentError()
}

final class CountersTableViewPresenter {
    weak var viewController: CountersTableViewDisplayable?
}

extension CountersTableViewPresenter: CountersTableViewPresentable {
    func presentCounters(with counters: [Counter]) {
        viewController?.displayCounters(with: counters)
    }
    
    func presentDeleteActionSheet() {
        viewController?.displayDeleteActionSheet()
    }

    func presentLoading(_ isLoading: Bool) {
        viewController?.displayLoad(isLoading)
    }
    
    func presentCount(indexPath: IndexPath, count: Int) {
        viewController?.displayCount(indexPath: indexPath, count: count)
    }
    
    func dismissDeletedCounters(_ countersIndex: [IndexPath?]) {
        viewController?.dismissDeletedCounters(countersIndex)
    }

    func presentSummaryInfo() {
        
    }
    
    func presentError() {
        
    }
}
