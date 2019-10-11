//
//  HHPersionCenterVC.swift
//  SwiftHuoHua
//
//  Created by 陈庆 on 2019/10/11.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit

class HHPersionCenterVC: HHBaseViewController {
    let cellid = "mycellid"
    lazy var tableview:UITableView = {[weak self] in
        let table = UITableView(frame: self!.view.bounds, style: .grouped)
        table.delegate=self
        table.dataSource=self
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellid)
        return table
    }()
    let array = [["我的钱包","交易记录","我的积分","我的优惠","已购音频","学习记录","我的收藏"],["退出登录"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func configUI() {
        super.configUI()
        view.addSubview(tableview)
    }
}
extension HHPersionCenterVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array[section].count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: cellid)
        cell.textLabel?.text = array[indexPath.section][indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if array[indexPath.section][indexPath.row] == "退出登录" {
            let nvc = HHNavigationController(rootViewController: CodeLoginViewController())
            nvc.navigationbarStyle(.white)
            nvc.modalPresentationStyle = .fullScreen
            self.present(nvc, animated: true, completion: nil)
        }
    }
}
