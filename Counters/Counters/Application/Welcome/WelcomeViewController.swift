//
//  WelcomeViewController.swift
//  Counters
//
//

import UIKit

protocol WelcomeViewControllerPresenter {
    var viewModel: WelcomeView.ViewModel { get }
}

class WelcomeViewController: UIViewController {
    private lazy var innerView = WelcomeView()
    
    private let presenter: WelcomeViewControllerPresenter
    
    init(presenter: WelcomeViewControllerPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = innerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        additionalSafeAreaInsets = Constants.additionalInsets
        innerView.configure(with: presenter.viewModel)
        innerView.delegate = self
    }
}

private extension WelcomeViewController {
    enum Constants {
        static let additionalInsets = UIEdgeInsets(top: 26, left: 39, bottom: 20, right: 39)
    }
}

extension WelcomeViewController: WelcomeViewDelegate {
    func didPressContinue() {
        let networking = Networking.init()
        let service = CountersApiService(networking: networking)
        let interactor = CountersTableViewInteractor(service: service)
        let viewController = CountersTableViewController(interactor: interactor)
        navigationController?.pushViewController(viewController, animated: true)
    }
}


