//
//  SearchViewController.swift
//  SimpleExchangeRate
//
//  Created by Daheen Lee on 2020/02/03.
//  Copyright © 2020 allwhite. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol SearchPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class SearchViewController: UIViewController, SearchPresentable, SearchViewControllable {

    weak var listener: SearchPresentableListener?
    
    static func instantiate() -> SearchViewController {
        let instance = instantiate(storyboardName: "SearchViewController", identifier: "SearchViewController") as! SearchViewController
        return instance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
    }
}
