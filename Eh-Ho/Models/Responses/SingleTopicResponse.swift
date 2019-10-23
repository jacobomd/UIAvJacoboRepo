//
//  SingleTopicResponse.swift
//  Eh-Ho
//
//  Created by Ignacio Garcia Sainz on 17/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import Foundation



// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct SingleTopicResponse: Codable {
    let postStream: PostStream
    let timelineLookup: [TimelineLookup]
    let id: Int
    let title, fancyTitle: String
    let postsCount: Int
    let createdAt: String
    let views, replyCount, participantCount, likeCount: Int
    let lastPostedAt: HammerfestPonies
    let visible, closed, archived, hasSummary: Bool
    let archetype, slug: String
    let categoryID: Int
    let wordCount, deletedAt: HammerfestPonies
    let userID: Int
    let draft: HammerfestPonies
    let draftKey: String
    let draftSequence, unpinned: HammerfestPonies
    let pinnedGlobally, pinned: Bool
    let pinnedAt: String
    let pinnedUntil: HammerfestPonies
    let details: Details
    let highestPostNumber: Int
    let deletedBy: HammerfestPonies
    let actionsSummary: [ActionsSummary]
    let chunkSize: Int
    let bookmarked: HammerfestPonies
    
    enum CodingKeys: String, CodingKey {
        case postStream = "post_stream"
        case timelineLookup = "timeline_lookup"
        case id, title
        case fancyTitle = "fancy_title"
        case postsCount = "posts_count"
        case createdAt = "created_at"
        case views
        case replyCount = "reply_count"
        case participantCount = "participant_count"
        case likeCount = "like_count"
        case lastPostedAt = "last_posted_at"
        case visible, closed, archived
        case hasSummary = "has_summary"
        case archetype, slug
        case categoryID = "category_id"
        case wordCount = "word_count"
        case deletedAt = "deleted_at"
        case userID = "user_id"
        case draft
        case draftKey = "draft_key"
        case draftSequence = "draft_sequence"
        case unpinned
        case pinnedGlobally = "pinned_globally"
        case pinned
        case pinnedAt = "pinned_at"
        case pinnedUntil = "pinned_until"
        case details
        case highestPostNumber = "highest_post_number"
        case deletedBy = "deleted_by"
        case actionsSummary = "actions_summary"
        case chunkSize = "chunk_size"
        case bookmarked
    }
}

// MARK: - ActionsSummary
struct ActionsSummary5: Codable {
    let id, count: Int
    let hidden, canAct: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, count, hidden
        case canAct = "can_act"
    }
}

// MARK: - HammerfestPonies
struct HammerfestPonies: Codable {
}

// MARK: - Details
struct Details: Codable {
    let autoCloseAt, autoCloseHours: HammerfestPonies
    let autoCloseBasedOnLastPost: Bool
    let createdBy, lastPoster: CreatedBy
    let participants: [CreatedBy]
    let suggestedTopics: [SuggestedTopic]
    let notificationLevel: Int
    let canFlagTopic: Bool
    
    enum CodingKeys: String, CodingKey {
        case autoCloseAt = "auto_close_at"
        case autoCloseHours = "auto_close_hours"
        case autoCloseBasedOnLastPost = "auto_close_based_on_last_post"
        case createdBy = "created_by"
        case lastPoster = "last_poster"
        case participants
        case suggestedTopics = "suggested_topics"
        case notificationLevel = "notification_level"
        case canFlagTopic = "can_flag_topic"
    }
}

// MARK: - CreatedBy
struct CreatedBy: Codable {
    let id: Int
    let username, avatarTemplate: String
    let postCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, username
        case avatarTemplate = "avatar_template"
        case postCount = "post_count"
    }
}

