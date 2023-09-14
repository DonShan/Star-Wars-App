//
//  ServiceError.swift
//  Star Wars App
//
//  Created by Madushan Senavirathna on 2023-09-15.
//

import Foundation

enum ServiceError: Error {
    case invalidURL
    case invalidResponse
    case invalidStatusCode(Int)
    case noDataReceived
}
