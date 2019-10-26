//
//  PostsViewController.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 20/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {

    @IBOutlet weak var tableViewPosts: UITableView!
    @IBOutlet weak var titleTopic: UILabel!
    
    var posts : [Post2] = []
    var postsCD : [PostData] = []
    var connection : Bool = true
    
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
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewPosts.dataSource = self
        tableViewPosts.delegate = self
        tableViewPosts.rowHeight = 60
        self.title = "Posts"
        
        tableViewPosts.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
        
        viewModel.viewDidLoad()
        
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
    
    @IBAction func ButtonAddPost(_ sender: Any) {
        
        viewModel.didTapInTopic(id: self.id)
    }

}

extension PostsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if connection {
            return posts.count
        } else {
            return postsCD.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewPosts.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath)
        
        
        
        if connection {
            cell.textLabel?.text = posts[indexPath.row].cooked
            id = posts[indexPath.row].topicID
            editable_topic  = posts[indexPath.row].canEdit
            var titulo = posts[indexPath.row].topicSlug
            
            titulo = titulo.replacingOccurrences(of: "-", with: " ", options: NSString.CompareOptions.literal, range: nil).capitalizingFirstLetter()
            titleTopic.text = titulo
      
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

// MARK: - ViewModel Communication

protocol PostsViewControllerProtocol: class {
    func showListPostssByTopic(posts: [Post2])
    func showError(with message: String)
    func showListPostsCD(post: [PostData])
}

extension PostsViewController: PostsViewControllerProtocol {


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
