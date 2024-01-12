//
//  NewChatVC.swift
//  Socketchat
//
//  Created by Enes Saglam on 8.01.2024.
//

import Foundation
import UIKit

class NewChatVC: UIViewController{
    private let tableView = UITableView()
    private let reuseIdentifier = "UserCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigureTableView()
        ConfigureUI()
    }
    private func ConfigureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 64
    }
    private func ConfigureUI(){
        title = "Search"
        
        view.addSubview(tableView)
        tableView.anchor(top:view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,paddingTop: 15,paddingRight: 15)
    }
}

extension NewChatVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        return cell
    }
    
    
}
