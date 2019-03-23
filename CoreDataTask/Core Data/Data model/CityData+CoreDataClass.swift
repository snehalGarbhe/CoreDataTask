//
//  CityData+CoreDataClass.swift
//  CoreDataTask
//
//  Created by Snehal Garbhe on 3/21/19.
//  Copyright © 2019 Snehal Garbhe. All rights reserved.
//
//

import Foundation
import BNRCoreDataStack

@objc(CityData)
class CityData: NSManagedObject, CoreDataModelable {
    static let entityName = "CityData"
}
