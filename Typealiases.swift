//
//  Typealiases.swift
//  GameOfLife
//
//  Created by Sebastian Osiński on 25/02/2017.
//  Copyright © 2017 Sebastian Osiński. All rights reserved.
//

#if os(iOS)
    import UIKit

    typealias View = UIView
    typealias Color = UIColor
    typealias ViewController = UIViewController
#else
    import Cocoa

    typealias View = NSView
    typealias Color = NSColor
    typealias ViewController = NSViewController
#endif
