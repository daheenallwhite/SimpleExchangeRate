//
//  ViewControllable+Rx.swift
//  SimpleExchangeRate
//
//  Created by dana.allwhite on 2020/01/29.
//  Copyright © 2020 allwhite. All rights reserved.
//

import RIBs
import RxSwift

extension ViewControllable {
    var viewDidLoad: Observable<Void>{
        return self.uiviewController.rx.viewDidLoad
    }
    
    var viewWillAppear: Observable<Bool> {
        return self.uiviewController.rx.viewWillAppear
    }
    
    var viewDidAppear: Observable<Bool> {
        return self.uiviewController.rx.viewDidAppear
    }
    
    var viewWillDisappear: Observable<Bool> {
        return self.uiviewController.rx.viewWillDisappear
    }
    
    var viewDidDisappear: Observable<Bool> {
        return self.uiviewController.rx.viewDidDisappear
    }
}


