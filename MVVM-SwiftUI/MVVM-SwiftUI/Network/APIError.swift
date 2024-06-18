//
//  APIError.swift
//  MVVM-SwiftUI
//
//  Created by Jasminy Duarte on 18/06/24.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case unableToComplete
    case invalidResponse
    case invalidData
}
