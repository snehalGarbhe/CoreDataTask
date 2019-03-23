//
//  CoreDataManager.swift
//  CoreDataTask
//
//  Created by Snehal Garbhe on 3/21/19.
//  Copyright © 2019 Snehal Garbhe. All rights reserved.
//

import Foundation
import BNRCoreDataStack

private struct CoreDataConst {
    static let modelName = "CoreDataTask"
}

class CoreDataManager {
    static let sharedInstance = CoreDataManager()
    
    fileprivate var stack: CoreDataStack?
    
    var newChildContext: NSManagedObjectContext {
        return stack!.newChildContext()
    }
    
    var mainContext: NSManagedObjectContext {
        return stack!.mainQueueContext
    }

    func setupCoreDataStack(completion:  @escaping (_ success: Bool, AnyObject?) -> Void) {
        DispatchQueue.main.async {
            
            CoreDataStack.constructSQLiteStack(modelName: CoreDataConst.modelName) { (result) in
                switch result {
                case .success(let stack):
                    DispatchQueue.main.async {
                        self.stack = stack
                        print("Success")
                        completion(true,nil)
                    }
                case .failure(let error):
                    print("failed to setup coredata \(error)")
                    completion(false,nil)
                    
                }
            }
        }
       
    }
    
}
