//
//  HomeRouter.swift
//  SimpleExchangeRate
//
//  Created by dana.allwhite on 2020/01/06.
//  Copyright © 2020 allwhite. All rights reserved.
//

import RIBs

protocol LoggedInInteractable: Interactable, BasePickerListener, SearchListener {
    var router: LoggedInRouting? { get set }
    var listener: LoggedInListener? { get set }
}

protocol LoggedInViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class LoggedInRouter: ViewableRouter<LoggedInInteractable, LoggedInViewControllable>, LoggedInRouting {
    
    private let basePickerBuilder: BasePickerBuildable
    private let searchBuilder: SearchBuildable
    private var child: ViewableRouting?
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: LoggedInInteractable,
         viewController: LoggedInViewControllable,
         basePickerBuilder: BasePickerBuildable,
         searchBuilder: SearchBuildable) {
        self.basePickerBuilder = basePickerBuilder
        self.searchBuilder = searchBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func routeToBasePicker() {
        let basePicker = basePickerBuilder.build(withListener: interactor)
        attachChild(basePicker)
        child = basePicker
        viewController.push(basePicker.viewControllable)
    }
    
    func routeToSearch() {
        let search = searchBuilder.build(withListener: interactor)
        attachChild(search)
        child = search
        viewController.push(search.viewControllable)
    }
    
    private func detachCurrentChild() {
        if let currentChild = child {
            detachChild(currentChild)
        }
    }
}
