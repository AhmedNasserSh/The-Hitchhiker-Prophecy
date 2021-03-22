//
//  ResponseMockHelper.swift
//  The Hitchhiker ProphecyTests
//
//  Created by Ahmed Nasser on 22/03/2021.
//  Copyright © 2021 SWVL. All rights reserved.
//

import Foundation
@testable import The_Hitchhiker_Prophecy
class ResponseMockHelper<T:Codable> {
    func getMockResponse(jsonFileName:String) -> Result<T,NetworkError>{
        if let path = Bundle(for: type(of: self)).path(forResource: jsonFileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult =  try JSONDecoder().decode(T.self, from: data)
                return .success(jsonResult)
            } catch {
                return .failure(.cannotParseResponse)
            }
        }
        return .failure(.unknown)
    }
}
