//
//  GameViewController.swift
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

class GameViewController: ViewController, GameViewDelegate {

    private let game: Game

    private var gameView: GameView {
        return view as! GameView
    }

    init?(game: Game) {
        self.game = game
        super.init(nibName: nil, bundle: nil)

        game.onNextGeneration = { [weak gameView] in
            #if os(iOS)
                gameView?.setNeedsDisplay()
            #else
                gameView?.needsDisplay = true
            #endif
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = GameView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        gameView.delegate = self

        #if os(iOS)
            gameView.backgroundColor = .black
        #else
            gameView.wantsLayer = true
            gameView.layer?.backgroundColor = NSColor.black.cgColor
        #endif
        game.start()
    }

    func numberOfRows() -> Int {
        return game.rows
    }

    func numberOfColumns() -> Int {
        return game.columns
    }

    func colorForCell(row: Int, column: Int) -> Color? {
        return game.isAlive(row: row, column: column) ? .random : nil
    }

    #if os(iOS)
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            game.stop()
            game.start()
        }
    }
    #endif
}
