//
//  RequestURN.swift
//  CoreDataTask
//
//  Created by Snehal Garbhe on 3/21/19.
//  Copyright © 2019 Snehal Garbhe. All rights reserved.
//

import Foundation

protocol RequestURN {
    var url: String  { get }
    var urn: String { get }
}

extension RequestURN {

    var url: String {
        return ""
    }

    var urn: String {
        return ""
    }

}
