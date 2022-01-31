//
//  PhotoAdapter.swift
//  Entities
//
//  Created by klioop on 2022/01/31.
//

import Foundation

class PhotoAdapter {
    let response: ResponseOfPhotoInfo
    
    init(response: ResponseOfPhotoInfo) {
        self.response = response
    }
    
    func toPhoto(_ response: ResponseOfPhotoInfo) -> Photo {
        let urls = PhotoUrls(raw: response.urls.raw, small: response.urls.small, regular: response.urls.regular, full: response.urls.full)
        
        return Photo(id: response.id, author: response.user.name, width: response.width, height: response.height, likes: response.likes, likedByUser: response.likedByUser, urls: urls)
    }
}
