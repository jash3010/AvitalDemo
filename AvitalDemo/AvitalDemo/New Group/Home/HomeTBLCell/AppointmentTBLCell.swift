//
//  AppointmentTBLCell.swift
//  AvitalDemo
//
//  Created by MAC  on 07/08/22.
//

import UIKit

class AppointmentTBLCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var timeLBL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpData(data: AppointmentData){
        self.nameLBL.text = data.name
        self.timeLBL.text = data.time
        self.imgView.imageFromServerURL(data.imageURL ?? "", placeHolder: UIImage(named: "placehoderIMG"))
    }
    
}
