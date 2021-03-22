//
//  ResultExtension.swift
//  The Hitchhiker ProphecyTests
//
//  Created by Ahmed Nasser on 22/03/2021.
//  Copyright © 2021 SWVL. All rights reserved.
//

import Foundation
extension Result {
    func getSuccessData() -> Success? {
        switch self {
        case .success(let data):
            return data
        default:
            return nil
        }
    }
}
