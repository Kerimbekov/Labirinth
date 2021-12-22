//
//  ItemProtocol.swift
//  Labirinth
//
//  Created by Нуржан Керимбеков on 2021-12-22.
//

import Foundation
import UIKit

protocol ItemProtocol {
    var itemId:Int { get set }
    var idName:String { get set }
    var displayName:String { get set }
    var description:String { get set }
    var qty:Int { get set }
    var image:UIImage { get set }
    var isSelected:Bool { get set }
    var x:Int { get set }
    var y:Int { get set }
}
