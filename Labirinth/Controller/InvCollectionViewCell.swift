//
//  CollectionViewCell.swift
//  Labirinth
//
//  Created by Нуржан Керимбеков on 2021-12-18.
//

import UIKit

class InvCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var myView: UIView!
    var index = 0
    var myDelegate:dragFromInvDelegate?
    var invItem:ItemProtocol = Item()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup(){
        qtyLabel.makeCircle()
        iconImageView.image = invItem.image
        let pan = CustomPanGestureRecognizer(target: self, action: #selector(panAction), item: invItem)
        iconImageView.addGestureRecognizer(pan)
        iconImageView.isUserInteractionEnabled = true
    }

    
    @objc func panAction(sender: CustomPanGestureRecognizer){
        myDelegate?.dragFromInvView(sender: sender,index: index)
    }
    

}

protocol dragFromInvDelegate{
    func dragFromInvView(sender: CustomPanGestureRecognizer,index: Int)
}

extension UIView{
    func makeCircle(){
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
}
