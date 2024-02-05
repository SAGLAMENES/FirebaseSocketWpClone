//
//  NewChatVC.swift
//  Socketchat
//
//  Created by Enes Saglam on 8.01.2024.
//

import Foundation
import UIKit
import FirebaseAuth

protocol NewChatVCDelegate: AnyObject {
    func controller(_ controller: NewChatVC, wantsToStartChatWith user: User)
}
class NewChatVC: UIViewController{
    weak var delegate: NewChatVCDelegate?
    private let tableView = UITableView()
    private let reuseIdentifier = "UserCell"
    private var users : [User]=[]{
        didSet{tableView.reloadData()}
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigureTableView()
        ConfigureUI()
        fetchusers()
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
    
    private func fetchusers(){
        UserService.fetchUsers { users in
            self.users = users
            
            guard let uid = Auth.auth().currentUser?.uid else {return}
            guard let index = self.users.firstIndex(where: {$0.uid == uid}) else {return}
            self.users.remove(at: index)
            print(users)
        }
    }
}

extension NewChatVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        let user = users[indexPath.row]
        cell.viewModel = UserViewModel(user: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]

        delegate?.controller(self, wantsToStartChatWith: user)}
    
}
