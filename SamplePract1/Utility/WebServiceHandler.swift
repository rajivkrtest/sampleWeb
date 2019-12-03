//
//  WebServiceHandler.swift
//  SamplePract1
//
//  Created by APPLE on 03/12/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
//http://dummy.restapiexample.com/api/v1/update/21
class WebServiceHandler: NSObject {
    internal typealias failure = (_ error : Error?) -> Void
    static let shared: WebServiceHandler = {
        let instance = WebServiceHandler()
        return instance
    }()
    
    func callRequest(source: String, completion: @escaping (_ results: [[String: String]]?)-> Void, failure: @escaping failure) {
        
        let url = URL(string: source.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    failure(error!)
                }
                return
            }
            guard let jsonObject =  try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) else {
                DispatchQueue.main.async {
                    failure(error)
                }
                return
            }
            let arrayResults = jsonObject as! [[String:String]]
            DispatchQueue.main.async {
                completion(arrayResults)
            }
            
            
        }.resume()
    }
    
    func callRequestModel(source: String, completion: @escaping (_ results: [Employee]?)-> Void, failure: @escaping failure) {
        
        let url = URL(string: source.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    failure(error!)
                }
                return
            }
            guard let arrayObject: [[String: String]] =  try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [[String : String]] else {
                DispatchQueue.main.async {
                    failure(error)
                }
                return
            }
            var arrayResults: [Employee] = []
            for obj in arrayObject {
                let emp = Employee.init(fromDictionary: obj)
//                arrayResults.append(emp)
                DispatchQueue.main.async {
                    let delegate = UIApplication.shared.delegate as! AppDelegate
                    delegate.addRecordToEntity(entityName: "EmployeeEntity", employee: emp)
                }
               
            }
            
            DispatchQueue.main.async {
               
                completion(arrayResults)
            }
            
            
            }.resume()
    }
    
    
//    http://dummy.restapiexample.com/api/v1/employees?name=geetha&sal
    
    
    
    func callPostRequest(source: String,dic:[String:String], completion: @escaping (_ results: [String: String]?)-> Void, failure: @escaping failure) {
        //"name":"test","salary":"123","age":"23"
        
        
//        let json = ["name":"geethaTest4","salary":"123","age":"234"]
let json = dic
       let jsonData = try? JSONSerialization.data(withJSONObject: json, options: [])
//        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        let url = URL(string: source.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        var request = URLRequest(url: url!)
       
//        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("fghfhf", forHTTPHeaderField: "BearerToken")
        
        request.httpBody = jsonData
        request.httpMethod = "POST"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    failure(error!)
                }
                return
            }
            print("datadet \(String(describing: String(data: data, encoding: String.Encoding.utf8)))")
//            [self .callRequest(source: "http://dummy.restapiexample.com/api/v1/employees", completion: { (results) in
//                print("results \(results)")
//            }, failure: { (error) in
//                print(error?.localizedDescription)
//            })]
            guard let jsonObject =  try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves) else {
                DispatchQueue.main.async {
                    failure(error)
                    print("error\(String(describing: error?.localizedDescription))")
                }
                return
            }
            let dicResults = jsonObject as! [String:String]
            DispatchQueue.main.async {
                print("dicresults \(dicResults)")
                completion(dicResults)
            }


            }.resume()
    }
    
//    func callPostRequest(source: String, completion: @escaping (_ results: [[String: String]]?)-> Void, failure: @escaping failure) {
//   let url = URL(string: source.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
////        var request = URLRequest(url: url!)
////    request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
////    request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")        // the expected response is also JSON
//        var request = URLRequest(url: url!)
//    request.httpMethod = "POST"
//
//      let json = ["name":"geethaTest1","salary":"123","age":"234"]
////    request.httpBody = try! JSONEncoder().encode(dictionary)
//        let jsonDat = try? JSONSerialization.data(withJSONObject: json, options: [])
//     request.httpBody = jsonDat
//
//        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
//    URLSession.shared.dataTask(with: request) { data, response, error in
//        guard let data = data, error == nil else {
//            print(error ?? "Unknown error")                                 // handle network error
//            return
//        }
//         print("datadet \(String(describing: String(data: data, encoding: String.Encoding.utf8)))")
//        // parse response; for example, if JSON, define `Decodable` struct `ResponseObject` and then do:
//        //
//        // do {
//        //     let responseObject = try JSONDecoder().decode(ResponseObject.self, from: data)
//        //     print(responseObject)
//        // } catch let parseError {
//        //     print(parseError)
//        //     print(String(data: data, encoding: .utf8))   // often the `data` contains informative description of the nature of the error, so let's look at that, too
//        // }
//    }.resume()
//    }
}
