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
        
    }
    
    func presentLoading(_ isLoading: Bool) {
        viewController?.displayLoad(isLoading)
    }
    
    func presentSummaryInfo() {
        
    }
    
    func presentError() {
        
    }
}
