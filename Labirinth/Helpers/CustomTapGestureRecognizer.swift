//
//  CustomTapGestureRecognizer.swift
//  Labirinth
//
//  Created by Нуржан Керимбеков on 2021-12-19.
//

import Foundation
import UIKit

class CustomTapGestureRecognizer:UITapGestureRecognizer{
    var model:Item
    var subView:UIImageView
    init(target: AnyObject, action: Selector, model: Item, subView:UIImageView) {
        self.model = model
        self.subView = subView
        super.init(target: target, action: action)
    }
}
