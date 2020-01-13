//
//  RootViewController.swift
//  SimpleExchangeRate
//
//  Created by dana.allwhite on 2020/01/06.
//  Copyright © 2020 allwhite. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: class {
    
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {
    
    var viewDidAppear: Observable<Bool> {
        return self.rx.viewDidAppear
    }
    
    weak var listener: RootPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
    }
}
