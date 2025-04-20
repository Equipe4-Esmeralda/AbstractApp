//
//  TimeLineRouter.swift
//  AbstractApp
//
//  Created by Silvano Maneck Malfatti on 05/04/25.
//

import Foundation

class TimelineRouter {
    
    private weak var viewController: TimelineViewController?
    
    init(viewController: TimelineViewController?) {
        self.viewController = viewController
    }
}
