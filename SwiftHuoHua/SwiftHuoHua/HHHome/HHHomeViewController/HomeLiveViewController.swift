//
//  HomeLiveViewController.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/24.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit

class HomeLiveViewController: HHBaseViewController {

    let collitionid = "collitionid"
    fileprivate var pageNum: Int = 1
    fileprivate var latestliveArray = [liveModel]()
    lazy var conllitionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing=0
        layout.minimumInteritemSpacing=10
        layout.itemSize=CGSize(width: KSuitFloat(float: 167), height: KSuitFloat(float: 196))
        layout.sectionInset=UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
        let conllition = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        conllition.dataSource=self
        conllition.delegate=self
        conllition.backgroundColor = UIColor.white
        conllition.register(UINib(nibName: "HomeLiveCollectionCell", bundle: nil), forCellWithReuseIdentifier: collitionid)
        conllition.HHHead = HHRefreshHeader(refreshingBlock: { [weak self] in
            self?.requestData()
        })
        conllition.HHFoot = HHRefreshFooter(refreshingBlock: {
            self.pageNum += 1
            self.requestData()
        })
       return conllition
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func configUI() {
        self.view.addSubview(conllitionView)
        conllitionView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(-TAB_BAR_HEIGHT)
        }
        requestData()
    }
}

extension HomeLiveViewController{
     func requestData() {
        ApiLoadingProvider.request(.loadHomeLive(pageNum: self.pageNum), model: liveListModel.self) {[weak self] (returnData, errnocode) in
            self?.conllitionView.HHHead.endRefreshing()
            self?.conllitionView.HHFoot.endRefreshing()
            if errnocode == 0
            {
                self?.latestliveArray.append(contentsOf: returnData?.latestLive?.list ?? [])
                self?.conllitionView.reloadData()
            }
            else {
                
            }
        }
    }
}

extension HomeLiveViewController: UICollectionViewDataSource,UICollectionViewDelegate
{
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.latestliveArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collitionid, for: indexPath) as! HomeLiveCollectionCell
        cell.setDataModel(model: self.latestliveArray[indexPath.row])
        return cell
    }
}
