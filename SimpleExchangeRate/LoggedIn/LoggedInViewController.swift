//
//  LoggedInViewController.swift
//  SimpleExchangeRate
//
//  Created by dana.allwhite on 2020/01/06.
//  Copyright © 2020 allwhite. All rights reserved.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit

protocol LoggedInPresentableListener: class {
    func didSelectBasePicker()
    func didSelectSearch()
    func didSelectConversion()
}

final class LoggedInViewController: UIViewController, LoggedInPresentable, LoggedInViewControllable {
    
    weak var listener: LoggedInPresentableListener?
    
    // MARK: - Instantiate ViewController
    
    @IBOutlet weak var tableView: UITableView!
    
    private let menu = ["BasePicker", "Search", "Conversion"]
    
    static func instantiate() -> LoggedInViewController {
        let instance = instantiate(storyboardName: "LoggedInView", identifier: "LoggedInViewController") as! LoggedInViewController
        return instance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
    }
    
}

extension LoggedInViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        cell.textLabel?.text = menu[indexPath.row]
        return cell
    }
}

extension LoggedInViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listener?.didSelectBasePicker()
    }
}

