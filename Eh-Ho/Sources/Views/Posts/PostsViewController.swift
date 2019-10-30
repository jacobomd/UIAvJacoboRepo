//
//  PostsViewController.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 20/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit


class PostsViewController: UIViewController {

    @IBOutlet weak var tableViewPosts: SelfSizedTableView!
    @IBOutlet weak var titleTopic: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var posts : [Post2] = []
    var postsCD : [PostData] = []
    var connection : Bool = true
    var users: [User4] = []
    
    let viewModel : PostViewModel
    
    var id: Int = 0
    var newTitle: String = ""
    var editable_topic: Bool = false
    
    lazy var refreshControl:UIRefreshControl = {
        let refresControl = UIRefreshControl()
        //QUE AL CAMBIAR EL VALOR, SE EJECUTE UN MÉTODO
        refresControl.addTarget(self, action: #selector(PostsViewController.actualizarDatos(_:)), for: .valueChanged)
        //ESTABLECER EL COLOR DE LA RULETILLA
        refresControl.tintColor = UIColor.blue
        return refresControl
    }()
    
    @objc func actualizarDatos(_ refresControl: UIRefreshControl){
        //AQUI TU TIENES QUE ACTUALIZAR TUS DATOS. TU DATASOURCE. LLAMAR A TU SERVIDOR, VOLVER A TRAER LOS DATOS. ELIMINAR O AÑADIR AL ELEMENTO PERSISTIDO
        viewModel.viewDidLoad()
        //REFRESCO LA VISTA DE TABLA
        self.tableViewPosts.reloadData()
        //PARO EL REFRESH CONTROL
        refresControl.endRefreshing()
        
    }
    
    init(viewModel : PostViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        tableViewPosts.rowHeight = UITableView.automaticDimension
        tableViewPosts.estimatedRowHeight = PostCell.estimateRowHeight()
        tableViewPosts.dataSource = self
        tableViewPosts.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self

        self.title = "Posts"
        
        let cell = UINib(nibName: "PostCell", bundle: nil)
        tableViewPosts.register(cell, forCellReuseIdentifier: UITableViewCell.identifier)
        
        let cellCollectioView = UINib(nibName: "UserCell", bundle: nil)
        collectionView.register(cellCollectioView, forCellWithReuseIdentifier: "UserCell")
        
        viewModel.viewDidLoad()
        
        tableViewPosts.maxHeight = scrollView.frame.height+20
        //tableViewPosts.maxHeight = 100
        
        tableViewPosts.refreshControl = refreshControl
    }
    

     //Mark: - UI
    func setupUI(editable: Bool) {

        let backItem = UIBarButtonItem()
        backItem.title = "Volver"
        let color = UIColor(red: 291/255, green: 99/255, blue: 0/255, alpha: 1.0)
        backItem.tintColor = color
        navigationItem.backBarButtonItem = backItem
        // Button creation
        let editTopic = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(displayEdit))
        editTopic.tintColor = color
        editTopic.image = UIImage(named: "icon_edit")

        let searchTopic = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        searchTopic.tintColor = color
        searchTopic.image = UIImage(named: "temas_Search")

        if editable {
            // Add button
            navigationItem.rightBarButtonItems = [searchTopic, editTopic]
        } else {
            navigationItem.rightBarButtonItems = [searchTopic]
        }

    }
    
    // Mark: - Navigation
    @objc func displayEdit() {
       showPustTopicAlert()
    }
    
    private func showPustTopicAlert()  {
        //Create the alert
        let alert = UIAlertController(title: "Editar topic", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (UITextField) in
            UITextField.placeholder = "Enter new title topic"
            UITextField.textAlignment = .center
        }
        
        //Creamos la accion
        let action = UIAlertAction(title: "ok", style: .default) { [unowned alert] _ in
            self.newTitle = alert.textFields![0].text!
            self.viewModel.didUpDateTopic(title: self.newTitle)
        }
        
        //Aañadimos a la alerta
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func buttonAddPost(_ sender: Any) {
        viewModel.didTapInTopic(id: self.id)
    }

}

private func convertDateFormater(date: String) -> String {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
    
    guard let date = dateFormatter.date(from: date) else {
        assert(false, "no date from string")
        
    }
    
    dateFormatter.dateFormat = " MMM dd "
    dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
    let timeStamp = dateFormatter.string(from: date)
    return timeStamp
    
}

extension PostsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if connection {
            return posts.count
        } else {
            return postsCD.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath) as? PostCell
            else { return UITableViewCell()
        }
        
        if connection {
            
            var resultado = posts[indexPath.row].cooked
            resultado = resultado.replacingOccurrences(of: "<p>", with: "", options: NSString.CompareOptions.literal, range: nil).capitalizingFirstLetter()
            resultado = resultado.replacingOccurrences(of: "</p>", with: "", options: NSString.CompareOptions.literal, range: nil).capitalizingFirstLetter()

           // cell.textLabel?.text = resultado
            id = posts[indexPath.row].topicID
            editable_topic  = posts[indexPath.row].canEdit
            var titulo = posts[indexPath.row].topicSlug
            
            titulo = titulo.replacingOccurrences(of: "-", with: " ", options: NSString.CompareOptions.literal, range: nil).capitalizingFirstLetter()
            titleTopic.text = titulo
            
            let userName = posts[indexPath.row].username
            let descripcion = resultado
            //let avatar = posts[indexPath.row].avatarTemplate
            //let avatarImage = UIImage(named: "https://mdiscourse.keepcoding.io/\(avatar)")
            let avatarImage = UIImage(named: "cell_iconoPrueba")

            let numberVisit = posts[indexPath.row].postNumber
            let date = posts[indexPath.row].createdAt
            
           let dateUpDate =  convertDateFormater(date: date)
            
            cell.configure(avatarImage: avatarImage!, userName: userName,descripcion: descripcion, numberVisit: "\(numberVisit)", date: dateUpDate)
      
        } else {
            cell.textLabel?.text = postsCD[indexPath.row].cooked
            id = postsCD[indexPath.row].topicId
            editable_topic  = postsCD[indexPath.row].canEdit
        }
        
        setupUI(editable: editable_topic)
        return cell
    }
    
}


extension PostsViewController: UITableViewDelegate {
    
}

extension PostsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 64, height: 70)
    }
}



extension PostsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.backgroundColor = .black
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCell", for: indexPath) as? UserCell else {
           return UICollectionViewCell()
        }
        
        let image = UIImage(named: "cell_iconoPrueba")
        let name = users[indexPath.row].username
        
        cell.configure(cellImage: image!, cellName: name)
        cell.backgroundColor = .black
        
        return cell
    }
    
    
}

extension PostsViewController: UICollectionViewDelegate {
    
}

// MARK: - ViewModel Communication

protocol PostsViewControllerProtocol: class {
    func showListPostssByTopic(posts: [Post2])
    func showError(with message: String)
    func showListPostsCD(post: [PostData])
    func showListUsers(users: [User4])
}

extension PostsViewController: PostsViewControllerProtocol {
    func showListUsers(users: [User4]) {
        self.users = users
        self.collectionView.reloadData()
    }
    


    func showListPostssByTopic(posts: [Post2]) {
        self.posts = posts
        self.tableViewPosts.reloadData()
    }
    
    func showError(with message: String) {
        //AQUI ENSEÑAMOS ALERTA
        print("ERROR")
    }
    
    func showListPostsCD(post: [PostData]) {
        connection = false
        postsCD = post
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
