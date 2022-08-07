//
//  AppointmentModel.swift
//  AvitalDemo
//
//  Created by MAC  on 07/08/22.
//

import Foundation

// MARK: - AppointmentModel
struct AppointmentModel: Codable {
    let message: String?
    let data: [AppointmentList]?
    let success: Bool?
}

// MARK: - AppointmentList
struct AppointmentList: Codable {
    let id: String?
    let imageURL: String?
    let name, time: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case imageURL = "image_url"
        case name, time
    }
}
