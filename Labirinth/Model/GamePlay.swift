//
//  GamePlay.swift
//  Labirinth
//
//  Created by Нуржан Керимбеков on 2021-12-22.
//

import Foundation

class GamePlay{
    private var manager = Manager()
    var game:Game
    
    func createNewGame(roomQuantity:Int){
        manager.generateMatrix(qty: roomQuantity)
        game = manager.game
    }
    
    init() {
        manager.createDefaultMatrix()
        game = manager.game
    }
    
    func enterRoom(){
        game.currentRoom = game.matrix[game.currentX][game.currentY]
        game.currentRoom.isSeen = true
        game.currentRoom.isHereNow = true
        game.stepLeft -= 1
        drawDoors()
    }
    
    func moveUp(){
        if game.currentX > 0{
            game.currentX -= 1
            drawDoors()
        }
    }
    
    func moveDown(){
        if game.currentX < game.matrix.count - 1{
            game.currentX += 1
            drawDoors()
        }
    }
    
    func moveRight(){
        if game.currentY < game.matrix.count - 1{
            game.currentY += 1
            drawDoors()
        }
    }
    
    func moveLeft(){
        if game.currentY > 0{
            game.currentY -= 1
            drawDoors()
        }
    }
    
    private func drawDoors(){
        let x = game.currentX
        let y = game.currentY
        game.directions = AvailableDirections()
        
        if x == 0{
            game.directions.up = true
        }else{
            let roomUp = game.matrix[x - 1][y]
            if !roomUp.isItRoom{
                game.directions.up = true
            }
        }
        if y == 0{
            game.directions.left = true
        }else{
            let roomLeft = game.matrix[x][y - 1]
            if !roomLeft.isItRoom{
                game.directions.left = true
            }
        }
        
        if x == game.matrix.count - 1{
            game.directions.down = true
        }else{
            let roomDown = game.matrix[x + 1][y]
            if !roomDown.isItRoom{
                game.directions.down = true
            }
        }
        
        if y == game.matrix.count - 1{
            game.directions.right = true
        }else{
            let roomRight = game.matrix[x][y + 1]
            if !roomRight.isItRoom{
                game.directions.right = true
            }
        }
    }
    
    
}
