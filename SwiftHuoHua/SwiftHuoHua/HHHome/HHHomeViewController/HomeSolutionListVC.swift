//
//  HomeSolutionListVC.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/24.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit

class HomeSolutionListVC: HHBaseViewController {

    let cellid = "cellid"
    
    fileprivate lazy var tableview:UITableView = {
       let table = UITableView(frame: CGRect.zero, style: .plain)
        table.dataSource=self
        table.delegate=self
        table.rowHeight=80
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cellid")
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func configUI() {
        view.addSubview(tableview)
        tableview.snp.makeConstraints {
            $0.left.top.right.equalToSuperview()
            $0.bottom.equalTo(-TAB_BAR_HEIGHT)
        }
    }
}

extension HomeSolutionListVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath)
        cell.textLabel?.text="第\(indexPath.row)个cell"
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        FlutterRouterManager.sharedRouter.open("sample://firstPage", urlParams: ["present":false], exts: [:]) { (finish) in
            
        }
    }
}
