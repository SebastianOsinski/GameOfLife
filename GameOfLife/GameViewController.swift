//
//  GameViewController.swift
//  GameOfLife
//
//  Created by Sebastian Osiński on 25/02/2017.
//  Copyright © 2017 Sebastian Osiński. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class GameViewController: UICollectionViewController {

    private let game: Game
    private let layout: UICollectionViewFlowLayout

    init(game: Game) {
        self.game = game
        self.layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)

        game.onNextGeneration = { [weak collectionView] in
            collectionView?.reloadData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView!.backgroundColor = .white
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        let cellSideLength = collectionView!.frame.width / CGFloat(game.columns)

        layout.itemSize = CGSize(width: cellSideLength, height: cellSideLength)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        game.start()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return game.rows
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return game.columns
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = game.isAlive(row: indexPath.section, column: indexPath.item) ? .random : .white
        return cell
    }
}

extension UIColor {

    static var random: UIColor {
        let generator = { CGFloat(arc4random_uniform(256)) / 256 }
        return UIColor(red: generator(), green: generator(), blue: generator(), alpha: 1.0)
    }
}
