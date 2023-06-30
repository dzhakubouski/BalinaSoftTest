//
//  JSONParser.swift
//  BalinaSoftTest
//
//  Created by Admin on 30.06.23.
//

import Foundation

final class JSONParser {
    
    typealias ResultBlock<T> = (Result<T, Error>) -> Void
    
    func parse<T: Decodable>(type: T.Type,
                             from data: Data,
                             resultBlock: ResultBlock<T>) {
        do {
            let decodedData: T = try JSONDecoder().decode(type.self, from: data)
            resultBlock(.success(decodedData))
            
        } catch let error {
            resultBlock(.failure(error))
        }
    }
}
