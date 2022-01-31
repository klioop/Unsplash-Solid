//
//  CutomError.swift
//  Entities
//
//  Created by klioop on 2022/01/31.
//

import Foundation

public enum APIError: Int, Error {
    case invalid = 400
    case failToFetch = -1
    case etc = -2
}
