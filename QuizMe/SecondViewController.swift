//
//  ViewController.swift
//  QuizMe
//
//  Created by Mike Chu on 5/26/15.
//  Copyright (c) 2015 Mike Chu. All rights reserved.
//

//TODO: add support for a UIPickerView

import UIKit

class SecondViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{
   
    @IBOutlet var questionLabel : UILabel!
    @IBOutlet var image : UIImageView!
    @IBOutlet var score : UILabel!
   // @IBOutlet var pickerLabel : UILabel!
  //  @IBOutlet weak var button : UIButton! //controls the next question button
    @IBOutlet var displayLbl : UILabel!
    
    @IBOutlet var scroll : UIScrollView!
    
    @IBOutlet var picker : UIPickerView!
    
    //let alert = UIAlertView() //this is deperciated, shouldn't be used.
    
    //let alert = UIAlertController()
    
    var index = 0
    var intScore = 0
    var attempts = 0
    
    var randomChoices = ["Neville Chamberlin", "Adolph Hitler", "Hiroshima", "Nagasaki", "HiroHito", "General Eisenhower", "Albert Enstein",
        "Darth Vader", "Anne Frank", "Captain Kirk", "Benito Mussolini", "Charles de Gaulle"]
    
    var questions = ["Who led us into WWII?", "Who was the Prime Minister of England during WWII?", "Who gave the order to drop the bomb on Japan in WWII?"]
    var answers = ["FDR", "Winston Churchill", "Harry Truman"]
    var images = ["fdr", "winston", "atom_bomb"]
    
    var dataSource = ["", "", "", ""]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        questionLabel.text = questions[index]
        image.image = UIImage(named: images[index])
        //questionLabel.text = questions[index]
        setChoices()
        picker.dataSource = self
        picker.delegate = self
        picker.backgroundColor = UIColor.whiteColor()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return dataSource.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        
        return dataSource[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        var title = "Is this your final answer?"
        var msg = "\(dataSource[row])"
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "No", style: .Default, handler: nil)
        let resetAction = UIAlertAction(title: "Yes", style: .Default, handler: { (action: UIAlertAction!) in
            self.checkAnswer(self.dataSource[row])
        })
        alert.addAction(defaultAction)
        alert.addAction(resetAction)
        presentViewController(alert, animated: true, completion: nil)
        displayLbl.text = "\(row) and \(dataSource[row])"
    }
    
    func setChoices()
    {
        var r1 = Int(arc4random_uniform(UInt32(randomChoices.endIndex)))
        var r2 = Int(arc4random_uniform(UInt32(randomChoices.endIndex)))
        var r3 = Int(arc4random_uniform(UInt32(randomChoices.endIndex)))
        
        while(r1 == r2 || r1 == r3)
        {
            r1 = Int(arc4random_uniform(UInt32(randomChoices.endIndex)))
        }
        
        while(r2 == r3)
        {
            r2 = Int(arc4random_uniform(UInt32(randomChoices.endIndex)))
        }
        
        // all the code above is getting the indicies of the randomChoices that'll be used.
        // the following code will randomly assign the choices above and the real answer to an array named dataSource. I think.
        
        var ri1 = Int(arc4random_uniform(UInt32(dataSource.endIndex)))
        var ri2 = Int(arc4random_uniform(UInt32(dataSource.endIndex)))
        var ri3 = Int(arc4random_uniform(UInt32(dataSource.endIndex)))
        var ri4 = Int(arc4random_uniform(UInt32(dataSource.endIndex)))
        
        while(ri1 == r2 || ri1 == ri3 || ri1 == ri4)
        {
            ri1 = Int(arc4random_uniform(UInt32(dataSource.endIndex)))
        }
        while(ri2 == ri3 || ri2 == ri4 || ri2 == ri1)
        {
            ri2 = Int(arc4random_uniform(UInt32(dataSource.endIndex)))
        }
        while(ri3 == ri4 || ri3 == ri2 || ri3 == ri1)
        {
            ri3 = Int(arc4random_uniform(UInt32(dataSource.endIndex)))
        }
        
        dataSource[ri1] = answers[index] //problem??
        dataSource[ri2] = randomChoices[r1]
        dataSource[ri3] = randomChoices[r2]
        dataSource[ri4] = randomChoices[r3]
        picker.dataSource = self
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI()
    {
        attempts = 0
        if(index < questions.endIndex - 1)
        {
            index++
            setChoices()
            questionLabel.text = questions[index]
            image.image = UIImage(named: images[index])
            questionLabel.text = questions[index]
            
        }
        else
        {
            var title = "You finished!"
            var percent = (Double(intScore)/Double((questions.endIndex*3)))*100
            var msg = "You got \(intScore) points of \(questions.endIndex * 3). That's \(percent)%"
            var message = msg
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "Okay", style: .Default, handler: nil)
            let resetAction = UIAlertAction(title: "Reset", style: .Default, handler: { (action: UIAlertAction!) in
                self.index = -1
                self.updateUI()
                self.intScore = 0
                self.score.text = "Your score here"
            })
            
            alert.addAction(defaultAction)
            alert.addAction(resetAction)
            
            presentViewController(alert, animated: true, completion: nil)
        }
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
        
        let alert = UIAlertController(title: rsp, message: "", preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "Okay", style: .Default, handler: nil)
        
        alert.addAction(action)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func checkAnswer(ans : String) -> Bool //TODO: Modify this for this code
    {
        if (ans == self.answers[self.index])
        {
            if(attempts == 0)
            {
                intScore += 3
            }
            else if(attempts == 1)
            {
                intScore += 2
            }
            else
            {
                intScore += 1
            }
            attempts == 0
            score.text = "\(intScore)"
            updateUI()
            
            return true
        }
        else
        {
            let alert = UIAlertController(title: "Incorrect", message: "Try again", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Okay", style: .Default, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
            attempts++
            return false
        }
    }
}

