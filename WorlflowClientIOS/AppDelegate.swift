//
//  AppDelegate.swift
//  WorlflowClientIOS
//
//  Created by Daz on 12/9/15.
//  Copyright © 2015 Daz. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        registerNotificaitons()
        initializeActions()
        return true
    }
    
    func initializeActions () {
        WorkingDataStore.sharedInstance().syncSelf()
    }
    
    func registerNotificaitons () {
        // register loading self events
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onDidLoadEmployee", name: WorkingDataStore.ACTION_LOAD_EMPLOYEE_COMPLETE, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onFailLoadingEmployee", name: WorkingDataStore.ACTION_LOAD_EMPLOYEE_FAIL, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onDidLoadEmployeeIcon", name: WorkingDataStore.ACTION_LOAD_EMPLOYEE_ICON_COMPLETE, object: nil)

        // register task action events
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onDidShiftTask", name: WorkingDataStore.ACTION_SHIFTED_TASK, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onDidSuspendTask", name: WorkingDataStore.ACTION_SUSPENDED_TASK, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onDidCompleteTask", name: WorkingDataStore.ACTION_COMPLETED_TASK, object: nil)

        // register check in/out events
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onDidEmployeeCheckInOut", name: WorkingDataStore.ACTION_EMPLOYEE_CHECK_IN_OUT, object: nil)
        
        // register loading task events
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onDidLoadEmployeeTasks", name: WorkingDataStore.ACTION_LOAD_EMPLOYEE_TASKS_COMPLETE, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onFailLoadingEmployeeTasks", name: WorkingDataStore.ACTION_LOAD_EMPLOYEE_TASKS_FAIL, object: nil)

        // register loading task activity events
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onDidLoadTaskActivities", name: TaskActivityDataStore.ACTION_LOAD_TASK_ACTIVITIES_COMPLETE, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onDidSendMessageToTask", name: TaskActivityDataStore.ACTION_SENT_MESSAGE_TO_TASK, object: nil)
    }

    // delegates of loading employee
    func onDidLoadEmployee () {
        NSNotificationCenter.defaultCenter().postNotificationName(WorkingDataStore.ACTION_SHOULD_RELOAD_EMPLOYEE, object: nil)
    }
    func onFailLoadingEmployee () {
    }
    func onDidLoadEmployeeIcon () {
        NSNotificationCenter.defaultCenter().postNotificationName(WorkingDataStore.ACTION_SHOULD_RELOAD_EMPLOYEE_ICON, object: nil)
    }
    func onDidEmployeeCheckInOut () {
        WorkingDataStore.sharedInstance().syncSelf()
    }

    // delegates of task actions
    func onDidShiftTask () {
        NSNotificationCenter.defaultCenter().postNotificationName(WorkingDataStore.ACTION_SHOULD_RELOAD_EMPLOYEE, object: nil)
    }
    func onDidSuspendTask () {
        NSNotificationCenter.defaultCenter().postNotificationName(WorkingDataStore.ACTION_SHOULD_RELOAD_EMPLOYEE, object: nil)
    }
    func onDidCompleteTask () {
        NSNotificationCenter.defaultCenter().postNotificationName(WorkingDataStore.ACTION_SHOULD_RELOAD_EMPLOYEE, object: nil)
    }
    
    // delegates of loading tasks
    func onDidLoadEmployeeTasks () {
        NSNotificationCenter.defaultCenter().postNotificationName(WorkingDataStore.ACTION_SHOULD_RELOAD_EMPLOYEE_TASKS, object: nil)
    }
    func onFailLoadingEmployeeTasks () {
        NSNotificationCenter.defaultCenter().postNotificationName(WorkingDataStore.ACTION_CANCEL_RELOAD_EMPLOYEE_TASKS, object: nil)
    }

    // delegates of loading task activities
    func onDidLoadTaskActivities () {
        NSNotificationCenter.defaultCenter().postNotificationName(TaskActivityDataStore.ACTION_SHOULD_RELOAD_TASK_ACTIVITIES, object: nil)
    }
    func onDidSendMessageToTask () {
        NSNotificationCenter.defaultCenter().postNotificationName(TaskActivityDataStore.ACTION_SHOULD_RELOAD_TASK_ACTIVITIES, object: nil)
    }


    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        NSNotificationCenter.defaultCenter().postNotificationName(WorkingDataStore.ACTION_LOAD_EMPLOYEE_TASKS_COMPLETE, object: nil)
        // [TODO] should inform all
        WorkingDataStore.sharedInstance().syncTasks()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "Bananaplan.WorlflowClientIOS" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("WorlflowClientIOS", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

}

