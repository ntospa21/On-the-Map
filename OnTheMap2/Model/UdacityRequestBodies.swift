//
//  UdacityRequestBodies.swift
//  OnTheMap
//
//  Created by Pantos, Thomas on 11/3/23.
//

import Foundation


// MARK: Outgoing Body Items
//For Log-in
struct LogInStruct: Codable{
    var udacity: Udacity
}
struct Udacity: Codable {
    var username: String
    var password: String
}

//For Posting New Location
struct StudentLocation: Codable {
    var uniqueKey: String
    var firstName: String
    var lastName: String
    var mapString: String
    var mediaURL: String
    var latitude: Double // -90 to 90
    var longitude: Double //-180 to 180
}
