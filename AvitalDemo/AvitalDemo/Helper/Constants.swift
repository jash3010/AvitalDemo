//
//  Constants.swift
//  AvitalDemo
//
//  Created by MAC  on 07/08/22.
//

import Foundation
import UIKit
import EventKit

func serverToLocal(date:String) -> (String, Date, Date) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    guard let dateUTC = dateFormatter.date(from: date) else { return ("", Date(), Date()) }
    dateFormatter.timeZone = TimeZone.current
    
    
//    func dateForEvents(date: String) -> (Date, Date) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//        guard let dateUTC = dateFormatter.date(from: date) else { return (Date(), Date()) }
//        dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
            let currentDateForEvent = dateFormatter.date(from: "\(dateUTC)")
            let endDateForEvent = Calendar.current.date(byAdding: .minute, value: 15, to: currentDateForEvent!)
        
//    }
    
    
    dateFormatter.dateFormat = "dd MMM"
    let dayMonthStr = dateFormatter.string(from: currentDateForEvent!)
    dateFormatter.dateFormat = "hh:mm a"
    let startTime = dateFormatter.string(from: currentDateForEvent!)
    let endTime = dateFormatter.string(from: endDateForEvent!)
    
    return ("\(dayMonthStr), \(startTime) - \(endTime)", currentDateForEvent!, endDateForEvent!)
}

//func getEndTime(date: Date) -> Date{
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
//    dateFormatter.timeZone = TimeZone.current
//    let currentDate = dateFormatter.date(from: "\(date)")
//    let date = Calendar.current.date(byAdding: .minute, value: 15, to: currentDate!)
//    return date!
//}

func addEventToCalendar(title: String, description: String?, startDate: Date, endDate: Date) {
    let eventStore = EKEventStore()

    eventStore.requestAccess(to: .event, completion: { (granted, error) in
        if (granted) && (error == nil) {
            let event = EKEvent(eventStore: eventStore)
            event.title = title
            event.startDate = startDate
            event.endDate = endDate
            event.notes = description
            event.calendar = eventStore.defaultCalendarForNewEvents
            do {
                try eventStore.save(event, span: .thisEvent)
            } catch {
                return
            }
        } else {
        }
    })
}

extension UIViewController{
    func showLoader(){
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating()
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func hideLoader(){
        dismiss(animated: false, completion: nil)
    }
}

extension UIImageView {
    
    func imageFromServerURL(_ URLString: String, placeHolder: UIImage?) {
        
        self.image = nil
        DispatchQueue.main.async {
            self.image = placeHolder
        }
        let imageServerUrl = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let url = URL(string: imageServerUrl) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}

extension UIViewController {

func showToast(message : String, font: UIFont) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 200, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 3.0, delay: 1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }
