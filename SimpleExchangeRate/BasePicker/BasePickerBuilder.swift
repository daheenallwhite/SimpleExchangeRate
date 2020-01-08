//
//  BasePickerBuilder.swift
//  SimpleExchangeRate
//
//  Created by Daheen Lee on 2020/01/08.
//  Copyright © 2020 allwhite. All rights reserved.
//

import RIBs

protocol BasePickerDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class BasePickerComponent: Component<BasePickerDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol BasePickerBuildable: Buildable {
    func build(withListener listener: BasePickerListener) -> BasePickerRouting
}

final class BasePickerBuilder: Builder<BasePickerDependency>, BasePickerBuildable {

    override init(dependency: BasePickerDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: BasePickerListener) -> BasePickerRouting {
        let component = BasePickerComponent(dependency: dependency)
        let viewController = BasePickerViewController.instantiate()
        let interactor = BasePickerInteractor(presenter: viewController)
        interactor.listener = listener
        return BasePickerRouter(interactor: interactor, viewController: viewController)
    }
}