// MARK: - SuggestedTopic
struct SuggestedTopic: Codable {
    let id: Int
    let title, fancyTitle, slug: String
    let postsCount, replyCount, highestPostNumber: Int
    let imageURL, createdAt, lastPostedAt: String
    let bumped: Bool
    let bumpedAt: String
    let unseen, pinned: Bool
    let unpinned: HammerfestPonies
    let excerpt: String
    let visible, closed, archived: Bool
    let bookmarked, liked: HammerfestPonies
    let archetype: String
    let likeCount, views, categoryID: Int
    let posters: [Poster5]
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case fancyTitle = "fancy_title"
        case slug
        case postsCount = "posts_count"
        case replyCount = "reply_count"
        case highestPostNumber = "highest_post_number"
        case imageURL = "image_url"
        case createdAt = "created_at"
        case lastPostedAt = "last_posted_at"
        case bumped
        case bumpedAt = "bumped_at"
        case unseen, pinned, unpinned, excerpt, visible, closed, archived, bookmarked, liked, archetype
        case likeCount = "like_count"
        case views
        case categoryID = "category_id"
        case posters
    }
}

// MARK: - Poster
struct Poster5: Codable {
    let extras, posterDescription: String
    let user: CreatedBy
    
    enum CodingKeys: String, CodingKey {
        case extras
        case posterDescription = "description"
        case user
    }
}

// MARK: - PostStream
struct PostStream: Codable {
    let posts: [Post]
    let stream: [HammerfestPonies]
}

// MARK: - Post
struct Post: Codable {
    let id: Int
    let name, username, avatarTemplate, createdAt: String
    let cooked: String
    let postNumber, postType: Int
    let updatedAt: String
    let replyCount: Int
    let replyToPostNumber: HammerfestPonies
    let quoteCount: Int
    let avgTime: HammerfestPonies
    let incomingLinkCount, reads, score: Int
    let yours: Bool
    let topicID: Int
    let topicSlug, displayUsername: String
    let primaryGroupName, primaryGroupFlairURL, primaryGroupFlairBgColor, primaryGroupFlairColor: HammerfestPonies
    let version: Int
    let canEdit, canDelete, canRecover, canWiki: Bool
    let read: Bool
    let userTitle: HammerfestPonies
    let actionsSummary: [HammerfestPonies]
    let moderator, admin, staff: Bool
    let userID: Int
    let hidden: Bool
    let hiddenReasonID: HammerfestPonies
    let trustLevel: Int
    let deletedAt: HammerfestPonies
    let userDeleted: Bool
    let editReason: HammerfestPonies
    let canViewEditHistory, wiki: Bool
    let polls: Polls
    let pollsVotes: PollsVotes
    
    enum CodingKeys: String, CodingKey {
        case id, name, username
        case avatarTemplate = "avatar_template"
        case createdAt = "created_at"
        case cooked
        case postNumber = "post_number"
        case postType = "post_type"
        case updatedAt = "updated_at"
        case replyCount = "reply_count"
        case replyToPostNumber = "reply_to_post_number"
        case quoteCount = "quote_count"
        case avgTime = "avg_time"
        case incomingLinkCount = "incoming_link_count"
        case reads, score, yours
        case topicID = "topic_id"
        case topicSlug = "topic_slug"
        case displayUsername = "display_username"
        case primaryGroupName = "primary_group_name"
        case primaryGroupFlairURL = "primary_group_flair_url"
        case primaryGroupFlairBgColor = "primary_group_flair_bg_color"
        case primaryGroupFlairColor = "primary_group_flair_color"
        case version
        case canEdit = "can_edit"
        case canDelete = "can_delete"
        case canRecover = "can_recover"
        case canWiki = "can_wiki"
        case read
        case userTitle = "user_title"
        case actionsSummary = "actions_summary"
        case moderator, admin, staff
        case userID = "user_id"
        case hidden
        case hiddenReasonID = "hidden_reason_id"
        case trustLevel = "trust_level"
        case deletedAt = "deleted_at"
        case userDeleted = "user_deleted"
        case editReason = "edit_reason"
        case canViewEditHistory = "can_view_edit_history"
        case wiki, polls
        case pollsVotes = "polls_votes"
    }
}

// MARK: - Polls
struct Polls: Codable {
    let poll: Poll
}

// MARK: - Poll
struct Poll: Codable {
    let options: [Option]
    let voters: Int
    let status, name, type: String
}

// MARK: - Option
struct Option: Codable {
    let id, html: String
    let votes: Int
}

// MARK: - PollsVotes
struct PollsVotes: Codable {
    let poll: [String]
}

// MARK: - TimelineLookup
struct TimelineLookup: Codable {
    let the0: [HammerfestPonies]
    
    enum CodingKeys: String, CodingKey {
        case the0 = "0"
    }
}
