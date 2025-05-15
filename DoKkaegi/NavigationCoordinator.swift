//
//  NavigationCoordinator.swift
//  DoKkaegi
//
//  Created by Martin on 5/10/25.
//

import SwiftUI

@Observable
class NavigationCoordinator {
    var path: NavigationPath = .init()
    
    func push(appPath: AppPath) {
        path.append(appPath)
    }
    
    func removeLast(count: Int = 1) {
        guard count < path.count else {
            return
        }
        path.removeLast(count)
    }
}


enum AppPath: Hashable {
    case loading
    case finding
    case result
    case record
}
