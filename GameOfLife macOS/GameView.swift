//
//  GameView.swift
//  GameOfLife
//
//  Created by Sebastian Osiński on 25/02/2017.
//  Copyright © 2017 Sebastian Osiński. All rights reserved.
//
#if os(iOS) || os(tvOS)
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

    private lazy var renderer: GameRenderer = {
        let renderer = GameRenderer()
        renderer.delegate = self
        return renderer
    }()

    #if os(iOS) || os(tvOS)
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
        guard let context = context else {
            return
        }

        renderer.render(context: context, frame: frame)
    }
}

extension GameView: GameRendererDelegate {

    func numberOfRows() -> Int {
        return delegate?.numberOfRows() ?? 0
    }

    func numberOfColumns() -> Int {
        return delegate?.numberOfColumns() ?? 0
    }

    func colorForCell(row: Int, column: Int) -> CGColor? {
        return delegate?.colorForCell(row: row, column: column)?.cgColor
    }
}
