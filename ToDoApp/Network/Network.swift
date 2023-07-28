//
//  Network.swift
//  ToDoApp
//
//  Created by Zeki Gökcen on 14.07.2023.
//

import Foundation

protocol APIRequest {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryParams: [String: String]? { get }
    var body: Encodable? { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

struct APIConstants {
    static var basedURL: String = "https://dummyjson.com"
}

enum HTTPHeaderField: String {
    case authentication = "Authentication"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case authorization = "Authorization"
    case acceptLanguage = "Accept-Language"
    case userAgent = "User-Agent"
}

enum ContentType: String {
    case json = "application/json"
    case xwwwformurlencoded = "application/x-www-form-urlencoded"
}

enum SecretKey: String {
    case key = "xxx"
}

class APIService {
    private let baseURL: URL
    
    init(baseURL: URL = URL(string: APIConstants.basedURL)!) {
        self.baseURL = baseURL
    }

    func perform<T: APIRequest, R: Decodable>(request: T, response: R.Type, completion: @escaping (Result<R, Error>) -> Void) {
        let url = buildURL(with: request)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        if let body = request.body {
            let encoder = JSONEncoder()
            if let encodedBody = try? encoder.encode(body) {
                urlRequest.httpBody = encodedBody
            }
        }

        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                return
            }
            
            let decoder = JSONDecoder()
            if let decodedResponse = try? decoder.decode(R.self, from: data) {
                completion(.success(decodedResponse))
            } else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
            }
        }
        
        task.resume()
    }
    
    private func buildURL<T: APIRequest>(with request: T) -> URL {
        var components = URLComponents(url: baseURL.appendingPathComponent(request.path), resolvingAgainstBaseURL: false)
        
        if let queryParams = request.queryParams {
            components?.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        return components?.url ?? baseURL.appendingPathComponent(request.path)
    }
}

