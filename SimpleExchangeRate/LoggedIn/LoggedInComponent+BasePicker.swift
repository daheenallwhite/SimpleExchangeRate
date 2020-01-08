//
//  LoggedInComponent+BasePicker.swift
//  SimpleExchangeRate
//
//  Created by Daheen Lee on 2020/01/08.
//  Copyright © 2020 allwhite. All rights reserved.
//

import RIBs

/// The dependencies needed from the parent scope of LoggedIn to provide for the BasePicker scope.
// TODO: Update LoggedInDependency protocol to inherit this protocol.
protocol LoggedInDependencyBasePicker: Dependency {
    // TODO: Declare dependencies needed from the parent scope of LoggedIn to provide dependencies
    // for the BasePicker scope.
}

extension LoggedInComponent: BasePickerDependency {

    // TODO: Implement properties to provide for BasePicker scope.
}
