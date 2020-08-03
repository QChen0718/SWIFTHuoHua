//
//  CircleListView.swift
//  SwiftHuoHua
//
//  Created by 陈庆 on 2020/7/31.
//  Copyright © 2020 White-C. All rights reserved.
//

import UIKit

class CircleListView: UITableView {
    fileprivate let dataDictArray=[["photos":["",""]],["photos":[]],["photos":[""]],["photos":["","","",""]],["photos":["","",""]],["photos":[]],["photos":["","","",""]]]
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        delegate = self
        dataSource = self
        estimatedRowHeight = 100
        self.separatorStyle = .none
        rowHeight = UITableView.automaticDimension
        register(HHCircleCell.self, forCellReuseIdentifier: "id")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension CircleListView:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataDictArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HHCircleCell(style: .default, reuseIdentifier: "id")
        cell.setdataDict(data: dataDictArray[indexPath.row])
        return cell
    }
}
