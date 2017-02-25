//
//  GameViewController.swift
//  GameOfLife
//
//  Created by Sebastian Osiński on 25/02/2017.
//  Copyright © 2017 Sebastian Osiński. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class GameViewController: UIViewController, GameViewDelegate {

    private let game: Game

    override var canBecomeFirstResponder: Bool {
        return true
    }

    private var gameView: GameView {
        return view as! GameView
    }

    init(game: Game) {
        self.game = game
        super.init(nibName: nil, bundle: nil)

        game.onNextGeneration = { [weak gameView] in
            gameView?.setNeedsDisplay()
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
        gameView.backgroundColor = .black
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        game.start()
    }


    func numberOfRows() -> Int {
        return game.rows
    }


    func numberOfColumns() -> Int {
        return game.columns
    }

    func colorForCell(row: Int, column: Int) -> UIColor? {
        return game.isAlive(row: row, column: column) ? UIColor(red: 30 / 256, green: 197 / 256, blue: 3 / 256, alpha: 1) : nil
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            game.stop()
            game.start()
        }
    }
}

extension UIColor {

    static var random: UIColor {
        let generator = { CGFloat(arc4random_uniform(256)) / 256 }
        return UIColor(red: generator(), green: generator(), blue: generator(), alpha: 1.0)
    }
}
