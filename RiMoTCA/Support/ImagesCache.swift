//
//  ImagesCache.swift
//  RiMo
//
//  Created by Javier Calartrava on 9/6/24.
//

import Foundation
@MainActor
internal final class ImagesCache: NSCache<AnyObject, AnyObject> {
    // MARK: - Constants
    static let shared = ImagesCache()

    // MARK: - Lifecycle/Overridden
    private override init() {
        super.init()
    }
}
