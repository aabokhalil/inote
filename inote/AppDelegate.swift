
//
//  AppDelegate.swift
//  inote
//
//  Created by ahmed abokhalil on 7/27/1440 AH.
//  Copyright © 1440 AH ahmed abokhalil. All rights reserved.
//

import UIKit
import RealmSwift
@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String )
        
        print(Realm.Configuration.defaultConfiguration.fileURL as Any)
    

        do {
            _ = try Realm()
        } catch {
            print("error installing new realm \(error)")
        }
 
        return true
    }
    
    
}


