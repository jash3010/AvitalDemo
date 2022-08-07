//
//  HomeVM.swift
//  AvitalDemo
//
//  Created by MAC  on 07/08/22.
//

import Foundation

class HomeVM{
    
    fileprivate var viewController: HomeVC!
    
    init(_ vc: HomeVC){
        self.viewController = vc
    }
    
    var appointmentData = [AppointmentData]()
    
    func getAppointmentData() async {
        appointmentData = await makeRequest()
    }
    
    func makeRequest() async -> [AppointmentData]{
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
            return modelData.data ?? []
        }catch{
            await self.viewController.hideLoader()
            return []
        }
    }
}
