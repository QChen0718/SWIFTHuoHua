//
//  HomeViewController.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/16.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit


class HomeViewController: HHBaseViewController {
    let cellid = "cellid"
    //懒加载tableview
    fileprivate lazy var tableview : UITableView = { [unowned self] in
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: HHScreenWidth, height: HHScreenHeight), style: .grouped)
        table.dataSource=self
        table.delegate=self
        table.estimatedRowHeight=44
        table.rowHeight=UITableView.automaticDimension
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellid)
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 添加列表
        self.view.addSubview(tableview)
    }
}

extension HomeViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}