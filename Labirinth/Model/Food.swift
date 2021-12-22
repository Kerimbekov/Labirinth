//
//  Food.swift
//  Labirinth
//
//  Created by Нуржан Керимбеков on 2021-12-22.
//

import Foundation
import UIKit

struct Food:ItemProtocol{
    var itemId: Int = 0
    var idName: String = "Food"
    var displayName: String = "Food"
    var description: String = "Adds extra 10 steps"
    var qty: Int = 3
    var image: UIImage = UIImage(named: "food")!
    var isSelected: Bool = false
    var x: Int = 0
    var y: Int = 0
}
