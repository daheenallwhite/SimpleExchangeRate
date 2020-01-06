//
//  HomeViewController.swift
//  SimpleExchangeRate
//
//  Created by dana.allwhite on 2020/01/06.
//  Copyright © 2020 allwhite. All rights reserved.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit

protocol HomePresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class HomeViewController: UIViewController, HomePresentable, HomeViewControllable {
    
    weak var listener: HomePresentableListener?
    
    // MARK: - Instantiate ViewController
    
    static func instantiate() -> HomeViewController {
        let instance = instantiate(storyboardName: "Main", identifier: "HomeViewController") as! HomeViewController
        return instance
    }
    
    @IBOutlet weak var tableView: UITableView!
       
       private let bag = DisposeBag()
       
       override func viewDidLoad() {
           super.viewDidLoad()
        
           let service = NetworkService()
           
           let rates = service.getRates(for: .USD)
               .map { result -> [String] in
                   print(result)
                   guard case .success(let value) = result else {
                       return []
                   }
                   return value.ratesString
               }
               .share(replay: 1)
               .observeOn(MainScheduler.instance)
           
           rates.bind(to: tableView.rx.items(cellIdentifier: "Cell")) { row, model, cell in
               cell.textLabel?.text = model
           }.disposed(by: bag)
           
       }
}
