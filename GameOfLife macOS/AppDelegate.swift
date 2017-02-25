//
//  AppDelegate.swift
//  GameOfLife macOS
//
//  Created by Sebastian Osiński on 25/02/2017.
//  Copyright © 2017 Sebastian Osiński. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let viewController = GameViewController(game: Game(rows: 100, columns: 100))!
        window.contentViewController = viewController
        window.setFrame(NSRect(x: 0, y: 0, width: 1000, height: 1000), display: true)
    }
}

