//
//  ViewController.swift
//  SamplePract1
//
//  Created by APPLE on 03/12/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet weak var tableView: UITableView!
    var arrayResults : [Employee] = []
    override func viewDidLoad() {
        super.viewDidLoad()
                let json = ["name":"geethaTest5","salary":"123","age":"234"]
//        WebServiceHandler.shared.callPostRequest(source: "http://dummy.restapiexample.com/api/v1/create",dic:json,  completion: { (results) in
//            print("Done")
//
//            let json = ["name":"geethaTest6","salary":"123","age":"234"]
//            WebServiceHandler.shared.callPostRequest(source: "http://dummy.restapiexample.com/api/v1/create",dic:json,  completion: { (results) in
//                print("Done")
//            }) { (error) in
//                //Place alertview
//            }
//
//
//        }) { (error) in
//            //Place alertview
//        }
        WebServiceHandler.shared.callRequestModel(source: "http://dummy.restapiexample.com/api/v1/employees", completion: { (results) in
//            if let result = results {
            let delegate = UIApplication.shared.delegate as! AppDelegate
           self.arrayResults = delegate.fetchRecordsFromEntity(entityName: "EmployeeEntity")
            
                self.tableView.reloadData()
                print("result \(self.arrayResults.count)")
//            }
//            else {
//                print("im inside error")
//            }
        }) { (error) in
            print("issue")
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayResults.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CellIdentifier"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! CustomTableViewCell
        let res = self.arrayResults[indexPath.row]
        cell.setupData(data: res)
        
//        cell?.textLabel?.text = res["employee_name"]
        print("resemployee_name \(res)")
        return cell
    }
    

}

