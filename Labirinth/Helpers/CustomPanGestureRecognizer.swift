//
//  CustomPanGestureRecognizer.swift
//  Labirinth
//
//  Created by Нуржан Керимбеков on 2021-12-19.
//

import Foundation
import UIKit

class CustomPanGestureRecognizer:UIPanGestureRecognizer{
    var model:Item
    
    init(target: Any?, action: Selector?, item:Item) {
        self.model = item
        super.init(target: target, action: action)
    }
}
