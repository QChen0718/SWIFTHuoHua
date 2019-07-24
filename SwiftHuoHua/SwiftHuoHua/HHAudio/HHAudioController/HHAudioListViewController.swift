//
//  HHAudioListViewController.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/7/23.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit

let cellid = "cellid"
class HHAudioListViewController: HHBaseViewController {

    lazy var tableview: UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .grouped)
        table.dataSource=self
        table.delegate=self
        table.rowHeight=UITableView.automaticDimension
        table.estimatedRowHeight=44
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellid)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func configUI() {
        self.view.addSubview(self.tableview)
        self.tableview.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension HHAudioListViewController: UITableViewDataSource,UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
