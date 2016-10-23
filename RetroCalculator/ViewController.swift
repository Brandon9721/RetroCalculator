//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Brandon Byrne on 2016-10-21.
//  Copyright © 2016 ZeahSoft. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var outputLbl: UILabel!
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    
    enum Operations: String
    {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
        case Clear = "Clear"
    }
    
    var currentOperation = Operations.Empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do
        {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError
        {
            print(err.debugDescription)
        }
   
    
       outputLbl.text = "0"
       runningNumber = "0"
    }
    
    
   
    
    @IBAction func numberPressed(sender: UIButton)
    {
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
        
    }
    
    @IBAction func onDividePressed(sender: AnyObject)
    {
        processOperation(operation: .Divide)
    }
    @IBAction func onMultiplyPressed(sender: AnyObject)
    {
        processOperation(operation: .Multiply)
    }
    @IBAction func onSubtractPressed(sender: AnyObject)
    {
        processOperation(operation: .Subtract)
    }
    @IBAction func onAddPressed(sender: AnyObject)
    {
        processOperation(operation: .Add)
    }
    
    
    @IBAction func onEqualPressed(sender: AnyObject)
    {
        if leftValStr != "0"
        {
        processOperation(operation: currentOperation)
        }
    }
    
    @IBAction func onClearPressed(sender: AnyObject)
    {
        currentOperation = Operations.Empty
        outputLbl.text = "0"
        runningNumber = "0"
        leftValStr = "0"
        rightValStr = "0"
    }
    
    
    
    
    func playSound()
    {
        if btnSound.isPlaying
        {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    func processOperation(operation: Operations)
    {
        playSound()
        if currentOperation != Operations.Empty
        {
            // A user selected an operator, but then selected another operator without first entering a number
            if runningNumber != ""
            {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operations.Multiply
                {
                   result = "\(Double(leftValStr)! * (Double(rightValStr))!)"
                }
                else if currentOperation == Operations.Divide
                {
                    if rightValStr != "0"
                    {
                        result = "\(Double(leftValStr)! / (Double(rightValStr))!)"
                    }
                }
                else if currentOperation == Operations.Subtract
                {
                    result = "\(Double(leftValStr)! - (Double(rightValStr))!)"
                }
                else if currentOperation == Operations.Add
                {
                    result = "\(Double(leftValStr)! + (Double(rightValStr))!)"
                }
                else if currentOperation == Operations.Clear
                {
                    outputLbl.text = "0"
                    leftValStr = "0"
                    rightValStr = "0"
                    runningNumber = "0"
                    currentOperation = Operations.Empty
                }
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOperation = operation
        }
        else
        {
            // This is first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }

   


}

