//
//  DateHelper.swift
//  Application
//
//  Created by Ada on 17.11.2023.
//

import Foundation

class DateHelper {
    
    
    func convertStringToDate(_ dateString: String) -> Date? {
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
          dateFormatter.locale = Locale(identifier: "tr")

          return dateFormatter.date(from: dateString)
      }



   func convertDateToString(_ date: Date) -> String {
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "dd MMMM yyyy"
          dateFormatter.locale = Locale(identifier: "tr")

          return dateFormatter.string(from: date)
      }

}
