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
    @IBOutlet var pickerLabel : UILabel!
    @IBOutlet weak var button : UIButton! //controls the next question button
    
    @IBOutlet var scroll : UIScrollView!
    
    @IBOutlet var picker : UIPickerView!
    
    //let alert = UIAlertView() //this is deperciated, shouldn't be used.
    
    //let alert = UIAlertController()
    
    var index = 0
    var intScore = 0
    var attempts = 0
    
    var questions = ["Who led us into WWII?", "Who was the Prime Minister of England during WWII?", "Who gave the order to drop the bomb on Japan in WWII?"]
    var answers = ["FDR", "Winston Churchill", "Harry Truman"]
    var images = ["fdr", "winston", "atom_bomb"]
    
    var pickerData = ["Who led us into WWII?", "Who was the Prime Minister of England during WWII?", "Who gave the order to drop the bomb on Japan in WWII?"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        questionLabel.text = questions[index]
        image.image = UIImage(named: images[index])
        questionLabel.text = questions[index]
        
        picker.dataSource = self
        picker.delegate = self
        
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //pickerLabel.text = pickerData[row]
        //checkAnswer(pickerData[row])
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*func keyboardWillShow(sender: NSNotification)
    {
        var info = sender.userInfo!
        var keyboardFrame : CGRect = (info[UIKeyboardFrameEndUserInfoKey]as! NSValue).CGRectValue()
        
        var scrollPoint = CGPointMake(0, keyboardFrame.height) //-keyboardFrame.height
        scroll.setContentOffset(scrollPoint, animated: true)
    }
    
    /*func keyboardWillHide(sender: NSNotification)
    {
        scroll.setContentOffset(CGPointZero, animated: true)
    }*/*/
    
    
    
   /* func updateUI()
    {
        attempts = 0
        if(index < questions.endIndex - 1)
        {
            index++
            
            questionLabel.text = questions[index]
            image.image = UIImage(named: images[index])
            questionLabel.text = questions[index]
           // answer.text = ""
            
        }
        else
        {
            
            // newAlert.title = "You finished!"
            //Alert.title
            var title = "You finished!"
            var msg = "You got \(intScore) points of \(questions.count * 3). That's \(intScore/(questions.count*3))%"
            
            //alert.addButtonWithTitle("Done")
            
            //alert.addButtonWithTitle("Reset")
            var message = msg
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "Okay", style: .Default, handler: nil)
            let resetAction = UIAlertAction(title: "Reset", style: .Default, handler: { (action: UIAlertAction!) in
                self.index = -1
                self.updateUI()
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
    
    func checkAnswer(ans : String) -> Bool
    {
        //var userAnswer = answer.text.lowercaseString
        var attemptsText = ""
        if (ans == questions[index])
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
    
    /*@IBAction func checkTapped(sender : UIButton)
    {
        if(checkAnswer())
        {
            updateUI()
        }
        showAlert(checkAnswer())
    }*/*/
}

