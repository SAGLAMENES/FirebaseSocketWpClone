//
//  ChattingViewController.swift
//  FirebaseSocketChat
//
//  Created by Enes Saglam on 8.01.2024.
//

import Foundation
import UIKit
import Firebase

class ConversationViewController: UIViewController{
    private var user : User
    private let reuseIdentifer = "ConversationCell"
    private let tableView = UITableView()
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigureUI()
        ConfigureTableView()
    }
    private func ConfigureTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 80
        tableView.backgroundColor = .white
        tableView.register(ConversationCell.self, forCellReuseIdentifier: reuseIdentifer)
        tableView.tableFooterView = UIView()
    }
    private func ConfigureUI(){
        title = user.fullname
        view.backgroundColor = .white
        
        let logOutBarButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        let newConversationBarButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(handleNewChat))
        
        navigationItem.leftBarButtonItem = logOutBarButton
        navigationItem.rightBarButtonItem = newConversationBarButton
        
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,paddingLeft: 15, paddingRight: 15)
    }
    
    @objc func handleLogout(){
        do {
            try Auth.auth().signOut()
            dismiss(animated: true)
        } catch  {
            print("logout error")
        }
    }
    
    @objc func handleNewChat(){
        let controller = NewChatVC()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        present(nav, animated: true)
    }
    private func openChat(currentUser: User,otherUser: User){
        let controller = ChatCollectionViewController(currentUser: currentUser, otherUser: otherUser)
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension ConversationViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer , for: indexPath) as! ConversationCell
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension ConversationViewController: NewChatVCDelegate{
    func controller(_ controller: NewChatVC, wantsToStartChatWith otherUser: User) {
        controller.dismiss(animated: true)
        print(user.fullname)
        openChat(currentUser: user, otherUser: otherUser)
    }
  
    
}
