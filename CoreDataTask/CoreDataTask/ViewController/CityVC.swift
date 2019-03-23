//
//  CityVC.swift
//  CoreDataTask
//
//  Created by Snehal Garbhe on 3/21/19.
//  Copyright © 2019 Snehal Garbhe. All rights reserved.
//

import Foundation
import UIKit
import CoreData

import BNRCoreDataStack

class CityVC: BaseVC {
    
    @IBOutlet var cityTblVw: UITableView!
    
    var cityArr : CityModelResponse?
    var mainModelResponse : CityMainModelResponse?

    private lazy var fetchedResultsController: FetchedResultsController<CityData> = {
        let fetchRequest = NSFetchRequest<CityData>()
        fetchRequest.predicate =  NSPredicate(format: " isUpdate == 0 ")
        fetchRequest.entity = CityData.entity()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let frc = FetchedResultsController<CityData>(fetchRequest: fetchRequest,
                                                 managedObjectContext: CoreDataManager.sharedInstance.mainContext,
                                                 sectionNameKeyPath: nil)
        frc.setDelegate(self.frcDelegate)
        return frc
    }()
    
    private lazy var frcDelegate: CityFetchResultController = {
        return CityFetchResultController(tableView: self.cityTblVw)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather Report"
        self.callCityAPI()
    }

    //MARK:- Call API in background
    @objc func callCityAPI() {
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        backgroundQueue.async(execute: {
            DispatchQueue.main.async(execute: { () -> Void in
                self.callSydneyCityAPI()
            })
        })
        
    }
    
    
    //MARK:- Call API
    
    private func callSydneyCityAPI() {
        self.showHud()
        let model = CityModel(cityName: City.sydney)
        print(model)
        RequestManager.sharedInstance.requestAPI(model) { [unowned self] (success, response) in
            if success {
                self.callMelbourneCityAPI()
            }else {
                self.callMelbourneCityAPI()
            }
        }
    }
    
    private func callMelbourneCityAPI() {
        let model = CityModel(cityName: City.melbourne)
        print(model)
        RequestManager.sharedInstance.requestAPI(model) { [weak self] (success, response) in
            if success {
                self?.callBrisbaneCityAPI()
            }else {
                self?.callBrisbaneCityAPI()
                
            }
        }
    }
    
    private func callBrisbaneCityAPI() {
        let model = CityModel(cityName: City.brisbane)
        print(model)
        RequestManager.sharedInstance.requestAPI(model) { [weak self] (success, response) in
            if success {

                DispatchQueue.main.async {
                  self?.setUpUI()
                }
                self?.hideHud()
                self?.appBackGroundAPICall()

            }else {
                self?.hideHud()
                DispatchQueue.main.async {
                    self?.setUpUI()
                }
                self?.appBackGroundAPICall()
            }
        }
    }
    
    //MARK : - Timer to call api after 5 min
    func appBackGroundAPICall() {
        Timer.scheduledTimer(timeInterval: 300.0, target: self, selector: #selector(CityVC.callCityAPI), userInfo: nil, repeats: false)
    }
    
    func setUpUI() {
        cityTblVw.delegate = self
        cityTblVw.dataSource = self
        do {
            try fetchedResultsController.performFetch()
            cityTblVw.reloadData()

        } catch {
            print("Failed to fetch objects: \(error)")
        }
    }
    
    private func callDetailUI(cityData: CityData) {
        let detailVC = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        detailVC.cityData = nil
        detailVC.cityData = cityData
        self.navigationController!.pushViewController(detailVC, animated: false)
    }
    
    func cityReportAtIndexPath(indexPath: IndexPath) -> CityData? {
        guard let sections = fetchedResultsController.sections else {
            return nil
        }
        
        let section = sections[indexPath.section]
        return section.objects[indexPath.row]
    }
    
}

extension CityVC : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].objects.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CityCell else {
            return UITableViewCell()
        }
        
     
        guard let cityData = self.cityReportAtIndexPath(indexPath: indexPath) else {
            return cell
        }
        if let cityName = cityData.name {
            cell.cityName.text = "City Name: \(cityName)"
        }
        if let temp = cityData.temp as? Int32 {
            cell.cityTemp.text = "Temprature: \(temp)"
        }
        return cell
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let cityData = self.cityReportAtIndexPath(indexPath: indexPath) else {
            return
        }
        self.callDetailUI(cityData: cityData)
        
    }
}
