//
//  BasePickerViewController.swift
//  SimpleExchangeRate
//
//  Created by Daheen Lee on 2020/01/08.
//  Copyright © 2020 allwhite. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol BasePickerPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class BasePickerViewController: UIViewController, BasePickerPresentable, BasePickerViewControllable {

    weak var listener: BasePickerPresentableListener?

    static func instantiate() -> BasePickerViewController {
        let instance = instantiate(storyboardName: "BasePickerView", identifier: "BasePickerViewController") as! BasePickerViewController
        return instance
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    
    private let exchangeRateAPI = ExchangeRateAPI.shared
    private let allCurrencyCodes = CurrencyCode.allCases
    private let bag = DisposeBag()
    private let viewModel = HomeViewModel()
       
    override func viewDidLoad() {
        super.viewDidLoad()
        Observable.just(allCurrencyCodes)
               .bind(to: pickerView.rx.itemTitles) { _, code in
                   return code.rawValue
               }
               .disposed(by: bag)
               
       pickerView.rx.modelSelected(CurrencyCode.self)
           .map { (codes) -> CurrencyCode in
               return codes[0]
           }.bind(to: viewModel.baseCurrencySelected)
           .disposed(by: bag)
           
       
       viewModel.selectedCurrencyRates
           .drive(tableView.rx.items(cellIdentifier: "Cell")){ row, model, cell in
           cell.detailTextLabel?.text = model.rate
           cell.textLabel?.text = model.code
           
       }.disposed(by: bag)
       
       viewModel.lastUpdatedTime
           .drive(onNext: { (string) in
               self.timeLabel.text = string
           }).disposed(by: bag)
   }
    
}
