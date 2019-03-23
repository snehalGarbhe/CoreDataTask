//
//  CityFetchResultController.swift
//  CoreDataTask
//
//  Created by Snehal Garbhe on 3/21/19.
//  Copyright © 2019 Snehal Garbhe. All rights reserved.
//

import Foundation
import UIKit
import BNRCoreDataStack

class CityFetchResultController: NSObject, FetchedResultsControllerDelegate {
    
    private weak var tableView: UITableView?
    
    // MARK: - Lifecycle
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    func fetchedResultsControllerDidPerformFetch(_ controller: FetchedResultsController<CityData>) {
        tableView?.reloadData()
    }
    
    func fetchedResultsControllerWillChangeContent(_ controller: FetchedResultsController<CityData>) {
        tableView?.beginUpdates()
    }
    
    func fetchedResultsControllerDidChangeContent(_ controller: FetchedResultsController<CityData>) {
        tableView?.endUpdates()
    }
    
    func fetchedResultsController(_ controller: FetchedResultsController<CityData>, didChangeObject change: FetchedResultsObjectChange<CityData>) {
        guard let tableView = tableView else { return }
        switch change {
        case let .insert(_, indexPath):
            tableView.insertRows(at: [indexPath], with: .automatic)
            
        case let .delete(_, indexPath):
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        case let .move(_, fromIndexPath, toIndexPath):
            tableView.moveRow(at: fromIndexPath, to: toIndexPath)
            
        case let .update(_, indexPath):
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func fetchedResultsController(_ controller: FetchedResultsController<CityData>, didChangeSection change: FetchedResultsSectionChange<CityData>) {
        guard let tableView = tableView else { return }
        switch change {
        case let .insert(_, index):
            tableView.insertSections(IndexSet(integer: index), with: .automatic)
            
        case let .delete(_, index):
            tableView.deleteSections(IndexSet(integer: index), with: .automatic)
        }
    }
}
