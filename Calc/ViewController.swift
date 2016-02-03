//
//  ViewController.swift
//  Calc
//
//  Created by Henry Goodwin on 3/02/2016.
//  Copyright © 2016 Henry Goodwin. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case minus = "-"
        case Empty = ""
    }
    
    @IBOutlet weak var displayLabel : UILabel!
    
    var sound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftVarString = ""
    var rightVarString = ""
    var results = ""
    var currentOperation: Operation = Operation.Empty
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        displayLabel.text = "0"
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: ".wav")
        let URL = NSURL(fileURLWithPath: path!)
        
        do {
            try sound = AVAudioPlayer(contentsOfURL: URL)
            sound.prepareToPlay()
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    func playSound() {
        
        if sound.playing {
            sound.stop()
        }
        
        sound.play()
        
        
    }
    
    @IBAction func numberPressed(btn: UIButton) {
        playSound()
        runningNumber += "\(btn.tag)"
        displayLabel.text = runningNumber
        
    }

    @IBAction func clear(sender: AnyObject) {
        playSound()
        runningNumber = ""
        leftVarString = ""
        rightVarString = ""
        results = ""
        currentOperation = Operation.Empty
        displayLabel.text = "0"
    }

    @IBAction func divide(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func multiply(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
  
    @IBAction func minus(sender: AnyObject) {
        processOperation(Operation.minus)
    }
    
    @IBAction func add(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func equals(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
        
        if runningNumber != "" {
            
            rightVarString = runningNumber
            runningNumber = ""
                
                if currentOperation == Operation.Divide {
                    results = "\((Double(leftVarString)! / Double(rightVarString)!))"
                    
                } else if currentOperation == Operation.Multiply {
                    results = "\((Double(leftVarString)! * Double(rightVarString)!))"
                } else if currentOperation == Operation.minus {
                    results = "\((Double(leftVarString)! - Double(rightVarString)!))"
                } else if currentOperation == Operation.Add {
                    results = "\((Double(leftVarString)! + Double(rightVarString)!))"
                }
            
            leftVarString = results
            displayLabel.text = results
            }
            
            currentOperation = op
        } else {
            //This is the first time an operator has been pressed
            leftVarString = runningNumber
            runningNumber = ""
            currentOperation = op
        }
            }
    

    
    
}

