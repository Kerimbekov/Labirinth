//
//  Key.swift
//  Labirinth
//
//  Created by Нуржан Керимбеков on 2021-12-22.
//

import Foundation
import UIKit

struct Key:ItemProtocol{
    var itemId: Int = 0
    var idName: String = "Key"
    var displayName: String = "Key"
    var description: String = "Open the chest"
    var qty: Int = 1
    var image: UIImage = UIImage(named: "key")!
    var isSelected: Bool = false
    var x: Int = 0
    var y: Int = 0
}
