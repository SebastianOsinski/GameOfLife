//
//  GameRenderer.swift
//  GameOfLife iOS
//
//  Created by Sebastian Osiński on 16.02.2018.
//  Copyright © 2018 Sebastian Osiński. All rights reserved.
//

import CoreGraphics

protocol GameRendererDelegate: class {
    func numberOfRows() -> Int
    func numberOfColumns() -> Int
    func colorForCell(row: Int, column: Int) -> CGColor?
}

final class GameRenderer {

    weak var delegate: GameRendererDelegate?

    func render(context: CGContext, frame: CGRect) {
        guard let delegate = delegate else {
            return
        }

        let cellSize = CGSize(
            width: frame.width / CGFloat(delegate.numberOfColumns()),
            height: frame.height / CGFloat(delegate.numberOfRows())
        )

        var y: CGFloat = 0
        for row in 0..<delegate.numberOfRows() {
            var x: CGFloat = 0
            for column in 0..<delegate.numberOfColumns() {
                if let color = delegate.colorForCell(row: row, column: column) {
                    let rect = CGRect(origin: CGPoint(x: x, y: y), size: cellSize)

                    context.setFillColor(color)
                    context.fill(rect)
                }
                x += cellSize.width
            }
            y += cellSize.height
        }
    }
}
