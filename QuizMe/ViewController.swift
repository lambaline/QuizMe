//
//  ViewController.swift
//  QuizMe
//
//  Created by Mike Chu on 5/26/15.
//  Copyright (c) 2015 Mike Chu. All rights reserved.
//

//TODO: add support for a UIPickerView

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var questionLabel : UILabel!
    @IBOutlet var image : UIImageView!
    @IBOutlet var score : UILabel!
    @IBOutlet var answer : UITextField! = nil
    @IBOutlet weak var button : UIButton! //controls the next question button
    
    let alert = UIAlertView() //this is deperciated, shouldn't be used.
    
    //let newAlert = UIAlertController()
    
    var index = 0
    var intScore = 0
    var attempts = 0
    
    var questions = ["Who led us into WWII?", "Who was the Prime Minister of England during WWII?", "Who gave the order to drop the bomb on Japan in WWII?"]
    var answers = ["FDR", "Winston Churchill", "Harry Truman"]
    var images = ["fdr", "winston", "atom_bomb"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        button.enabled = false
        //answer.enabled = true
        questionLabel.text = questions[index]
        image.image = UIImage(named: images[index])
        questionLabel.text = questions[index]
        answer.delegate = self
    }
    
    func textFieldShouldReturn(TextField: UITextField) -> Bool
    {
        if(checkAnswer())
        {
            answer.resignFirstResponder()
            updateUI()
            return true
        }
        showAlert(checkAnswer())
        
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextQuestionTapped(sender : UIButton)
    {
        if(checkAnswer())
        {
            updateUI()
        }
        showAlert(checkAnswer())
    }
    
    func updateUI()
    {
        if(index < questions.endIndex)
        {
            index++
        }
        else
        {
           // newAlert.title = "You finished!"
            alert.title = "You finished!"
            var msg = "You got \(intScore) points of \(questions.count * 3). That's \(intScore/(questions.count*3))%"
            alert.addButtonWithTitle("Done")
            
            alert.addButtonWithTitle("Reset")
            alert.message = msg
            
        }
        questionLabel.text = questions[index]
        image.image = UIImage(named: images[index])
        questionLabel.text = questions[index]
    }
    
    func showAlert(c : Bool)
    {
        var rsp = ""
        if(c)
        {
            rsp = "Correct"
        }
        else
        {
            rsp = "Incorrect"
        }
        alert.title = rsp
        alert.addButtonWithTitle("Okay")
        alert.show()
    }
    
    func checkAnswer() -> Bool
    {
        var userAnswer = answer.text.lowercaseString
        var attemptsText = ""
        if (userAnswer == answers[index].lowercaseString)
        {
            if(attempts == 0)
            {
                intScore += 3
            }
            if(attempts == 1)
            {
                intScore += 2
            }
            else
            {
                intScore += 1
            }
            return true
        }
        
        return false
    }
    
    @IBAction func checkTapped(sender : UIButton)
    {
        if(checkAnswer())
        {
            updateUI()
        }
        showAlert(checkAnswer())
    }
}

