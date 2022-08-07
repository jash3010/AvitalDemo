//
//  HomeVCTableDelegate.swift
//  AvitalDemo
//
//  Created by MAC  on 07/08/22.
//

import Foundation
import UIKit

extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentTBLCell", for: indexPath) as! AppointmentTBLCell
        return cell
    }
}
