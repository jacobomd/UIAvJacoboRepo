//
//  TopicsViewModel.swift
//  Eh-Ho
//
//  Created by Ignacio Garcia Sainz on 16/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

class TopicsViewModel {
    
    //MARK: - Propierties
    weak var view: TopicsViewControllerProtocol?
    var singleTopic: SingleTopicResponse2?
    private let mDataManagerTopic = DataManager()
    let router: TopicsRouter
    let id: Int
    let topicsRepository: TopicsRepository
    
    //MARK: - Inits
    init(router: TopicsRouter, topicsRepository: TopicsRepository, id: Int) {
        self.router = router
        self.topicsRepository = topicsRepository
        self.id = id
    }
    
    //MARK: - Cycle life
    func viewDidLoad() {
        fetchListTopicsByCategory()
    }
    
    //MARK: - Navigations
    func didTapInTopic(id: Int) {
        router.navigateToPosts(id: id)
    }
    
    //MARK: - Functions
    func fetchSingleTopic(id: Int)  {
        topicsRepository.getSingleTopicById(id: id) { result in
            switch result {
            case .success(let value):
                //Enviariamos a la vista para mostrar la info
                self.view?.showSingleTopicById(singleTopic: value)
            case .failure(let error):
                //Enviaremos a la vista el error
                print("\(error)")
            }
        }
    }

    //MARK: - Private functions
    private func fetchListTopicsByCategory() {
        if CheckInternet.Connection() {
            topicsRepository.getListTopicsByCategory(id: id) { [weak self] result in
                switch result {
                case .success(let value):
                    self?.view?.showListTopicsByCategory(topics: value.topicList.topics, users: value.users)
                    self?.mDataManagerTopic.saveTopics(topic: value.topicList.topics)
                    self?.mDataManagerTopic.saveLastDownload()
                case .failure:
                    self?.view?.showError(with: "Error")
                }
            }
        } else {
            self.view?.showListTopicsCD(topics: mDataManagerTopic.dataTopics(id: id))
        }
    }
    
}
