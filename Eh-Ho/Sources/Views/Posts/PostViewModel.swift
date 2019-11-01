//
//  PostViewModel.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 20/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

class PostViewModel {
    
    //MARK: - Propierties
    weak var  view: PostsViewControllerProtocol?
    private let mDataManagerPost = DataManager()
    let router: PostRouter
    let id: Int
    let postsRepository: PostsRepository
    let topicRepository: TopicsRepository
    let usersRepository: UsersRepository
    
    //MARK: - Inits
    init(router: PostRouter, id: Int, postsRepository: PostsRepository, topicRepository: TopicsRepository, usersRepository: UsersRepository) {
        self.router = router
        self.id = id
        self.postsRepository = postsRepository
        self.topicRepository = topicRepository
        self.usersRepository = usersRepository
    }
    
    //MARK: - Cycle life
    func viewDidLoad() {
        fetchListPostssByTopic()
        fetchListUsers()
        fetchListTopTopics()
        
    }
    
    //MARK: Navigations
    func didTapInTopic(id: Int) {
        router.navigateToPosts(id: id)
    }
    
    func didUpDateTopic(title: String) {
        updateSingleTopic(title: title)
    }
    
    //MARK: - Private functions
    private func fetchListPostssByTopic () {
        if CheckInternet.Connection() {
            postsRepository.getListPostssByTopic(id: id) { [weak self] result in
                switch result {
                case .success(let value):
                    self?.view?.showListPostssByTopic(posts: value.postStream.posts)
                    self?.mDataManagerPost.savePosts(post: value.postStream.posts)
                    self?.mDataManagerPost.saveLastDownload()
                    print("llega el valor")
                case .failure:
                    self?.view?.showError(with: "Error")
                }
            }
        } else {
            self.view?.showListPostsCD(post: mDataManagerPost.dataPosts(id: id))
        }
    }
    
    private func updateSingleTopic(title: String) {
        
        topicRepository.updateSingleTopic(idTopic: id, title: title) { [weak self] result in
            switch result {
            case .success:
                print("ha sido satisfactorio")
            // no enviamos nada a mostrar a la vista
            case .failure:
                self?.view?.showError(with: "Error")
                print("no ha se ha actualizado el topic")
            }
        }
        
    }
    
    private func fetchListUsers() {
        
        if CheckInternet.Connection() {
            usersRepository.getListUsers() { [weak self] result  in
                switch result {
                case .success(let value):
                    self?.view?.showListUsers(users: value.users)
                    // self?.mDataManagerUsers.saveUsers(user: value.users)
                //self?.mDataManagerUsers.saveLastDownload()
                case .failure:
                    self?.view?.showError(with: "Error")
                }
            }
        } else {
            //self.view?.showListUsersCD(users: mDataManagerUsers.dataUsers())
        }
        
    }
    
    private func fetchListTopTopics() {
        
        if CheckInternet.Connection() {
            postsRepository.getListTopTopics() { [weak self] result  in
                switch result {
                case .success(let value):
                    
                    let data = value.topicList.topics
                    print("LOS DATOS DE DATA SON : \(data)")
                    self?.view?.showListTopTopic(topics: value.topicList.topics)
                case .failure:
                    self?.view?.showError(with: "Error")
                }
            }
        } else {
            //self.view?.showListUsersCD(users: mDataManagerUsers.dataUsers())
        }
    }
    
}
