//
//  ViewController.swift
//  Labirinth
//
//  Created by Нуржан Керимбеков on 2021-12-18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var roomView: UIView!
    @IBOutlet weak var downImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var upImageView: UIImageView!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    @IBOutlet weak var useButton: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var itemCollectionView: UICollectionView!
    @IBOutlet weak var discardButton: UIButton!
    @IBOutlet weak var dropButton: UIButton!
    @IBOutlet weak var inventoryView: UIView!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var lostLabel: UILabel!
    @IBOutlet weak var invLabel:UILabel!
    
    var inventoryList = [Item]()
    var matrix = [[Room]]()
    var currentRoom = Room()
    var x = 3
    var y = 3
    var stepLeft = 100
    let manager = Manager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutSubviews()
        viewWillLayoutSubviews()
        manager.createMatrix()
        matrix = manager.matrix
        prepareCollectionView()
        prepareRoom()
        addGestureToButtons()
        design()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startNewGame()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.layoutIfNeeded()
        view.layoutSubviews()
        
    }
    
    func prepareRoom(){
        currentRoom = matrix[x][y]
        currentRoom.isSeen = true
        currentRoom.isHereNow = true
        
        controlSteps()
        drawDoors()
        drawItemsInRoom()
        
        if currentRoom.isBlack{
            mainView.alpha = 0.02
            lostLabel.isHidden = true
        }else{
            mainView.alpha = 1
            lostLabel.isHidden = false
        }
    }
    
    func controlSteps(){
        stepLeft -= 1
        stepsLabel.text = "\(stepLeft)"
        
        if stepLeft == 0{
            mainView.isHidden = true
            inventoryView.isHidden = true
            buttonsView.isHidden = true
            itemDescriptionLabel.isHidden = true
            invLabel.isHidden = true
            blackView.backgroundColor = .systemRed
        }
    }
    
    func drawDoors(){
        upImageView.isHidden = false
        leftImageView.isHidden = false
        downImageView.isHidden = false
        rightImageView.isHidden = false
        if x == 0{
            upImageView.isHidden = true
        }else{
            let roomUp = matrix[x - 1][y]
            if !roomUp.isItRoom{
                upImageView.isHidden = true
            }
        }
        if y == 0{
            leftImageView.isHidden = true
        }else{
            let roomLeft = matrix[x][y - 1]
            if !roomLeft.isItRoom{
                leftImageView.isHidden = true
            }
        }
        
        if x == matrix.count - 1{
            downImageView.isHidden = true
        }else{
            let roomDown = matrix[x + 1][y]
            if !roomDown.isItRoom{
                downImageView.isHidden = true
            }
        }
        if y == matrix.count - 1{
            rightImageView.isHidden = true
        }else{
            let roomRight = matrix[x][y + 1]
            if !roomRight.isItRoom{
                rightImageView.isHidden = true
            }
        }
    }
    
    func drawItemsInRoom(){
        //clean view
        for subView in self.roomView.subviews {
            subView.removeFromSuperview()
        }
        
        var index = 0
        for item in currentRoom.itemList{
            let myImageView = UIImageView(image: item.image)
            if item.x == 0 && item.y == 0{
                currentRoom.itemList[index].x = Int.random(in: 0...Int(roomView.frame.width) - 60)
                currentRoom.itemList[index].y = Int.random(in: 0...Int(roomView.frame.height) - 150)
                matrix[x][y] = currentRoom
            }
            myImageView.frame = CGRect(x: currentRoom.itemList[index].x, y: currentRoom.itemList[index].y, width: 60, height: 60)
            roomView.addSubview(myImageView)
            
            let tapG = CustomTapGestureRecognizer(target: self, action: #selector(getItem),model: item,subView: myImageView)
            myImageView.addGestureRecognizer(tapG)
            myImageView.isUserInteractionEnabled = true
            
            let pan = CustomPanGestureRecognizer(target: self, action: #selector(panAction), item: item)
            myImageView.addGestureRecognizer(pan)
            index += 1
        }
    }
    
    var initialCenter: CGPoint = .zero
    @objc func panAction(sender: CustomPanGestureRecognizer){
        guard let targetView = sender.view else {return}
        let item = sender.model
        switch sender.state {
        case .began:
            initialCenter = targetView.center
        case .changed:
            let translation = sender.translation(in: view)
            
            targetView.center = CGPoint(x: initialCenter.x + translation.x,
                                          y: initialCenter.y + translation.y)
            var index = 0
            for checkItem in currentRoom.itemList{
                if checkItem.itemId == item.itemId{
                    currentRoom.itemList[index].x = Int(targetView.frame.minX)
                    currentRoom.itemList[index].y = Int(targetView.frame.minY)
                    matrix[x][y] = currentRoom
                }
                index += 1
            }
        case .ended:
            let inventoryRect = inventoryView.convert(inventoryView.frame, to: view)
            var targetPoint = inventoryView.convert(targetView.center, to: view)
            let topPadding = view.safeAreaInsets.top
            targetPoint = CGPoint(x: targetPoint.x + 40, y: targetPoint.y + 100 + topPadding)
            if inventoryRect.contains(targetPoint) {
                //Add item to inventory
                //Flag if in inventory we already have this item, if yes than just add +1 to badge
                var flag = true
                for index in 0..<inventoryList.count{
                    if item.name == inventoryList[index].name{
                        inventoryList[index].qty += 1
                        flag = false
                    }
                }
                if flag{
                    inventoryList.append(item)
                }
                itemCollectionView.reloadData()
                
                //Remove item from room
                for index in 0..<currentRoom.itemList.count{
                    if item.name == currentRoom.itemList[index].name{
                        currentRoom.itemList.remove(at: index)
                        matrix[x][y] = currentRoom
                        break
                    }
                }
                targetView.removeFromSuperview()
            }else if  !roomView.bounds.contains(targetView.center){
                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveEaseInOut]) {
                    targetView.center = self.initialCenter
                }
            }
        default:
            break
        }
    }
    
    @objc func getItem(sender:CustomTapGestureRecognizer){
        let item = sender.model
        guard item.name != "Chest" else {return}
        let subView = sender.subView
        subView.removeFromSuperview()
        
        //Add item to inventory
        //Flag if in inventory we already have this item, if yes than just add +1 to badge
        var flag = true
        for index in 0..<inventoryList.count{
            if item.name == inventoryList[index].name{
                inventoryList[index].qty += 1
                flag = false
            }
        }
        if flag{
            inventoryList.append(item)
        }
        itemCollectionView.reloadData()
        
        //Remove item from room
        for index in 0..<currentRoom.itemList.count{
            if item.name == currentRoom.itemList[index].name{
                currentRoom.itemList.remove(at: index)
                matrix[x][y] = currentRoom
                break
            }
        }
    }
    
    func prepareCollectionView(){
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        itemCollectionView.register(UINib(nibName: "InvCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "InvCollectionViewCell")
        itemCollectionView.allowsSelection = true
        itemCollectionView.allowsMultipleSelection = false
    }
    
    func addGestureToButtons(){
        let upG = UITapGestureRecognizer(target: self, action: #selector(upTapped))
        upImageView.addGestureRecognizer(upG)
        upImageView.isUserInteractionEnabled = true
        
        let downG = UITapGestureRecognizer(target: self, action: #selector(downTapped))
        downImageView.addGestureRecognizer(downG)
        downImageView.isUserInteractionEnabled = true
        
        let rightG = UITapGestureRecognizer(target: self, action: #selector(rightTapped))
        rightImageView.addGestureRecognizer(rightG)
        rightImageView.isUserInteractionEnabled = true
        
        let leftG = UITapGestureRecognizer(target: self, action: #selector(leftTapped))
        leftImageView.addGestureRecognizer(leftG)
        leftImageView.isUserInteractionEnabled = true
    }
    
    @objc func upTapped(sender:UITapGestureRecognizer){
        if sender.state == .ended{
            makeBlueAllDirections()
            downImageView.tintColor = .gray
            if x > 0{
                x -= 1
                prepareRoom()
            }
        }
    }
    
    @objc func downTapped(sender:UITapGestureRecognizer){
        if sender.state == .ended{
            makeBlueAllDirections()
            upImageView.tintColor = .gray
            if x < matrix.count - 1 {
                x += 1
                prepareRoom()
            }
        }
    }
    
    @objc func rightTapped(sender:UITapGestureRecognizer){
        if sender.state == .ended{
            makeBlueAllDirections()
            leftImageView.tintColor = .gray
            if y < matrix.count - 1{
                y += 1
                prepareRoom()
            }
        }
    }
    
    @objc func leftTapped(sender:UITapGestureRecognizer){
        if sender.state == .ended{
            makeBlueAllDirections()
            rightImageView.tintColor = .gray
            if y > 0{
                y -= 1
                prepareRoom()
            }
        }
    }
    
    func makeBlueAllDirections(){
        matrix[x][y].isHereNow = false
        rightImageView.tintColor = .systemBlue
        leftImageView.tintColor = .systemBlue
        upImageView.tintColor = .systemBlue
        downImageView.tintColor = .systemBlue
    }
    
    func design(){
        useButton.layer.cornerRadius = 8
        dropButton.layer.cornerRadius = 8
        discardButton.layer.cornerRadius = 8
        mainView.layer.cornerRadius = 16
        blackView.layer.cornerRadius = 16
        itemCollectionView.layer.cornerRadius = 9
        inventoryView.layer.cornerRadius = 9
    }

    @IBAction func useTapped(_ sender: Any) {
        for index in 0..<inventoryList.count{
            let item = inventoryList[index]
            if item.isSelected{
                if item.name == "Food"{
                    stepLeft += 10
                    stepsLabel.text = "\(stepLeft)"
                    if item.qty > 1{
                        inventoryList[index].qty -= 1
                    }else{
                        inventoryList.remove(at: index)
                    }
                }else if item.name == "Key"{
                    if currentRoom.itemList.contains(where: {$0.name == "Chest"}) {
                        mainView.isHidden = true
                        inventoryView.isHidden = true
                        buttonsView.isHidden = true
                        itemDescriptionLabel.isHidden = true
                        invLabel.isHidden = true
                        blackView.backgroundColor = .systemGreen
                        lostLabel.text = "Winner!"
                        lostLabel.isHidden = false
                    }
                }else if item.name == "Torch"{
                    mainView.alpha = 1
                }
            }
        }
        deselectItemsInInventory()
        itemCollectionView.reloadData()
    }
    
    @IBAction func discardTapped(_ sender: Any) {
        for index in 0..<inventoryList.count{
            let item = inventoryList[index]
            if item.isSelected{
                if item.qty > 1{
                    inventoryList[index].qty -= 1
                }else{
                    inventoryList.remove(at: index)
                    break
                }
            }
        }
        deselectItemsInInventory()
        itemCollectionView.reloadData()
    }
    
    @IBAction func dropTapped(_ sender: Any) {
        for index in 0..<inventoryList.count{
            let item = inventoryList[index]
            if item.isSelected{
                let myImageView = UIImageView(image: item.image)
                if item.x == 0 && item.y == 0{
                    inventoryList[index].x = Int.random(in: 0...Int(roomView.frame.width) - 60)
                    inventoryList[index].y = Int.random(in: 0...Int(roomView.frame.height) - 150)
                }
                myImageView.frame = CGRect(x: inventoryList[index].x , y: inventoryList[index].y, width: 60, height: 60)
                roomView.addSubview(myImageView)
                let tapG = CustomTapGestureRecognizer(target: self, action: #selector(getItem),model: item,subView: myImageView)
                myImageView.addGestureRecognizer(tapG)
                myImageView.isUserInteractionEnabled = true
                
                let pan = CustomPanGestureRecognizer(target: self, action: #selector(panAction), item: item)
                myImageView.addGestureRecognizer(pan)
                
                var newItem = item
                newItem.qty = 1
                matrix[x][y].itemList.append(newItem)
                
                if item.qty > 1{
                    inventoryList[index].qty -= 1
                }else{
                    inventoryList.remove(at: index)
                    break
                }
            }
        }
        deselectItemsInInventory()
        itemCollectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMap"{
            let vc = segue.destination as! MapViewController
            vc.matrix = matrix
        }
    }
    
    @IBAction func newGameTapped(_ sender: Any) {
        startNewGame()
    }
    
    func startNewGame(){
        var alertTextField = UITextField()
        let alert = UIAlertController(title: "New Game", message: "How many rooms do you want?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "Ok", style: .default) { [self] action in
            let str = alertTextField.text ?? "8"
            if let num = Int(str){
                manager.generateMatrix(qty: num)
                matrix = manager.matrix
                x = manager.initialX
                y = manager.initialY
                inventoryList = [Item]()
                itemCollectionView.reloadData()
                stepLeft = 100
                mainView.isHidden = false
                inventoryView.isHidden = false
                buttonsView.isHidden = false
                itemDescriptionLabel.isHidden = false
                invLabel.isHidden = false
                blackView.backgroundColor = .black
                prepareRoom()
            }
        }
        alert.addTextField { textField in
            textField.keyboardType = .numberPad
            alertTextField = textField
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}




extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,dragFromInvDelegate{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return inventoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InvCollectionViewCell", for: indexPath) as! InvCollectionViewCell
        let invItem = inventoryList[indexPath.item]
        cell.invItem = invItem
        cell.myDelegate = self
        cell.index = indexPath.row
        cell.setup()
        if invItem.qty > 1 {
            cell.qtyLabel.text = "\(invItem.qty)"
            cell.qtyLabel.isHidden = false
        }else{
            cell.qtyLabel.isHidden = true
        }
        if invItem.isSelected{
            cell.myView.backgroundColor = .systemGreen
        }else{
            cell.myView.backgroundColor = .white
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        deselectItemsInInventory()
        inventoryList[indexPath.row].isSelected = true
        itemCollectionView.reloadData()
        
        itemDescriptionLabel.isHidden = false
        buttonsView.isHidden = false
        let item = inventoryList[indexPath.row]
        itemDescriptionLabel.text = item.description
        if item.name == "Key" || item.name == "Food" || item.name == "Torch"{
            useButton.isEnabled = true
        }else{
            useButton.isEnabled = false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }
    
    func dragFromInvView(sender: CustomPanGestureRecognizer, index:Int) {
        guard let targetView = sender.view else {return}
        itemCollectionView.reloadData()
        let item = sender.model
        switch sender.state {
        case .began:
            initialCenter = targetView.center
        case .changed:
            let translation = sender.translation(in: view)

            targetView.center = CGPoint(x: initialCenter.x + translation.x,
                                        y: initialCenter.y + translation.y)
            itemCollectionView.reloadData()
        case .ended:
            let roomRect = roomView.convert(roomView.frame, to: view)
            var targetPoint = inventoryView.convert(targetView.center, to: view)
            let topPadding = view.safeAreaInsets.top
            targetPoint = CGPoint(x: targetPoint.x + 40, y: targetPoint.y + 100 + topPadding)
            if roomRect.contains(targetPoint) {
                deselectItemsInInventory()
                let myImageView = UIImageView(image: item.image)
                let randomX = Int.random(in: 31...Int(roomView.frame.width) - 31)
                let randomY = Int.random(in: 31...Int(roomView.frame.height) - 31)
                myImageView.frame = CGRect(x: randomX, y: randomY, width: 60, height: 60)
                roomView.addSubview(myImageView)
                let tapG = CustomTapGestureRecognizer(target: self, action: #selector(getItem),model: item,subView: myImageView)
                myImageView.addGestureRecognizer(tapG)
                myImageView.isUserInteractionEnabled = true
                
                let pan = CustomPanGestureRecognizer(target: self, action: #selector(panAction), item: item)
                myImageView.addGestureRecognizer(pan)
                
                var newItem = item
                newItem.qty = 1
                matrix[x][y].itemList.append(newItem)
                
                if item.qty > 1{
                    inventoryList[index].qty -= 1
                }else{
                    inventoryList.remove(at: index)
                }
                self.itemCollectionView.reloadInputViews()
                self.itemCollectionView.reloadData()
                
            }else{
                UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: [.curveEaseInOut]) {
                    targetView.center = self.initialCenter
                }
            }
        default:
            itemCollectionView.reloadData()
            break
        }
        itemCollectionView.reloadData()
    }
    
    func deselectItemsInInventory(){
        for index in 0..<inventoryList.count{
            inventoryList[index].isSelected = false
        }
        itemDescriptionLabel.isHidden = true
        buttonsView.isHidden = true
    }
    
    
}
