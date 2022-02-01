//
//  SearchPhotos.swift
//  PhotoProvider
//
//  Created by klioop on 2022/02/01.
//

import Foundation
import UnsplashNetwork
import RxSwift


public protocol SearchPhotos {
    func photos(query: String, page: Int) -> Observable<PhotoPresenter>
}

public class SearchedPhotoLoader: SearchPhotos {
    
    let remotePhotoProvider: UnsplashPhotoAPI
    
    private let bag = DisposeBag()
    
    init(remotePhotoProvider: UnsplashPhotoAPI) {
        self.remotePhotoProvider = remotePhotoProvider
    }
    
    public func photos(query: String, page: Int) -> Observable<PhotoPresenter> {
        return remotePhotoProvider.fetchPhotos(with: query, for: page)
            .map { result -> PhotoPresenter in
                switch result {
                case let .success(photos):
                    return PhotoPresenter(photos: photos, errorCode: nil)
                case let .failure(error):
                    return PhotoPresenter(photos: nil, errorCode: error.rawValue)
                }
            }
            .asObservable()
    }
    
}
