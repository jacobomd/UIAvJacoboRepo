// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct ListTopTopicsResponse: Codable {
    //let usersTopTopic: [UsersTopTopic]
    let topicList: TopTopicList
    
    enum CodingKeys: String, CodingKey {
       // case usersTopTopic
        case topicList = "topic_list"
    }
}

// MARK: - TopicList
struct TopTopicList: Codable {

    let topics: [TopTopic]
    
    enum CodingKeys: String, CodingKey {
        case topics
    }
}

// MARK: - Topic
struct TopTopic: Codable {
    let id: Int
    let title, slug: String
    let postsCount: Int
    let createdAt: String
    let views, likeCount: Int

    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case slug
        case postsCount = "posts_count"
        case createdAt = "created_at"
        case views
        case likeCount = "like_count"
    }
}










