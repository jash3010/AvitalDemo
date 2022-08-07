//
//  HomeVM.swift
//  AvitalDemo
//
//  Created by MAC  on 07/08/22.
//

import Foundation
import CoreData

class HomeVM{
    
    fileprivate var viewController: HomeVC!
    fileprivate var appdelegateInstance: AppDelegate!
    
    init(_ vc: HomeVC, _ appDelegate: AppDelegate){
        self.viewController = vc
        self.appdelegateInstance = appDelegate
    }
    
    var appointmentData = [AppointmentList]()
    
    func getAppointmentData() async {
        appointmentData = await makeRequest()
    }
    
    func makeRequest() async -> [AppointmentList]{
        guard let url = URL(string: "https://interview.avital.in/ios_interview.json") else { return [] }
        await self.viewController.showLoader()
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            let modelData = try JSONDecoder().decode(AppointmentModel.self, from: data)
            await self.viewController.hideLoader()
            if !(modelData.success ?? false){
                await self.viewController.showToast(message: "Data not found", font: .systemFont(ofSize: 15))
                return []
            }
            saveToLocal()
            return modelData.data ?? []
        }catch{
            await self.viewController.hideLoader()
            await self.viewController.showToast(message: "Please check Internet", font: .systemFont(ofSize: 15))
            do{
                let aray = fetchDataFromLocal()
                guard let managedObjs = aray.first?.value(forKey: "data") as? String else { return [] }
                let data = Data(managedObjs.utf8)
                let modelData = try JSONDecoder().decode([AppointmentList].self, from: data)
                return modelData
            }catch{
                await self.viewController.showToast(message: "Data not found", font: .systemFont(ofSize: 15))
                return []
            }
            
        }
    }
    
    func saveToLocal() {
        
        deleteAllData("AppointmentData")
        guard let data = try? JSONEncoder().encode(self.appointmentData),
              let dncodedString = String(data: data, encoding: .utf8) else { return }
        
        // 1
        let managedContext =
        appdelegateInstance.persistentContainer.viewContext
        
        // 2
        let entity =
        NSEntityDescription.entity(forEntityName: "AppointmentData",
                                   in: managedContext)!
        
        let appointment = NSManagedObject(entity: entity,
                                          insertInto: managedContext)
        // 3
        appointment.setValue(dncodedString, forKeyPath: "data")
        
        // 4
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchDataFromLocal() -> [NSManagedObject]{
        //1
        let managedContext = appdelegateInstance.persistentContainer.viewContext
        
        //2
        let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: "AppointmentData")
        
        //3
        do {
            let managedObjs = try managedContext.fetch(fetchRequest)
            return managedObjs
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    func deleteAllData(_ entity:String) {
        let managedContext =
        appdelegateInstance.persistentContainer.viewContext
        
        let results = fetchDataFromLocal()
        for object in results {
            
            managedContext.delete(object)
        }
        
    }
}
