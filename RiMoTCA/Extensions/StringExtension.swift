//
//  StringExtension.swift
//  RiMo
//
//  Created by Javier Calartrava on 9/6/24.
//

import Foundation

extension String {
   
    var localized: String {

        return NSLocalizedString(self,
                                 tableName: nil,
                                 bundle: Bundle.main ,
                                 value: "",
                                 comment: "")
    }
}
