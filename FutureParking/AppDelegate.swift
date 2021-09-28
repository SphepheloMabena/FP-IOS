//
//  AppDelegate.swift
//  FuturePark
//
//  Created by Sphephelo Mabena on 2020/10/08.
//  Copyright © 2020 Sphephelo Mabena. All rights reserved.
//

import UIKit
import Firebase
//developed by Sphephelo Mabena

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?;
  
    func application(_ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      FirebaseApp.configure()
        //let db = Firestore.firestore()
      return true
    }
    


}
//developed by Sphephelo Mabena
