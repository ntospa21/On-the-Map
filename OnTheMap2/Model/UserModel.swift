//
//  UserModel.swift
//  OnTheMap
//
//  Created by Pantos, Thomas on 11/3/23.
//

import Foundation


//MARK: User Info
struct UserSession {
    static var userId: String = ""
    static var firstName: String = ""
    static var lastName: String = ""
    static var nickname: String = ""
}

//MARK: Map Locations
struct MapPins {
    static var mapPins = [LocationResults]()
}
