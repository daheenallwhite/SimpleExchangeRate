//
//  BasePickerRouter.swift
//  SimpleExchangeRate
//
//  Created by Daheen Lee on 2020/01/08.
//  Copyright © 2020 allwhite. All rights reserved.
//

import RIBs

protocol BasePickerInteractable: Interactable {
    var router: BasePickerRouting? { get set }
    var listener: BasePickerListener? { get set }
}

protocol BasePickerViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class BasePickerRouter: ViewableRouter<BasePickerInteractable, BasePickerViewControllable>, BasePickerRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: BasePickerInteractable, viewController: BasePickerViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
