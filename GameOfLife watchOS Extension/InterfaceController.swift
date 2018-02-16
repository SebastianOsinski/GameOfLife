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

    private var numberOfRows: Int {
        return game.rows
    }
    private var numberOfColumns: Int {
        return game.columns
    }

    private var game: Game!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        game = Game(rows: 50, columns: 50)

        game.onNextGeneration = { [weak self] in
            self?.createAndSetNewImage()
        }

        game.start()
    }

    private func createAndSetNewImage() {
        UIGraphicsBeginImageContextWithOptions(contentFrame.size, false, WKInterfaceDevice.current().screenScale)
        let context = UIGraphicsGetCurrentContext()!

        drawCells(context: context)

        let cgimage = context.makeImage()!
        let uiimage = UIImage(cgImage: cgimage)

        UIGraphicsEndImageContext()
        image.setImage(uiimage)
    }

    private func drawCells(context: CGContext?) {
        guard let context = context else {
            return
        }

        let frame = contentFrame

        let cellSize = CGSize(
            width: frame.width / CGFloat(numberOfColumns),
            height: frame.height / CGFloat(numberOfRows)
        )

        var y: CGFloat = 0
        for row in 0..<numberOfRows {
            var x: CGFloat = 0
            for column in 0..<numberOfColumns {
                if let color = colorForCell(row: row, column: column)?.cgColor {
                    let rect = CGRect(origin: CGPoint(x: x, y: y), size: cellSize)

                    context.setFillColor(color)
                    context.fill(rect)
                }
                x += cellSize.width
            }
            y += cellSize.height
        }
    }

    func colorForCell(row: Int, column: Int) -> UIColor? {
        return game.isAlive(row: row, column: column) ? .white : nil
    }
}
