//
//  SingleTopicResponse.swift
//  Eh-Ho
//
//  Created by Ignacio Garcia Sainz on 17/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation



// MARK: - SingleTopicResponse

struct SingleTopicResponse2: Codable {
    

    
    let id: Int
    let title: String
    let userID: Int
    let details: Details2

    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case title = "title"
        case userID = "user_id"
        case details = "details"
        
    }
    
}


// MARK: - Details

struct Details2: Codable {

    let createdBy: CreatedBy2
    
    enum CodingKeys: String, CodingKey {

        case createdBy = "created_by"
    }
    
}



// MARK: - CreatedBy

struct CreatedBy2: Codable {
    
    let id: Int
    
    let username: String
    
    let name: String
    
    let avatarTemplate: String
    
    
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        
        case username = "username"
        
        case name = "name"
        
        case avatarTemplate = "avatar_template"
        
    }
    
}







