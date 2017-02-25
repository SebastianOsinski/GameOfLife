//
//  GameViewController.swift
//  GameOfLife
//
//  Created by Sebastian Osiński on 25/02/2017.
//  Copyright © 2017 Sebastian Osiński. All rights reserved.
//

import Cocoa

class GameViewController: NSViewController, GameViewDelegate {

    private let game: Game

    private var gameView: GameView {
        return view as! GameView
    }

    init?(game: Game) {
        self.game = game
        super.init(nibName: nil, bundle: nil)

        game.onNextGeneration = { [weak gameView] in
            gameView?.needsDisplay = true
            gameView?.displayIfNeeded()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = GameView()
    //    view.frame = NSRect(x: 0, y: 0, width: 1000, height: 1000)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        gameView.delegate = self
        gameView.wantsLayer = true
        gameView.layer?.backgroundColor = NSColor.black.cgColor
        game.start()
    }

    func numberOfRows() -> Int {
        return game.rows
    }


    func numberOfColumns() -> Int {
        return game.columns
    }

    func colorForCell(row: Int, column: Int) -> NSColor? {
        return game.isAlive(row: row, column: column) ? .random : nil
    }
}

extension NSColor {

    static var random: NSColor {
        let generator = { CGFloat(arc4random_uniform(256)) / 256 }
        return NSColor(red: generator(), green: generator(), blue: generator(), alpha: 1.0)
    }
}
