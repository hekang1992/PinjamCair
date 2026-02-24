//
//  NetworkManager.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

import Foundation
import Alamofire
import UIKit

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    private let baseURL = "https://api.yourserver.com"
        
    private func makeRequest(
        url: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding,
        headers: HTTPHeaders? = nil,
        timeout: TimeInterval
    ) throws -> URLRequest {
        
        var request = try URLRequest(
            url: url,
            method: method,
            headers: headers
        )
        
        request.timeoutInterval = timeout
        
        return try encoding.encode(request, with: parameters)
    }
        
    func get<T: Codable>(
        _ path: String,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil
    ) async throws -> T {
        
        let url = baseURL + path
        
        let request = try makeRequest(
            url: url,
            method: .get,
            parameters: parameters,
            encoding: URLEncoding.default,
            headers: headers,
            timeout: 10
        )
        
        return try await AF.request(request)
            .validate()
            .serializingDecodable(T.self)
            .value
    }
        
    func post<T: Codable>(
        _ path: String,
        parameters: [String: String]? = nil,
        headers: HTTPHeaders? = nil
    ) async throws -> T {
        
        let url = baseURL + path
        
        var request = try URLRequest(
            url: url,
            method: .post,
            headers: headers
        )
        
        request.timeoutInterval = 30
        
        return try await AF.upload(
            multipartFormData: { multipart in
                parameters?.forEach { key, value in
                    multipart.append(
                        Data(value.utf8),
                        withName: key
                    )
                }
            },
            with: request
        )
        .validate()
        .serializingDecodable(T.self)
        .value
    }
        
    func uploadImage<T: Codable>(
        _ path: String,
        image: UIImage,
        imageName: String = "file",
        fileName: String = "image.jpg",
        parameters: [String: String]? = nil,
        headers: HTTPHeaders? = nil
    ) async throws -> T {
        
        let url = baseURL + path
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw NSError(domain: "ImageError", code: -1)
        }
        
        var request = try URLRequest(
            url: url,
            method: .post,
            headers: headers
        )
        
        request.timeoutInterval = 30
        
        return try await AF.upload(
            multipartFormData: { multipart in
                
                multipart.append(
                    imageData,
                    withName: imageName,
                    fileName: fileName,
                    mimeType: "image/jpeg"
                )
                
                parameters?.forEach { key, value in
                    multipart.append(
                        Data(value.utf8),
                        withName: key
                    )
                }
            },
            with: request
        )
        .validate()
        .serializingDecodable(T.self)
        .value
    }
}
