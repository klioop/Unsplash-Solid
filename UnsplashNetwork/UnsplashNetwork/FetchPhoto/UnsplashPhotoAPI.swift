//
//  UnsplashPhotoAPI.swift
//  UnsplashNetwork
//
//  Created by klioop on 2022/01/31.
//

import Foundation
import Entities
import RxSwift

public protocol UnsplashPhotoAPI {
    func fetchPhotos(with query: String, for page: Int) -> Single<Result<Set<Photo>, APIError>>
}
