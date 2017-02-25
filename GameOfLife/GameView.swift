//
//  GameView.swift
//  GameOfLife
//
//  Created by Sebastian Osiński on 25/02/2017.
//  Copyright © 2017 Sebastian Osiński. All rights reserved.
//

import UIKit

protocol GameViewDelegate: class {
    func numberOfRows() -> Int
    func numberOfColumns() -> Int
    func colorForCell(row: Int, column: Int) -> UIColor?
}

class GameView: UIView {

    weak var delegate: GameViewDelegate?

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let delegate = delegate, let context = UIGraphicsGetCurrentContext() else {
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
                if let color = delegate.colorForCell(row: row, column: column)?.cgColor {
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
