//
//  TopicsViewModel.swift
//  Eh-Ho
//
//  Created by Ignacio Garcia Sainz on 16/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

class TopicsViewModel {
    
    weak var view: TopicsViewControllerProtocol?
    
    private let mDataManagerTopic = DataManager()
    
    let router: TopicsRouter
    let id: Int
    let topicsRepository: TopicsRepository
    
    init(router: TopicsRouter, topicsRepository: TopicsRepository, id: Int) {
        self.router = router
        self.topicsRepository = topicsRepository
        self.id = id
    }
    
    func viewDidLoad() {
        fetchListTopicsByCategory()
        
    }
    
    func didTapInTopic(id: Int) {
        router.navigateToPosts(id: id)
    }
    
    func didTapSingleTopic(id: Int) {
        fetchSingleTopic(id: id)
    }
    
    func enviarData(singleTopic: SingleTopicResponse2) {
        
    }
    
    private func fetchListTopicsByCategory() {
        if CheckInternet.Connection() {
       topicsRepository.getListTopicsByCategory(id: id) { [weak self] result in
           switch result {
           case .success(let value):
            self?.view?.showListTopicsByCategory(topics: value.topicList.topics, users: value.users)
              self?.mDataManagerTopic.saveTopics(topic: value.topicList.topics)
              self?.mDataManagerTopic.saveLastDownload()
            print("llega el valor de la lissta de topicsssss")
          case .failure:
                self?.view?.showError(with: "Error")
           }
        }
        } else {
            self.view?.showListTopicsCD(topics: mDataManagerTopic.dataTopics(id: id))
        }
    }
    
    private func fetchSingleTopic(id: Int) {
        topicsRepository.getSingleTopicById(id: id) { result in
            switch result {
            case .success(let value):
                //Enviariamos a la vista para mostrar la info
                
                self.view?.showSingleTopicById(singleTopic: value)
                print("LLEGA EL VALOR")
            case .failure(let error):
                //Enviaremos a la vista el error
                print("\(error)")
                break
            }
        }
    }
}
