//
//  MapTableViewCell.swift
//  Labirinth
//
//  Created by Нуржан Керимбеков on 2021-12-20.
//

import UIKit

class MapTableViewCell: UITableViewCell,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    

    @IBOutlet weak var mapCollectionView:UICollectionView!
    var roomList = [Room]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mapCollectionView.delegate = self
        mapCollectionView.dataSource = self
        mapCollectionView.register(UINib(nibName: "MapCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MapCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roomList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MapCollectionViewCell", for: indexPath) as! MapCollectionViewCell
        let room = roomList[indexPath.item]
        if room.isHereNow{
            cell.roomView.backgroundColor = .green
        }else if room.isSeen{
            cell.roomView.backgroundColor = .systemYellow
        }else{
            cell.roomView.backgroundColor = .gray
        }
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 19, height: 19)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
