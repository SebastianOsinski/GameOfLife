//
//  GameView.swift
//  GameOfLife
//
//  Created by Sebastian Osiński on 25/02/2017.
//  Copyright © 2017 Sebastian Osiński. All rights reserved.
//
#if os(iOS)
    import UIKit
#else
    import Cocoa
#endif

protocol GameViewDelegate: class {
    func numberOfRows() -> Int
    func numberOfColumns() -> Int
    func colorForCell(row: Int, column: Int) -> Color?
}

class GameView: View {

    weak var delegate: GameViewDelegate?

    #if os(iOS)
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawCells(context: UIGraphicsGetCurrentContext())
    }
    #else
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        drawCells(context: NSGraphicsContext.current()?.cgContext)
    }
    #endif

    private func drawCells(context: CGContext?) {
        guard let delegate = delegate, let context = context else {
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
