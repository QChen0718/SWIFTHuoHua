//
//  HomeAudioCell.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/21.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit

let reuseID_SingleAudioCell = "SingleAudioCell"
class HomeAudioCell: UITableViewCell {

    @IBOutlet weak var audioview: UICollectionView!
    @IBOutlet weak var idtypetitle: UILabel!
    private var dataArray = [homeAudioModel]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configUI()
    }

   fileprivate func configUI() {
        let layout = UICollectionViewFlowLayout()
        let padding: CGFloat = 16
        let margin:CGFloat = 10
        let itemW = (HHScreenWidth - 32 - 20)/3.0
        let itemH = itemW * 188 / 108
        layout.itemSize=CGSize(width: itemW, height: itemH)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = margin
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        audioview.collectionViewLayout=layout
        audioview.alwaysBounceHorizontal = true
        audioview.backgroundColor=UIColor.white
        audioview.contentInset=UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
        audioview.dataSource=self
        audioview.delegate=self
        audioview.showsHorizontalScrollIndicator = false
        audioview.contentOffset=CGPoint(x: -padding, y: 0)
        audioview.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
        audioview.register(UINib(nibName: "HomeAudioCollectionCell", bundle: nil), forCellWithReuseIdentifier: reuseID_SingleAudioCell)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //给cell赋值
    public func setModel(modelArray:[homeAudioModel])
    {
        self.dataArray=modelArray
        self.audioview.reloadData()
    }
    public func setselectAudioModel(model:audioSelectModel)
    {
        self.dataArray = model.items ?? []
        self.idtypetitle.text = model.name
        self.audioview.reloadData()
    }
}

extension HomeAudioCell:UICollectionViewDataSource,UICollectionViewDelegate
{
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.dataArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseID_SingleAudioCell, for: indexPath) as! HomeAudioCollectionCell
        cell.setModel(model: self.dataArray[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = self.dataArray[indexPath.row]
        let vc = HHAudioController()
        vc.audioDetailid = model.id
        topVC?.navigationController?.pushViewController(vc, animated: true)
    }
}
