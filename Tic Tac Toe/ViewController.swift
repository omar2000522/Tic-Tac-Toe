//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Omar on 21/10/1439 AH.
//  Copyright © 1439 Omar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //-----------Outlets--------------
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var gridLabel0: GridLabel!
    @IBOutlet weak var gridLabel1: GridLabel!
    @IBOutlet weak var gridLabel2: GridLabel!
    @IBOutlet weak var gridLabel3: GridLabel!
    @IBOutlet weak var gridLabel4: GridLabel!
    @IBOutlet weak var gridLabel5: GridLabel!
    @IBOutlet weak var gridLabel6: GridLabel!
    @IBOutlet weak var gridLabel7: GridLabel!
    @IBOutlet weak var gridLabel8: GridLabel!
    
    
    //-----------Variables------------
    var gridArray = [GridLabel]()
    var tapArray = [GridLabel]()
    var grid = [[GridLabel]()]
    var scoreX = 0
    var scoreO = 0
    //-----------Funcs----------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //filling gridArray
        gridArray.append(gridLabel0)
        gridArray.append(gridLabel1)
        gridArray.append(gridLabel2)
        gridArray.append(gridLabel3)
        gridArray.append(gridLabel4)
        gridArray.append(gridLabel5)
        gridArray.append(gridLabel6)
        gridArray.append(gridLabel7)
        gridArray.append(gridLabel8)
        
        
        //creates matrix for the tic-tac-toe board
        grid = [ [gridLabel0 , gridLabel3 , gridLabel6 ], [gridLabel1 , gridLabel4 , gridLabel7], [gridLabel2 , gridLabel5 , gridLabel8] ]
        
        //sets the disposable tapArray
        tapArray = gridArray
    }
    
    @IBAction func onTappedGridLabel(_ sender: UITapGestureRecognizer)
    {
        
        //if a blank label in the veiw is pressed, it will...
        for label in gridArray
        {
            
            if label.frame.contains(sender.location(in: backgroundView))
            {
                if label.text == ""
                {
                    //...become X
                    label.text = "X"
                    
                    for label2 in tapArray
                    {
                        //THIS REMOVES OCCUPIED SPACES FROM TAPARRAY
                        if label2.text != ""
                        {
                            //...be removed from tapArray
                            tapArray.remove(at: tapArray.index(of: label2)!)
                        }
                    }
                    //...call check for winner
                    checkForWinner()
                    //...make the bot go
                    botGoes()
                }
                
            }
        }
    }
    
    
    func botGoes()
    {
        if !tapArray.isEmpty
        {
            func randomMove()
            {
                //bot will go to a random open spot
                var avail = [GridLabel]()
                for a in 0..<gridArray.count
                {
                    if gridArray[a].text == ""
                    {
                        avail.append(gridArray[a])
                    }
                    
                }
                avail[Int(arc4random_uniform(UInt32(avail.count-1)))].text = "O"
            }
            
            func bestMove (who: String) -> Bool
            {
                //if there is a blocking spot, go there, return true, and check for winner
                for a in 0...2
                {
                    if grid[a][0].text==who && grid[a][1].text==who && grid[a][2].text==""
                    {
                        grid[a][2].text = "O"
                        checkForWinner()
                        return true
                    }
                    if grid[a][0].text==who && grid[a][1].text=="" && grid[a][2].text==who
                    {
                        grid[a][1].text = "O"
                        checkForWinner()
                        return true;
                    }
                    if grid[a][0].text=="" && grid[a][1].text==who && grid[a][2].text==who
                    {
                        grid[a][0].text = "O"
                        checkForWinner()
                        return true;
                    }
                }
                
                for b in 0...2
                {
                    if grid[0][b].text==who && grid[1][b].text==who && grid[2][b].text==""
                    {
                        grid[2][b].text = "O"
                        checkForWinner()
                        return true;
                    }
                    if(grid[0][b].text==who && grid[1][b].text=="" && grid[2][b].text==who){
                        grid[1][b].text = "O"
                        checkForWinner()
                        return true;
                    }
                    if grid[0][b].text=="" && grid[1][b].text==who && grid[2][b].text==who
                    {
                        grid[0][b].text = "O"
                        checkForWinner()
                        return true;
                    }
                }
                
                if(grid[0][0].text==who && grid[1][1].text==who && grid[2][2].text=="")
                {
                    grid[2][2].text = "O"
                    checkForWinner()
                    return true;
                }
                
                if grid[0][0].text==who && grid[1][1].text=="" && grid[2][2].text==who
                {
                    grid[1][1].text = "O"
                    checkForWinner()
                    return true;
                }
                
                if grid[0][0].text=="" && grid[1][1].text==who && grid[2][2].text==who
                {
                    grid[0][0].text = "O"
                    checkForWinner()
                    return true;
                }
                
                if grid[0][2].text==who && grid[1][1].text==who && grid[2][0].text==""
                {
                    grid[2][0].text = "O"
                    checkForWinner()
                    return true;
                }
                
                if grid[0][2].text==who && grid[1][1].text=="" && grid[2][0].text==who
                {
                    grid[1][1].text = "O"
                    checkForWinner()
                    return true;
                }
                
                if grid[0][2].text=="" && grid[1][1].text==who && grid[2][0].text==who
                {
                    grid[0][2].text = "O"
                    checkForWinner()
                    return true;
                }
                return false
            }
            
            
            
            //go to random spot (and check for winner) if there are not blocking moves
            if !bestMove(who: "O")
            {
                if !bestMove(who: "X")
                {
                    randomMove()
                    checkForWinner()
                }
            }
            
        }
        
    }
    
    func checkForWinner()
    {
        for i in 0..<grid.count
        {
            if  grid[i][0].text! == grid[i][1].text! && grid[i][0].text! == grid[i][2].text! && grid[i][0].text! != "" //Checks each columns for a winner
            {
                //column shows up red
                grid[i][0].textColor = .red
                grid[i][1].textColor = .red
                grid[i][2].textColor = .red
                
                winner(winningChar: grid[i][0].text!)
            }
        }
        
        for x in 0..<grid[0].count
        {
            if  grid[0][x].text! == grid[1][x].text! && grid[0][x].text! == grid[2][x].text! && grid[0][x].text! != "" //Checks each row for a winner
            {
                //row shows up red
                grid[0][x].textColor = .red
                grid[1][x].textColor = .red
                grid[2][x].textColor = .red
                winner(winningChar: grid[0][x].text!)
            }
        }
        
        //===============================================================
        //check for diagonals
        if grid[0][0].text! == grid[1][1].text! && grid[0][0].text! == grid[2][2].text! && grid[0][0].text! != ""
        {
            //diagonal shows up red
            grid[0][0].textColor = .red
            grid[1][1].textColor = .red
            grid[2][2].textColor = .red
            winner(winningChar: grid[0][0].text!)
        }
        
        if grid[2][0].text! == grid[1][1].text! && grid[0][2].text! == grid[2][0].text! && grid[2][0].text! != ""
        {
            //diagonal shows up read
            grid[2][0].textColor = .red
            grid[1][1].textColor = .red
            grid[0][2].textColor = .red
            winner(winningChar: grid[2][0].text!)
        }
        //===============================================================
        
        //if tapArray is empty and now winner, it is a draw
        if tapArray.isEmpty
        {
            draw()
        }
        
        
    }
    
    func winner(winningChar: String)
    {
        tapArray.removeAll()
        let winAlert = UIAlertController(title: "\(winningChar) won!", message: nil, preferredStyle: .alert)
        let winAlertAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.restartGame()
        }
        winAlert.addAction(winAlertAction)
        present(winAlert, animated: true, completion: nil)
        
        if winningChar == "X"
        {
            scoreX += 1
        }
        else
        {
            scoreO += 1
        }
        
        scoreLabel.text = "\(scoreX) : \(scoreO)"
    }
    
    func draw()
    {
        tapArray.removeAll()
        let drawAlert = UIAlertController(title: "Draw!", message: nil, preferredStyle: .alert)
        let drawAlertAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.restartGame()
        }
        drawAlert.addAction(drawAlertAction)
        present(drawAlert, animated: true, completion: nil)
    }
    
    func restartGame()
    {
        //=======================================
        //makes the labels black
        for a in 0...2
        {
            for b in 0...2
            {
                grid[a][b].textColor = .black
            }
        }
        //=======================================
        
        //clear labels for new game
        gridLabel0.text = ""
        gridLabel1.text = ""
        gridLabel2.text = ""
        gridLabel3.text = ""
        gridLabel4.text = ""
        gridLabel5.text = ""
        gridLabel6.text = ""
        gridLabel7.text = ""
        gridLabel8.text = ""
        tapArray = gridArray
        
        
        
    }
    
    @IBAction func resetButtonTapped(_ sender: Any)
    {
        restartGame()
        scoreX = 0
        scoreO = 0
        scoreLabel.text = "\(scoreX) : \(scoreO)"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

