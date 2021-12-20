//
//  Manager.swift
//  Labirinth
//
//  Created by Нуржан Керимбеков on 2021-12-18.
//

import Foundation
import UIKit

class Manager{
    var itemList = [Item]()
    var matrix = [[Room]]()
    
    init() {
        createItems()
    }
    
    func createItems(){
        let key = Item(name: "Key", description: "Opens chest", qty: 1, image: UIImage(named: "key"))
        let chest = Item(name: "Chest", description: "Here is your holy grail", qty: 1,image: UIImage(named: "chest"))
        let stone = Item(name: "Stone", description: "Useless stone", qty: 5,image: UIImage(named: "stone"))
        let mushroom = Item(name: "Mushroom", description: "Tasty mushroom but useless", qty: 5,image: UIImage(named: "mushroom"))
        let bone = Item(name: "Bone", description: "It could be your bone", qty: 5,image: UIImage(named: "bone"))
        let food = Item(name: "Food", description: "Adds extra 10 steps", qty: 3, image: UIImage(named: "food"))
        let torch = Item(name: "Torch", description: "Lights up a dark room", qty: 1, image: UIImage(named: "torch"))
        let gold = Item(name: "Gold", description: "Collect gold for better days", qty: 10, image: UIImage(named: "gold"))
        
        
        itemList.append(key)
        itemList.append(chest)
        itemList.append(stone)
        itemList.append(mushroom)
        itemList.append(bone)
        itemList.append(food)
        itemList.append(torch)
        itemList.append(gold)
    }
    
    func createMatrix(){
        var list1 = [Room]()
        let empty = Room()
        let notEmpty = Room(itemList: [Item](), isItRoom: true)
        list1.append(Room(itemList: [Item](), isItRoom: true))
        list1.append(notEmpty)
        list1.append(empty)
        list1.append(empty)
        
        var list2 = [Room]()
        list2.append(notEmpty)
        list2.append(empty)
        list2.append(empty)
        list2.append(notEmpty)
        
        var list3 = [Room]()
        list3.append(notEmpty)
        list3.append(Room(itemList: [Item](), isItRoom: true, isBlack: true))
        list3.append(notEmpty)
        list3.append(notEmpty)
        
        var list4 = [Room]()
        list4.append(empty)
        list4.append(empty)
        list4.append(empty)
        list4.append(notEmpty)
        
        matrix.append(list1)
        matrix.append(list2)
        matrix.append(list3)
        matrix.append(list4)
        
        addItemsToRooms()
    }
    
    func addItemsToRooms(){
        var id = 0
        for item in itemList{
            
            var addedQty = 0
            while addedQty < item.qty {
                let randomX = Int.random(in: 0..<4)
                let randomY = Int.random(in: 0..<4)
                var randomRoom = matrix[randomX][randomY]
                if randomRoom.isItRoom{
                    var oneItem = item
                    oneItem.qty = 1
                    oneItem.itemId = id
                    randomRoom.itemList.append(oneItem)
                    id += 1
                    addedQty += 1
                    matrix[randomX][randomY] = randomRoom
                }
            }
        }
    }
}
