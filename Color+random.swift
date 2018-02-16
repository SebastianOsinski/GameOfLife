//
//  Color+random.swift
//  GameOfLife
//
//  Created by Sebastian Osiński on 25/02/2017.
//  Copyright © 2017 Sebastian Osiński. All rights reserved.
//
#if os(iOS) || os(tvOS)
    import UIKit
#else
    import Foundation
#endif

extension Color {

    static var random: Color {
        let generator = { CGFloat(arc4random_uniform(256)) / 256 }
        return Color(red: generator(), green: generator(), blue: generator(), alpha: 1.0)
    }
}
