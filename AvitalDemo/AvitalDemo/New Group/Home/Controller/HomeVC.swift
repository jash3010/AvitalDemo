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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mainView.setUpUI(vc: self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
