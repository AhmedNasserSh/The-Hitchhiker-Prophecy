//
//  AccessiblityIdsReference.swift
//  The Hitchhiker ProphecyUITests
//
//  Created by Ahmed Nasser on 22/03/2021.
//  Copyright © 2021 SWVL. All rights reserved.
//

import Foundation
enum AccessiblityIdsReference {
}

//MARK: Home Scene
extension AccessiblityIdsReference {
    enum HomeSceneIds :String{
        case characterNameLabelAccessiblityIdentifier =  "characterNameLabelAccessiblityIdentifier"
        case characterImageViewAccessiblityIdentifier =  "characterImageViewAccessiblityIdentifier"
        case changeLayoutButtonAccessiblityIdentifier =  "changeLayoutButtonAccessiblityIdentifier"
        
    }
}

//MARK: Charcter Details Scene
extension AccessiblityIdsReference {
    enum CharcterDetailsSceneIds :String {
        case characterDetailsNameLabelAccessiblityIdentifier = "characterDetailsNameLabelAccessiblityIdentifier"
    }
}
