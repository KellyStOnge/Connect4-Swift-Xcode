//
//  ViewController.swift
//  Connect4
//
//  Created by Kelly St.Onge on 3/28/22.

//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var redScore = 0
    var yellowScore = 0
    
    func collectionView(_ cv: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return board[section].count
    }
    
    func collectionView(_ cv: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cv.dequeueReusableCell(withReuseIdentifier: "idCell", for: indexPath) as! boardCell
        
        
        let boardItem =  getBoardItem(indexPath)
        
        cell.image.tintColor = boardItem.tileColor()
         
        return cell
    }
    
    func numberOfSections(in cv: UICollectionView) -> Int {
        return board.count
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetBoard()
        setCellWidthHeight()
        // Do any additional setup after loading the view.
    }
    
    func setCellWidthHeight(){
        
        let width = collectionView.frame.size.width/9
        let height = collectionView.frame.size.height/6
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
        
    }

    
    @IBAction func resetbutton(_ sender: Any) {
        
        resetBoard()
        resetCells()
        
    }
    
    @IBOutlet weak var turnImage: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    func collectionView(_ cv: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let column = indexPath.item
        if var boardItem = getLowestEmptyBoardItem(column){
            
            if let cell = collectionView.cellForItem(at: boardItem.indexPath) as? boardCell{
                
                cell.image.tintColor = currentTurnColor()
                
                boardItem.tile = currentTurnTile()
                updateBoard(boardItem)
                
                if victoryAchieved(){
                    
                    if yellowTurn(){
                        
                        yellowScore += 1
                        
                    }
                    
                    if redTurn(){
                        
                        redScore += 1
                
                        
                        
                    }
                    
                    resultALert(currentTurnVictoryMessage())
                    
                    
                }
                
                
                if boardIsFull(){
                    
                    resultALert("Draw")
                    
                    
                }
                
                toggleTurn(turnImage)
                
            }
            
        }
    }
    
    
    func resultALert(_ title : String ){
        
        
        let message = "\nRed " + String(redScore) + "\n\nYellow " + String(yellowScore)
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: {[self](_) in
            resetBoard()
            resetCells()
        }))
        
        self.present(ac, animated: true)
    }
    
    func resetCells(){
        
        for cell in collectionView.visibleCells as! [boardCell]{
            
            cell.image.tintColor = .white
            
        }
        
    }
}

