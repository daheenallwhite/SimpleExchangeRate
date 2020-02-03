//
//  LoggedInComponent+Search.swift
//  SimpleExchangeRate
//
//  Created by Daheen Lee on 2020/01/08.
//  Copyright © 2020 allwhite. All rights reserved.
//

import RIBs

/// The dependencies needed from the parent scope of LoggedIn to provide for the Search scope.
// TODO: Update LoggedInDependency protocol to inherit this protocol.
protocol LoggedInDependencySearch: Dependency {
    // TODO: Declare dependencies needed from the parent scope of LoggedIn to provide dependencies
    // for the Search scope.
}

extension LoggedInComponent: SearchDependency {

    // TODO: Implement properties to provide for Search scope.
}
