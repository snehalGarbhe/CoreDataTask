//
//  CityData+CoreDataProperties.swift
//  CoreDataTask
//
//  Created by Snehal Garbhe on 3/21/19.
//  Copyright © 2019 Snehal Garbhe. All rights reserved.
//
//

import Foundation
import CoreData


extension CityData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityData> {
        return NSFetchRequest<CityData>(entityName: "CityData")
    }

    @NSManaged  var name: String?
    @NSManaged  var temp: Int32
    @NSManaged  var minTemp: Int32
    @NSManaged  var maxTemp: Int32
    @NSManaged  var humidity: Int32
    @NSManaged  var pressure: Int32
    @NSManaged  var isUpdate: Bool


}
