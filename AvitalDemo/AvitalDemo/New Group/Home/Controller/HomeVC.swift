//
//  HomeVC.swift
//  AvitalDemo
//
//  Created by MAC  on 07/08/22.
//

import UIKit

class HomeVC: UIViewController {
    
    static func storyboardInstance() -> UINavigationController{
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeNavigation") as! UINavigationController
    }

    lazy var mainView: HomeView = {
        return self.view as! HomeView
    }()
    
    lazy var mainViewModel: HomeVM = {
        return HomeVM(self, UIApplication.shared.delegate as! AppDelegate)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mainView.setUpUI(vc: self)
        Task{
            await self.mainViewModel.getAppointmentData()
            self.mainView.appointmentTBL.reloadData()
        }
    }

}
