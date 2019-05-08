//
//  NewsFeedRouter.swift
//  testApp
//
//  Created by Alexander Galkin on 26/04/2019.
//  Copyright © 2019 Alexander Galkin. All rights reserved.
//

import Foundation
import UIKit

protocol NewsFeedRouterProtocol: class {
}

class NewsFeedRouter: NewsFeedRouterProtocol {
    
    weak var viewController: NewsFeedViewController!
    
    required init(viewController: NewsFeedViewController){
        self.viewController = viewController
    }
    
}
