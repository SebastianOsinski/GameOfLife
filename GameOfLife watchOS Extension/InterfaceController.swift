//
//  InterfaceController.swift
//  GameOfLife watchOS Extension
//
//  Created by Sebastian Osiński on 16.02.2018.
//  Copyright © 2018 Sebastian Osiński. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var image: WKInterfaceImage!

    private let game = Game(rows: 50, columns: 50)

    private lazy var renderer: GameRenderer = {
        let renderer = GameRenderer()
        renderer.delegate = self
        return renderer
    }()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setupAndStartGame()
        addMenuItem(with: .repeat, title: "Restart", action: #selector(setupAndStartGame))
    }

    @objc private func setupAndStartGame() {
        game.stop()
        game.onNextGeneration = { [weak self] in
            self?.createAndSetNewImage()
        }
        game.start()
    }

    private func createAndSetNewImage() {
        UIGraphicsBeginImageContextWithOptions(contentFrame.size, false, WKInterfaceDevice.current().screenScale)
        let context = UIGraphicsGetCurrentContext()!

       renderer.render(context: context, frame: contentFrame)

        let cgimage = context.makeImage()!
        let uiimage = UIImage(cgImage: cgimage)

        UIGraphicsEndImageContext()
        image.setImage(uiimage)
    }
}

extension InterfaceController: GameRendererDelegate {

    func numberOfRows() -> Int {
        return game.rows
    }

    func numberOfColumns() -> Int {
        return game.columns
    }

    func colorForCell(row: Int, column: Int) -> CGColor? {
        return game.isAlive(row: row, column: column) ? UIColor.white.cgColor : nil
    }
}
