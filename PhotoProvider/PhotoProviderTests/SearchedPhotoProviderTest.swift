//
//  SearchedPhotoProviderTest.swift
//  PhotoProviderTests
//
//  Created by klioop on 2022/02/01.
//

import Foundation
import XCTest
import UnsplashNetwork
import Entities
import RxSwift

@testable import PhotoProvider

class SearchedPhotoProvider: XCTestCase {
    
    func test_sut_photos_returnObservablePhotoPresenter() {
        let sut = makeSUT()
        let spy = StateSpy(photoLoader: sut)
        spy.loadPhotos()
        
        XCTAssertEqual(spy.presenters.count, 0)
        
    }
    
    class StateSpy {
        var presenters: [PhotoPresenter] = []
        let photoLoader: SearchedPhotoLoader
        
        private let bag = DisposeBag()
        
        init(photoLoader: SearchedPhotoLoader) {
            self.photoLoader = photoLoader
        }
        
        func loadPhotos() {
            photoLoader.photos(query: "", page: 0)
                .subscribe(onNext: { [weak self] in
                    self?.presenters.append($0)
                })
                .disposed(by: bag)
        }
    }
    
    private func makeSUT() -> SearchedPhotoLoader {
        let photoAPI = UnsplashPhotoAPIStub()
        
        return SearchedPhotoLoader(remotePhotoProvider: photoAPI)
    }
    
    class UnsplashPhotoAPIStub: UnsplashPhotoAPI  {
        
        let photo1 = Photo(id: "a", author: "", width: 0, height: 0, likes: 0, likedByUser: false, urls: .init(raw: "", small: "", regular: "", full: ""))
        let photo2 = Photo(id: "b", author: "", width: 0, height: 0, likes: 0, likedByUser: false, urls: .init(raw: "", small: "", regular: "", full: ""))
        let apiError: APIError = .failToFetch
        var errorFlag = false
        
        
        func fetchPhotos(with query: String, for page: Int) -> Single<Result<Set<Photo>, APIError>> {
            let photos = Set.init([photo1, photo2])
            
            return errorFlag ? .just(.failure(apiError)) : .just(.success(photos))
        }
    }
    
}
