//
//  MapCollectionViewCell.swift
//  Labirinth
//
//  Created by Нуржан Керимбеков on 2021-12-20.
//

import UIKit

class MapCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var roomView:UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        roomView.layer.borderWidth = 0.1
        roomView.layer.borderColor = UIColor.black.cgColor
    }

}
