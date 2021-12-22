//
//  Item.swift
//  Labirinth
//
//  Created by Нуржан Керимбеков on 2021-12-18.
//

import Foundation
import UIKit

struct Item:ItemProtocol{
    var itemId = 0
    var idName = ""
    var displayName: String = ""
    var description = ""
    var qty = 0
    var image:UIImage = UIImage(named: "stone")!
    var isSelected = false
    var x = 0
    var y = 0
}
