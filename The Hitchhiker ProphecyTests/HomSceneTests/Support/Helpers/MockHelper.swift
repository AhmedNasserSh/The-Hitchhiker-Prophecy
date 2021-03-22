//
//  MockHelper.swift
//  The Hitchhiker ProphecyTests
//
//  Created by Ahmed Nasser on 22/03/2021.
//  Copyright © 2021 SWVL. All rights reserved.
//

import Foundation
@testable import The_Hitchhiker_Prophecy
class MockHelper<T:Codable> {
    func getMockup(jsonFileName:String, completion:@escaping (Result<T,NetworkError>) -> ()){
        if let path = Bundle(for: type(of: self)).path(forResource: jsonFileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult =  try JSONDecoder().decode(T.self, from: data)
                completion(.success(jsonResult))
            } catch {
                completion(.failure(.cannotParseResponse))
            }
        }
    }
}
