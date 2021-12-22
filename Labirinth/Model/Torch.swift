//
//  Torch.swift
//  Labirinth
//
//  Created by Нуржан Керимбеков on 2021-12-22.
//

import Foundation
import UIKit

struct Torch:ItemProtocol{
    var itemId: Int = 0
    var idName: String = "Torch"
    var displayName: String = "Torch"
    var description: String = "Lights up a dark room"
    var qty: Int = 1
    var image: UIImage = UIImage(named: "torch")!
    var isSelected: Bool = false
    var x: Int = 0
    var y: Int = 0
}
