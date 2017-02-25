//
//  AppDelegate.swift
//  GameOfLife
//
//  Created by Sebastian Osiński on 25/02/2017.
//  Copyright © 2017 Sebastian Osiński. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = GameViewController(game: Game(rows: 200, columns: 80))
        window?.makeKeyAndVisible()
        return true
    }
}

