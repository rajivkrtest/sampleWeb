//
//  EmployeeModel.swift
//  SamplePract1
//
//  Created by APPLE on 03/12/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import CoreData
struct Employee {
    var employee_name: String?
    var employee_salary: String?
    var employee_age: String?
    var profile_image: String?
    var id: String?
    
    init(fromDictionary dic: [String: String]) {
        employee_name = dic["employee_name"]
        employee_salary = dic["employee_salary"]
        employee_age = dic["employee_age"]
//        profile_image = dic["profile_image"]
        profile_image = "https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
        id = dic["id"]
    }
    
    init(fromManagedObject obj : NSManagedObject) {
        employee_name = obj.value(forKey: "employee_name") as? String
        employee_salary = obj.value(forKey: "employee_salary") as? String
        employee_age = obj.value(forKey: "employee_age") as? String
        profile_image = obj.value(forKey: "profile_image") as? String
        id = obj.value(forKey: "id") as? String
    }
}
