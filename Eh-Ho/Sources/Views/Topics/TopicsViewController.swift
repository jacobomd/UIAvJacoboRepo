//
//  TopicsViewController.swift
//  Eh-Ho
//
//  Created by Ignacio Garcia Sainz on 16/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class TopicsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var text_Descrip: UIImageView!
    @IBOutlet weak var temas_Title: UILabel!
    @IBOutlet weak var buttonAddTopic: UIButton!
    @IBOutlet weak var buttonAddTopicBig: UIButton!
    @IBOutlet weak var buttonSearch: UIButton!
    
    
    
    
    lazy var refreshControl:UIRefreshControl = {
        let refresControl = UIRefreshControl()
        //QUE AL CAMBIAR EL VALOR, SE EJECUTE UN MÉTODO
        refresControl.addTarget(self, action: #selector(TopicsViewController.actualizarDatos(_:)), for: .valueChanged)
        //ESTABLECER EL COLOR DE LA RULETILLA
        refresControl.tintColor = UIColor.blue
        return refresControl
    }()
    
    @objc func actualizarDatos(_ refresControl: UIRefreshControl){
        //AQUI TU TIENES QUE ACTUALIZAR TUS DATOS. TU DATASOURCE. LLAMAR A TU SERVIDOR, VOLVER A TRAER LOS DATOS. ELIMINAR O AÑADIR AL ELEMENTO PERSISTIDO
        
        viewModel.viewDidLoad()
        //REFRESCO LA VISTA DE TABLA
        self.tableView.reloadData()
        //PARO EL REFRESH CONTROL
        refresControl.endRefreshing()
        
    }
    
    let viewModel: TopicsViewModel
    var topics: [Topic] = []
    var singleTopic: SingleTopicResponse2?
    var avatarUserTopic: String?
    var idTopics: Int = 0
    var users: [User] = []
    var topicsCD : [TopicData] = []
    var connection : Bool = true
    
    init(topicsViewModel: TopicsViewModel) {
        self.viewModel = topicsViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = TopicCell.estimateRowHeight()
        
        let cell = UINib(nibName: "TopicCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: UITableViewCell.identifier)
        
        viewModel.viewDidLoad()
        tableView.refreshControl = refreshControl

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //createView()
    }
    
    
    private func createView() {
        
        buttonAddTopic.translatesAutoresizingMaskIntoConstraints = false
        buttonSearch.translatesAutoresizingMaskIntoConstraints = false
        temas_Title.translatesAutoresizingMaskIntoConstraints = false
        text_Descrip.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        buttonAddTopicBig.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonAddTopic.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            buttonAddTopic.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            buttonAddTopic.bottomAnchor.constraint(equalTo: temas_Title.topAnchor, constant: 0.0)
            ])
        
        NSLayoutConstraint.activate([
            buttonSearch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            buttonSearch.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0)
            ])
        
        NSLayoutConstraint.activate([
            temas_Title.topAnchor.constraint(equalTo: buttonAddTopic.bottomAnchor, constant: 0.0),
            temas_Title.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0),
            temas_Title.trailingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 10.0),
            temas_Title.bottomAnchor.constraint(equalTo: text_Descrip.topAnchor, constant: 0.0),
            ])
        
        NSLayoutConstraint.activate([
            text_Descrip.topAnchor.constraint(equalTo: temas_Title.bottomAnchor, constant: 0.0),
            text_Descrip.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0.0),
            text_Descrip.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0.0),
            text_Descrip.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: 0.0)
            ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: text_Descrip.bottomAnchor, constant: 0.0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0.0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0.0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0)
            ])
        
        NSLayoutConstraint.activate([
            buttonAddTopicBig.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50.0),
            buttonAddTopicBig.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0)
            ])
        
    }
    
    
    @IBAction func buttonAddTopic(_ sender: Any) {
        navigationController?.pushViewController(CreateTopicsRouter.configureModule(), animated: true)
    }
    

    
    @IBAction func buttonAddTopicBig(_ sender: Any) {
        navigationController?.pushViewController(CreateTopicsRouter.configureModule(), animated: true)
    }
    
    
}

extension TopicsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if connection {
            return topics.count
        } else {
            return topicsCD.count
        }
    }
        
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath)
            as? TopicCell else {
                return UITableViewCell()
        }
        
        if connection {
            
            idTopics = topics[indexPath.row].id
            viewModel.didTapSingleTopic(id: idTopics)
            
            //let avatar = singleTopic?.title
            
            //print("el avatar es : \(avatar)")
            
            let title = topics[indexPath.row].title
            let numVisitas = topics[indexPath.row].views
            let numComents = topics[indexPath.row].postsCount
            let dateTopic = topics[indexPath.row].createdAt!
            

            
            let dateTopicFormater = convertDateFormater(date: dateTopic)
 
           // cell.configure(title: title, numVisitas: "\(numVisitas)", numComents: "\(numComents)", dateTopic: "\(dateTopicFormater)", avatarUser: avatarUser!)
            
            cell.configure(title: title, numVisitas: "\(numVisitas)", numComents: "\(numComents)", dateTopic: "\(dateTopicFormater)")
            
        } else {
//            let title = topicsCD[indexPath.row].title
//            let numVisitas = topicsCD[indexPath.row].views
//            let numComents = topicsCD[indexPath.row].postsCount
//            let dateTopic = topicsCD[indexPath.row].createdAt
//            cell.configure(title: title, numVisitas: "\(numVisitas)", numComents: "\(numComents)", dateTopic: dateTopic!)
        }
        
        return cell
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
}

extension TopicsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if connection {
            let id = topics[indexPath.row].id
            viewModel.didTapInTopic(id: id)
        } else {
            let id = topicsCD[indexPath.row].topicId
            viewModel.didTapInTopic(id: id)
        }
    }
}

// MARK: - ViewModel Communication
protocol TopicsViewControllerProtocol: class {
    func showListTopicsByCategory(topics: [Topic], users: [User])
    func showSingleTopicById(singleTopic: SingleTopicResponse2)
    func showError(with message: String)
    func showListTopicsCD(topics: [TopicData])
}

extension TopicsViewController: TopicsViewControllerProtocol {

    
    func showListTopicsByCategory(topics: [Topic], users: [User]) {
        self.topics = topics
        self.users = users
        self.tableView.reloadData()
    }
    
    func showSingleTopicById(singleTopic: SingleTopicResponse2) {
        self.singleTopic = singleTopic
        print(" ahora dentro de la vista : \(singleTopic.userID)")
    }
    
    func showError(with message: String) {
        //AQUI ENSEÑAMOS ALERTA
        print("ERROR")
    }
    
    func showListTopicsCD(topics: [TopicData]) {
        connection = false
        topicsCD = topics
    }
}
