//
//  ChatCollectionViewController.swift
//  Socketchat
//
//  Created by Enes Saglam on 9.01.2024.
//
import UIKit
class ChatCollectionViewController: UICollectionViewController {
    private let reuseIdentifier = "ChatCell"
    private var messages : [String] = ["sampledatasadasdskjajfsajkgjklasjklsgjksajkgjklasgjakjlsgkjlskjalgjklasjlgkjklsagjklasgjklkjlsagkjlasgkjlgasjklgskajljkglaskjlgasjkagsjksagjklljkgasjklas","sadasdasda","yorgunum"]
    
    private lazy var customInputView  : CustomInputView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let inputView = CustomInputView(frame: frame)
        inputView.delegate = self
        return inputView
    }()
    private var currentUser : User
    private var otherUser : User
    //MARK: -lifecycle
    init(currentUser: User, otherUser: User){
        self.currentUser = currentUser
        self.otherUser = otherUser
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
      
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        configureUI()
        // Do any additional setup after loading the view.
    }
    override var inputAccessoryView: UIView?{
        get{return customInputView}
    }
    override var canBecomeFirstResponder: Bool{
        return true
    }

    private func configureUI(){
        title = otherUser.fullname
        collectionView.register(ChatCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return messages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChatCell
        let text = messages[indexPath.row]
        cell.configure(text: text)
        return cell
    }

    // MARK: UICollectionViewDelegate

}
extension ChatCollectionViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 15, left: 0, bottom: 15, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let cell = ChatCell(frame: frame)
        let text = messages[indexPath.row]
        cell.configure(text: text)
        cell.layoutIfNeeded()
        
        let targetSize = CGSize(width: view.frame.width, height: 1000)
        let estimetSize = cell.systemLayoutSizeFitting(targetSize)
        
        return .init(width: view.frame.width, height: estimetSize.height)
    }
}


extension ChatCollectionViewController: CustomInputViewDelegate{
    func inputView(_ view: CustomInputView, wantUploadMessage message: String) {
        print(message)
        MessageServices.uploadMessage(message: message, currentUser: currentUser , otherUser: otherUser) { _ in
            //
        }
        messages.append(message)
        view.clearTextView()
        collectionView.reloadData()
    }
    
    
}
