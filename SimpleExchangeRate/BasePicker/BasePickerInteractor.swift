//
//  BasePickerInteractor.swift
//  SimpleExchangeRate
//
//  Created by Daheen Lee on 2020/01/08.
//  Copyright © 2020 allwhite. All rights reserved.
//

import RIBs
import RxSwift

protocol BasePickerRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol BasePickerPresentable: Presentable {
    var listener: BasePickerPresentableListener? { get set }
}

protocol BasePickerListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class BasePickerInteractor: PresentableInteractor<BasePickerPresentable>, BasePickerInteractable, BasePickerPresentableListener {

    weak var router: BasePickerRouting?
    weak var listener: BasePickerListener?
    private var viewModel: BasePickerViewModel
    private let disposeBag = DisposeBag()

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: BasePickerPresentable, viewModel: BasePickerViewModel) {
        self.viewModel = viewModel
        super.init(presenter: presenter)
        presenter.listener = self
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
