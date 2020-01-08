//
//  HomeRouter.swift
//  SimpleExchangeRate
//
//  Created by dana.allwhite on 2020/01/06.
//  Copyright © 2020 allwhite. All rights reserved.
//

import RIBs

protocol LoggedInInteractable: Interactable, BasePickerListener {
    var router: LoggedInRouting? { get set }
    var listener: LoggedInListener? { get set }
}

protocol LoggedInViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class LoggedInRouter: ViewableRouter<LoggedInInteractable, LoggedInViewControllable>, LoggedInRouting {
    
    private let basePickerBuilder: BasePickerBuildable
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: LoggedInInteractable,
         viewController: LoggedInViewControllable,
         basePickerBuilder: BasePickerBuildable) {
        self.basePickerBuilder = basePickerBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func routeToBasePicker() {
        let basePicker = basePickerBuilder.build(withListener: interactor)
        attachChild(basePicker)
        viewController.push(basePicker.viewControllable)
    }
}
