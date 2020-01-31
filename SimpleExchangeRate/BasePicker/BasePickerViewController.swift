//
//  BasePickerViewController.swift
//  SimpleExchangeRate
//
//  Created by Daheen Lee on 2020/01/08.
//  Copyright © 2020 allwhite. All rights reserved.
//

import RIBs
import RxSwift
import RxCocoa
import RxAppState
import RxDataSources

protocol BasePickerPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class BasePickerViewController: UIViewController, BasePickerPresentable, BasePickerViewControllable {
    weak var listener: BasePickerPresentableListener?

    static func instantiate(with viewModel: BasePickerViewModel) -> BasePickerViewController {
        let instance = instantiate(storyboardName: "BasePickerViewController", identifier: "BasePickerViewController") as! BasePickerViewController
        instance.viewModel = viewModel
        return instance
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let exchangeRateAPI = ExchangeRateAPI.shared
    private let bag = DisposeBag()
    var viewModel: BasePickerViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable.just(CurrencyCode.allCases)
            .bind(to: pickerView.rx.itemTitles) { _, code in
                return code.rawValue
            }.disposed(by: bag)
        
        bind()
   }

    private func bind() {
        guard let viewModel = self.viewModel else {
            return
        }
        
        pickerView.rx.modelSelected(CurrencyCode.self)
            .map { (codes) -> CurrencyCode in
                return codes[0]
            }.bind(to: viewModel.baseCurrencyCode)
            .disposed(by: bag)
        
        viewModel.lastUpdatedTime
            .drive(onNext: { time in
            self.timeLabel.text = time
            })
            .disposed(by: bag)
        
        viewModel.loading
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: bag)

        viewModel.loading
            .drive(onNext: { isLoading in
                self.tableView.isHidden = isLoading
            }).disposed(by: bag)
        
        viewModel.exchangeRates.map {
            return [SectionModel(model: "\(viewModel.baseCurrencyCode.value)", items: $0)]
        }.drive(tableView.rx.items(dataSource: dataSource))
        .disposed(by: bag)
    }

}
