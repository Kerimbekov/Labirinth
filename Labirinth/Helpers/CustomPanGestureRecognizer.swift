//
//  CustomPanGestureRecognizer.swift
//  Labirinth
//
//  Created by Нуржан Керимбеков on 2021-12-19.
//

import Foundation
import UIKit

class CustomPanGestureRecognizer:UIPanGestureRecognizer{
    var model:ItemProtocol
    
    init(target: Any?, action: Selector?, item:ItemProtocol) {
        self.model = item
        super.init(target: target, action: action)
    }
}
