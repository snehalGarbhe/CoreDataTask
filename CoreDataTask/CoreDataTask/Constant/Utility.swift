//
//  Utility.swift
//  CoreDataTask
//
//  Created by Snehal Garbhe on 3/21/19.
//  Copyright © 2019 Snehal Garbhe. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ success: Bool, AnyObject?) -> Void

class Utility: NSObject {
    static let sharedInstance = Utility()
    private override init() {
    }
}

extension Sequence where Iterator.Element == String {
    func joinWithPathSeparator() -> String {
        return self.joined(separator: "/")
    }
}

