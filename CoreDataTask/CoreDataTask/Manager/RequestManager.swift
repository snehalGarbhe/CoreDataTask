//
//  RequestManager.swift
//  CoreDataTask
//
//  Created by Snehal Garbhe on 3/21/19.
//  Copyright © 2019 Snehal Garbhe. All rights reserved.
//

import Foundation
import BNRCoreDataStack

class RequestManager: NSObject {
    static let sharedInstance = RequestManager()
    private override init() {}
    
    func requestAPI(_ model : CityModel, completionHandler: @escaping CompletionHandler) {
        let queryCharSet = NSCharacterSet.urlQueryAllowed
        let urlStr = (APIConst.baseURL+model.urn).addingPercentEncoding(withAllowedCharacters: queryCharSet)

        let url = URL.init(string: urlStr!)
        print(url!)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let request = URLRequest(url: url!)
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                print(error!)
                completionHandler(false,nil)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data")
                completionHandler(false,nil)
                return
            }
            do {
                guard let jsonResonse = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? [String: Any] else {
                        print("error trying to convert data to JSON")
                        completionHandler(false,nil)
                        return
                }
                print(jsonResonse)
                let cityRes = Mapper<CityModelResponse>().map(JSON: jsonResonse)
                
                if cityRes != nil {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                        let moc = CoreDataManager.sharedInstance.newChildContext
                        self.addOrUpdateWeather(responseModel: cityRes!, moc: moc)
                        completionHandler(true,jsonResonse as AnyObject)
                        return
                    })
                }else {
                    completionHandler(false,nil)
                    return
                }
              
            } catch  {
                print("error trying to convert data to JSON")
                completionHandler(false,nil)
                return
            }
        }
        task.resume()
        
    }
    
    
    func addOrUpdateWeather( responseModel: CityModelResponse,moc : NSManagedObjectContext) {
        
            do {
                
                let pred = NSPredicate(format: "name  = \"\((responseModel.name)!)\" AND  isUpdate == 0 ")
                var cityData = try! CityData.findFirstInContext(moc, predicate: pred)
                if cityData == nil {
                    cityData = CityData(managedObjectContext: moc)
                    cityData?.name = responseModel.name!
                    cityData?.minTemp = (responseModel.main?.temp_min)!
                    cityData?.maxTemp = (responseModel.main?.temp_max)!
                    cityData?.temp = (responseModel.main?.temp)!
                    cityData?.humidity = (responseModel.main?.humidity)!
                    cityData?.pressure = (responseModel.main?.pressure)!
                    cityData?.isUpdate = false

                }
                moc.saveContext()
            }catch {
                print(error)
            }
        
        
    }
    
}
