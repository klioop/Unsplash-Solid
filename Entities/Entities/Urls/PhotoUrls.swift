//
//  PhotoUrls.swift
//  Entities
//
//  Created by klioop on 2022/01/31.
//

import Foundation

public struct PhotoUrls {
    
    public let raw, small, regular, full: String
    
    public init(raw: String, small: String, regular: String, full: String) {
        self.raw = raw
        self.small = small
        self.regular = regular
        self.full = full
    }
}
