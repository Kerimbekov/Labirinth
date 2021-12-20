//
//  CollectionViewCell.swift
//  Labirinth
//
//  Created by Нуржан Керимбеков on 2021-12-18.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var myView: UIView!
    var item = Item()
    override func awakeFromNib() {
        super.awakeFromNib()
        qtyLabel.makeCircle()
        let pan = CustomPanGestureRecognizer(target: self, action: #selector(panAction), item: item)
        iconImageView.addGestureRecognizer(pan)
    }
    
    var initialCenter: CGPoint = .zero
    @objc func panAction(sender: CustomPanGestureRecognizer){
        
    }
    

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
