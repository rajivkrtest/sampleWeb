//
//  AppDelegate.swift
//  SamplePract1
//
//  Created by APPLE on 03/12/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("dbPath \(FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: .userDomainMask)) ")
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "SamplePract1")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func addRecordToEntity(entityName : String, employee : Employee) {
        let context = self.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        let arrayRecord = self.fetchRecordsFromEntity(entityName: entityName, filterKey: employee.id)
        if(arrayRecord.count == 0) {
            let newEmp = NSManagedObject(entity: entity!, insertInto: context)
            newEmp.setValue(employee.employee_name, forKey: "employee_name")
            newEmp.setValue(employee.employee_salary, forKey: "employee_salary")
            newEmp.setValue(employee.employee_age, forKey: "employee_age")
            newEmp.setValue(employee.profile_image, forKey: "profile_image")
            newEmp.setValue(employee.id, forKey: "id")
            do {
                try context.save()
            }
            catch {
                print("Saving failed")
            }
        }
        
        
    }
    func fetchRecordsFromEntity(entityName: String, filterKey: String? = nil)-> [Employee] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        var arrayRecords: [Employee] = []
        if let filterKey = filterKey {
             request.predicate = NSPredicate(format:"id = %@",filterKey)
        }
       
        request.returnsObjectsAsFaults = false
         let context = self.persistentContainer.viewContext
        do {
            let result = try context.fetch(request)
            for record in result as! [NSManagedObject] {
                arrayRecords.append(Employee.init(fromManagedObject: record))
            }
        }
        catch {
            
        }
        return arrayRecords
    }
}

