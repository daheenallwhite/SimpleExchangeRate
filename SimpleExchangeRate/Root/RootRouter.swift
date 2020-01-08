//
//  RootRouter.swift
//  SimpleExchangeRate
//
//  Created by dana.allwhite on 2020/01/06.
//  Copyright © 2020 allwhite. All rights reserved.
//

import RIBs

protocol RootInteractable: Interactable, LoggedInListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    
    private let loggedInBuilder: LoggedInBuildable
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: RootInteractable,
                  viewController: RootViewControllable,
                  loggedInBuilder: LoggedInBuildable) {
        
        self.loggedInBuilder = loggedInBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func routeToLoggedIn() {
        let loggedIn = loggedInBuilder.build(withListener: interactor)
        attachChild(loggedIn)
        let containerVC = UINavigationController(rootViewController: loggedIn.viewControllable.uiviewController)
        viewController.replace(viewController: containerVC)
    }
}
