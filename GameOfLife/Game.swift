//
//  Game.swift
//  GameOfLife
//
//  Created by Sebastian Osiński on 25/02/2017.
//  Copyright © 2017 Sebastian Osiński. All rights reserved.
//

import Foundation

class Game {

    let rows: Int
    let columns: Int

    var onNextGeneration: ((Void) -> Void)?

    private var cells = [[Bool]]()
    private var isRunning = false

    private let queue = DispatchQueue(label: "xyz.osinski.GameOfLife")
    private let mutexQueue = DispatchQueue(label: "xyz.osinski.CellsMutex")

    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns

        cells = [[Bool]](repeatElement([Bool](repeatElement(false, count: columns + 2)), count: rows + 2))
        resetCells()
    }

    func isAlive(row: Int, column: Int) -> Bool {
        return cells[row + 1][column + 1]
    }

    func start() {
        guard !isRunning else {
            return
        }

        isRunning = true

        queue.async {
            while self.isRunning {
                self.nextGeneration()
                DispatchQueue.main.sync {
                    self.onNextGeneration?()
                }

                usleep(1000)
            }
        }
    }

    func stop() {
        guard isRunning else {
            return
        }

        isRunning = false

        resetCells()
    }

    private func nextGeneration() {
        let cellsCopy = cells

        mutexQueue.sync {
            for row in 1...rows {
                for column in 1...columns {
                    let neighbours = neighboursOfCell(row: row, column: column, cells: cellsCopy)
                    let numberOfAliveNeighbours = neighbours.reduce(0) { acc, isAlive in acc + (isAlive ? 1 : 0) }

                    if cellsCopy[row][column] {
                        cells[row][column] = numberOfAliveNeighbours == 2 || numberOfAliveNeighbours == 3
                    } else {
                        cells[row][column] = numberOfAliveNeighbours == 3
                    }
                }
            }
        }
    }

    private func resetCells() {
        mutexQueue.sync {
            for row in 0...(rows + 1) {
                for column in 0...(columns + 1) {
                    if row == 0 || row == rows + 1 || column == 0 || column == columns + 1 {
                        cells[row][column] = true
                    } else {
                        cells[row][column] = arc4random_uniform(2) == 1
                    }
                }
            }
        }
    }

    private func neighboursOfCell(row: Int, column: Int, cells: [[Bool]]) -> [Bool] {
        return [
            cells[row - 1][column - 1],
            cells[row - 1][column],
            cells[row - 1][column + 1],
            cells[row][column + 1],
            cells[row + 1][column + 1],
            cells[row + 1][column],
            cells[row + 1][column - 1],
            cells[row][column - 1]
        ]
    }
}
