//
//  ServiceManager.swift
//  Abstract
//
//  Created by Silvano Maneck Malfatti on 31/03/25.
//

import Foundation

class ServiceManager {

    private static let session = URLSession.shared
    private static let operationQueue = OperationQueue()

    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
        case patch = "PATCH"
    }

    // MARK: - Generic Request
    static func request<T: Decodable, U: Encodable>(
        urlString: String,
        method: HTTPMethod,
        payload: U? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        let operation = BlockOperation {
            guard let url = URL(string: urlString) else { return }

            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            if let payload = payload {
                guard let payloadData = try? JSONEncoder().encode(payload) else { return }
                request.httpBody = payloadData
            }

            session.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }

                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch let decodingError {
                    completion(.failure(decodingError))
                }
            }.resume()
        }
        operationQueue.addOperation(operation)
    }
    
    static func request<T: Decodable>(
        urlString: String,
        method: HTTPMethod,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        request(urlString: urlString, method: method, payload: Optional<String>.none, completion: completion)
    }
}
