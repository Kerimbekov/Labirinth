//
//  Game.swift
//  Labirinth
//
//  Created by Нуржан Керимбеков on 2021-12-22.
//

import Foundation

class Game{
    var matrix = [[Room]]()
    var initialX = 0
    var initialY = 0
    var currentX = 0
    var currentY = 0
    var inventoryList = [Item]()
    var stepLeft = 100
    var currentRoom = Room()
    var directions = AvailableDirections()
}
