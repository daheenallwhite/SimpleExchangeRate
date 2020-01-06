//
//  ViewController.swift
//  SimpleExchangeRate
//
//  Created by Daheen Lee on 2020/01/02.
//  Copyright © 2020 allwhite. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let service = NetworkService()
        
        let rates = service.getRates(for: .USD)
            .map { result -> [String] in
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

