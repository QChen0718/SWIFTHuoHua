//
//  HHSearchViewController.swift
//  SwiftHuoHua
//
//  Created by White-C on 2019/8/5.
//  Copyright © 2019 White-C. All rights reserved.
//

import UIKit

class HHSearchViewController: HHBaseViewController {

    let cellid = "cellid"
    
    fileprivate lazy var searchTextfield: UITextField = {
       let sr = UITextField(frame: CGRect(x: 0, y: 0, width: HHScreenWidth-30, height: 30))
        sr.placeholder="大家都在搜“薪酬绩效”"
        sr.backgroundColor=UIColor.gray.withAlphaComponent(0.1)
        sr.layer.cornerRadius = 15
        sr.font = UIFont.systemFont(ofSize: 15)
        sr.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        sr.leftViewMode = .always
        sr.clearsOnBeginEditing = true
        sr.clearButtonMode = .whileEditing
        sr.returnKeyType = .search
        sr.delegate = self
        //监听输入
        NotificationCenter.default.addObserver(self, selector: #selector(textFiledTextDidChange(noti:)), name: UITextField.textDidChangeNotification, object: sr)
        return sr
    }()
    
    fileprivate lazy var tableview: UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellid)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func configUI() {
        super.configUI()
    }
    override func configNavigationBar() {
        super.configNavigationBar()
        navigationItem.titleView = searchTextfield

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "搜索", style: .plain, target: self, action: #selector(searchClick))
    }
}


extension HHSearchViewController: UITextFieldDelegate
{
    @objc func textFiledTextDidChange(noti: Notification) {
        guard let textField = noti.object as? UITextField,
            let text = textField.text else { return }
            print(text)
//        searchRelative(text)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    @objc func searchClick(){
        
    }
}

extension HHSearchViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath)
        return cell
    }
    
    
}
