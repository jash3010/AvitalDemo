//
//  HomeView.swift
//  AvitalDemo
//
//  Created by MAC  on 07/08/22.
//

import UIKit

class HomeView: UIView {

    @IBOutlet weak var appointmentTBL: UITableView!
    
    func setUpUI(vc: HomeVC){
        vc.navigationItem.title = "Appointments"
        self.appointmentTBL.register(UINib(nibName: "AppointmentTBLCell", bundle: nil), forCellReuseIdentifier: "AppointmentTBLCell")
    }
}
