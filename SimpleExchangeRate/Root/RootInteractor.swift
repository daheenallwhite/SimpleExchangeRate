//
//  RootInteractor.swift
//  SimpleExchangeRate
//
//  Created by dana.allwhite on 2020/01/06.
//  Copyright © 2020 allwhite. All rights reserved.
//

import RIBs
import RxSwift

protocol RootRouting: ViewableRouting {
    func routeToLoggedIn()
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
    var viewDidAppear: Observable<Bool> { get }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RootListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener {

    weak var router: RootRouting?
    weak var listener: RootListener?
    
    private var isFirstTimeLaunch = true
    private var bag = DisposeBag()

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: RootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
        presenter.viewDidAppear
            .bind { didViewAppear in
                if didViewAppear && self.isFirstTimeLaunch {
                    self.isFirstTimeLaunch.toggle()
                    self.router?.routeToLoggedIn()
                }
            }.disposed(by: bag)
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
}
