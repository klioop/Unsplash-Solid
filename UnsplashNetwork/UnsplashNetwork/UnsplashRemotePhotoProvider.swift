//
//  UnsplashRemotePhotoProvider.swift
//  UnsplashNetwork
//
//  Created by klioop on 2022/01/31.
//

import Foundation
import Entities
import Alamofire
import RxSwift

class UnsplashRemotePhotoProvider: UnsplashPhotoAPI {
    
    let session: Session
    let remoteRouter: UnsplashRemotePhotoRouter
    let photoAdater: PhotoAdapter
    
    init(session: Session = .default, remoteRouter: UnsplashRemotePhotoRouter) {
        self.session = session
        self.remoteRouter = remoteRouter
        self.photoAdater = PhotoAdapter()
    }
    
    func fetchPhotos(
        with query: String,
        for page: Int
    ) -> Single<Result<Set<Photo>, APIError>>{
        remoteRouter.updateEndPoint(.searchPhotos((query: query, page: page)))
        
        return Single.create { [unowned self] single in
            self.requestWithSession()
                .responseDecodable(of: ResponseOfSearch.self) { result in
                    let code = code(result)
                    if (200..<300) ~= code {
                        switch result.result {
                        case let .success(response):
                            single(.success(.success(self.photos(response))))
                        case .failure:
                            single(.success(.failure(.failToFetch)))
                        }
                    } else {
                        switch code {
                        case 400, 403:
                            single(.success(.failure(.invalid)))
                        default:
                            single(.success(.failure(.etc)))
                        }
                    }
                }
            return Disposables.create()
        }
            
    }
    
}

// MARK: - Helpers

extension UnsplashRemotePhotoProvider {
    private func requestWithSession() -> DataRequest {
        let encoder = URLEncodedFormParameterEncoder(destination: remoteRouter.destination)
        
        return session.request(
            remoteRouter.url,
            method: remoteRouter.method,
            parameters: remoteRouter.parameters,
            encoder: encoder,
            headers: remoteRouter.headers
        ).validate()
    }
    
    private func photos(_ response: ResponseOfSearch) -> Set<Photo> {
        return Set(response.results.map(photoAdater.toPhoto(_:)))
    }
    
    private func code(_ data: DataResponse<ResponseOfSearch, AFError>) -> Int {
        return data.response?.statusCode ?? -1
    }
}
