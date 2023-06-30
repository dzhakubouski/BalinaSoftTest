//
//  NetworkManager.swift
//  BalinaSoftTest
//
//  Created by Admin on 30.06.23.
//

import Foundation

final class NetworkManager {
    
    private let url: URL
    private let jsonParser: JSONParser
    
    init?(url: URL) {
        self.url = url
        jsonParser = JSONParser()
    }
    
    func fetch<Model: Decodable>(model: Model.Type,
                                 usingHTTPMethod method: HTTPMethod,
                                 completion: @escaping (Result<Decodable, Error>) -> Void) {
        let session = self.makeURLSession(httpMethod: method) { [self] data in
            
            self.jsonParser.parse(type: model,
                                  from: data) { result in
                switch result {
                    
                case .success(let decodedObject):
                    completion(.success(decodedObject))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        
        session.resume()
    }
    
        private func makeURLRequest(withHTTPMethod method: HTTPMethod) -> URLRequest {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = method.rawValue
    
            return urlRequest
        }
    
    private func makeURLSession(httpMethod: HTTPMethod,
                                completionHandler: @escaping (Data) -> Void) -> URLSessionDataTask {
        let request = self.makeURLRequest(withHTTPMethod: httpMethod)
        let session = URLSession.shared.dataTask(with: request) { data, _, error in
            guard error == nil,
                  let data = data else { return }
            completionHandler(data)
        }
        
        return session
    }
}
