//
//  Photo.swift
//  Entities
//
//  Created by klioop on 2022/01/31.
//

import Foundation

public struct Photo {
    public let id, author: String
    public let width, height, likes: Int
    public let likedByUser: Bool
    public let urls: PhotoUrls
}

extension Photo: Equatable {
    public static func ==(lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Photo: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
