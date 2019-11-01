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
    @IBOutlet weak var topTopic: SelfSizedTableView!
    @IBOutlet weak var generalViewScrollView: UIView!
    @IBOutlet weak var stackViewIconsTitle: UIStackView!
    @IBOutlet weak var textRegistered: UIImageView!
    
    @IBOutlet weak var createPostButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var sugerideTopTopicTitle: UILabel!
    
    
    
    var posts : [Post2] = []
    var postsCD : [PostData] = []
    var connection : Bool = true
    var users: [User4] = []
    var topics: [TopTopic] = []
    
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
        topTopic.rowHeight = UITableView.automaticDimension
        topTopic.estimatedRowHeight = TopTopicCell.estimateRowHeight()
        tableViewPosts.dataSource = self
        tableViewPosts.delegate = self
        let cellPost = UINib(nibName: "PostCell", bundle: nil)
        tableViewPosts.register(cellPost, forCellReuseIdentifier: "PostCell")
        
        topTopic.dataSource = self
        topTopic.delegate = self
        let cellTopTopic = UINib(nibName: "TopTopicCell", bundle: nil)
        topTopic.register(cellTopTopic, forCellReuseIdentifier: "TopTopicCell")


        collectionView.dataSource = self
        collectionView.delegate = self
        let cellCollectioView = UINib(nibName: "UserCell", bundle: nil)
        collectionView.register(cellCollectioView, forCellWithReuseIdentifier: "UserCell")
    
        self.title = "Posts"


        
        viewModel.viewDidLoad()
        
        tableViewPosts.maxHeight = scrollView.frame.height+20
        topTopic.maxHeight = scrollView.frame.height+20
        
        //tableViewPosts.maxHeight = 100
        
        tableViewPosts.refreshControl = refreshControl
      
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //createView()
    }
    
    
    //MARK: - Constrains by code
    
    private func createView() {
        
      
        scrollView.translatesAutoresizingMaskIntoConstraints = true
        generalViewScrollView.translatesAutoresizingMaskIntoConstraints = true
        titleTopic.translatesAutoresizingMaskIntoConstraints = true
        stackViewIconsTitle.translatesAutoresizingMaskIntoConstraints = true
        tableViewPosts.translatesAutoresizingMaskIntoConstraints = true
        textRegistered.translatesAutoresizingMaskIntoConstraints = true
        collectionView.translatesAutoresizingMaskIntoConstraints = true
        createPostButton.translatesAutoresizingMaskIntoConstraints = true
        shareButton.translatesAutoresizingMaskIntoConstraints = true
        likeButton.translatesAutoresizingMaskIntoConstraints = true
        sugerideTopTopicTitle.translatesAutoresizingMaskIntoConstraints = true
        topTopic.translatesAutoresizingMaskIntoConstraints = true
        
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0.0),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0.0),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0)
            ])
        
        NSLayoutConstraint.activate([
            generalViewScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0),
            generalViewScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            generalViewScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            generalViewScrollView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 0.0),
            generalViewScrollView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 0.0),
            generalViewScrollView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0.0)
            
            ])
        
        NSLayoutConstraint.activate([
            titleTopic.topAnchor.constraint(equalTo: view.topAnchor, constant: 10.0),
            titleTopic.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            titleTopic.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            titleTopic.bottomAnchor.constraint(equalTo: stackViewIconsTitle.topAnchor, constant: 10.0),
            ])
        
        NSLayoutConstraint.activate([
            stackViewIconsTitle.topAnchor.constraint(equalTo: titleTopic.bottomAnchor, constant: 10.0),
            stackViewIconsTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            stackViewIconsTitle.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: -20),
            stackViewIconsTitle.bottomAnchor.constraint(equalTo: stackViewIconsTitle.topAnchor, constant: 10.0)
            ])
        
        NSLayoutConstraint.activate([
            tableViewPosts.topAnchor.constraint(equalTo: stackViewIconsTitle.bottomAnchor, constant: 10.0),
            tableViewPosts.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            tableViewPosts.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            tableViewPosts.bottomAnchor.constraint(equalTo: textRegistered.topAnchor, constant: 30.0),
            tableViewPosts.bottomAnchor.constraint(equalTo: createPostButton.topAnchor, constant: 0.0),
            tableViewPosts.bottomAnchor.constraint(equalTo: shareButton.topAnchor, constant: 0.0),
            tableViewPosts.bottomAnchor.constraint(equalTo: likeButton.topAnchor, constant: 0.0)
            ])
        
        NSLayoutConstraint.activate([
            textRegistered.topAnchor.constraint(equalTo: tableViewPosts.bottomAnchor, constant: 30.0),
            textRegistered.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            textRegistered.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            textRegistered.bottomAnchor.constraint(equalTo: sugerideTopTopicTitle.topAnchor, constant: 16.0),
            textRegistered.heightAnchor.constraint(equalToConstant: 325.0)
            ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: createPostButton.bottomAnchor, constant: 25.0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8.0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            collectionView.heightAnchor.constraint(equalToConstant: 70.0)
            ])
        
        NSLayoutConstraint.activate([
            createPostButton.topAnchor.constraint(equalTo: tableViewPosts.bottomAnchor, constant: 0.0),
            createPostButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60.0),
            createPostButton.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: 25.0)
            ])
        
        NSLayoutConstraint.activate([
            shareButton.topAnchor.constraint(equalTo: tableViewPosts.bottomAnchor, constant: 0.0),
            shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60.0)
            ])
        
        NSLayoutConstraint.activate([
           likeButton.topAnchor.constraint(equalTo: tableViewPosts.bottomAnchor, constant: 0.0),
            likeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
        NSLayoutConstraint.activate([
            sugerideTopTopicTitle.topAnchor.constraint(equalTo: textRegistered.bottomAnchor, constant: 16.0),
            sugerideTopTopicTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            sugerideTopTopicTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            sugerideTopTopicTitle.bottomAnchor.constraint(equalTo: topTopic.topAnchor, constant: 11.0)
            ])
        
        NSLayoutConstraint.activate([
            topTopic.topAnchor.constraint(equalTo: sugerideTopTopicTitle.bottomAnchor, constant: 11.0),
            topTopic.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            topTopic.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: -80.0),
            topTopic.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0)
            ])
        
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
        var count: CGFloat?
        
        if tableView == tableViewPosts {
            count = 100
        }
        else {count = 100}
        
        return count!
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int?
        
        if tableView == tableViewPosts {
            if connection {
                count =  posts.count
            } else {
                count =  postsCD.count
            }
            
        }
        if tableView == topTopic {
            print("El contador es \(topics.count)")
            count = topics.count
        }
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellFinal: UITableViewCell?
        
        if (tableView == self.tableViewPosts) {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell
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
            
            cellFinal = cell
            
        }
        if (tableView == self.topTopic) {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TopTopicCell", for: indexPath) as? TopTopicCell
                else { return UITableViewCell()
            }
            
            let titleTopic = topics[indexPath.row].title
            let numberComments = topics[indexPath.row].postsCount
            let numberVisites = topics[indexPath.row].views
            let dateTopic = topics[indexPath.row].createdAt
            
            let dateUpDate =  convertDateFormater(date: dateTopic)
            
            cell.configure(titleTopic: "\(titleTopic)", numberComments: "\(numberComments)", numberVisites: "\(numberVisites)", dateTopic: "\(dateUpDate)")
            
            cellFinal = cell
        }
        
        return cellFinal!
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
    func showListTopTopic(topics: [TopTopic])
}

extension PostsViewController: PostsViewControllerProtocol {
    func showListTopTopic(topics: [TopTopic]) {
        self.topics = topics
        self.topTopic.reloadData()
    }
    
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
