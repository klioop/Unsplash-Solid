//
//  Response.swift
//  UnsplashNetwork
//
//  Created by klioop on 2022/01/31.
//

import Foundation

public struct ResponseOfSearch: Codable {
    public let results: [ResponseOfPhotoInfo]
}

public struct ResponseOfPhotoInfo: Codable {
    public let id: String
    public let width, height, likes: Int
    public let likedByUser: Bool
    public let user: User
    public let urls: Urls
    
    enum CodingKeys: String, CodingKey {
        case id, width, height, likes, user, urls
        case likedByUser = "liked_by_user"
    }
}

public struct ResponseOfPhoto: Codable {
    public let photo: ResponseOfPhotoInfo
    public let user: User
}

public struct ResponseOfPhotoWithOutUser: Codable {
    public let id: String
    public let width, height, likes: Int
    public let likedByUser: Bool
    public let urls: Urls
    
    enum CodingKeys: String, CodingKey {
        case id, width, height, likes, urls
        case likedByUser = "liked_by_user"
    }
}

public struct User: Codable {
    public let id: String
    public let username: String
    public let name: String
}

public struct Urls: Codable {
    public let raw: String
    public let full: String
    public let regular: String
    public let small: String
}
