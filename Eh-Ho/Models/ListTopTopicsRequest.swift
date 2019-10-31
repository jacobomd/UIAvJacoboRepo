//
//  ListCategoriesRequest.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 19/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation

struct ListTopTopicsRequest: APIRequest {
    
    typealias Response = ListTopTopicsResponse
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/top.json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return [:]
    }
    
    var headers: [String : String] {
        return [:]
    }
    
}
