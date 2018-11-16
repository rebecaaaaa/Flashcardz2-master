//
//  ViewController.swift
//  Flashcardz
//
//  Created by Rebeca Chavez on 10/13/18.
//  Copyright © 2018 Rebeca Chavez. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
}

class ViewController: UIViewController{
    
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var Button3: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    //Array to hold our flashcards
    var flashcards = [Flashcard]()
    
    //Current flashcard index
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    frontLabel.layer.cornerRadius = 20.0
    backLabel.layer.cornerRadius = 20.0
    //card.clipsToBounds = true
        frontLabel.clipsToBounds = true
        backLabel.clipsToBounds = true
    card.layer.shadowRadius = 15.0
    card.layer.shadowOpacity = 0.2
    card.layer.cornerRadius = 20.0
    Button1.layer.cornerRadius = 20.0
    Button2.layer.cornerRadius = 20.0
    Button3.layer.cornerRadius = 20.0
    Button1.layer.borderWidth = 3.0
    Button1.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    Button2.layer.borderWidth = 3.0
    Button2.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    Button3.layer.borderWidth = 3.0
    Button3.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        updateFlashcard(question: "What is the capital of Vietnam?", answer: "Hanoi", extraAnswerOne: "", extraAnswerTwo: "")
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if(frontLabel.isHidden){
            frontLabel.isHidden = false
        } else {
            frontLabel.isHidden = true
        }
    }
    func updateFlashcard(question: String, answer: String, extraAnswerOne: String?, extraAnswerTwo: String?){
        let flashcard = Flashcard(question: question, answer: answer)
        frontLabel.text = flashcard.question
        backLabel.text = flashcard.answer
        flashcards.append(flashcard)
        // Logging into the console
        print("Added new flashcard")
        print("We now have \(flashcards.count) flashcards")
        // Update current index
        currentIndex = flashcards.count - 1
        print("Our current index is \(currentIndex)")
        
        // Update buttons
        updateNextPrevButtons()
        
        // Update labels
        updateLabels()
        
        func saveAllFlashcardsToDisk(){
            
            // Save array on disk using UserDefaults
            UserDefaults.standard.set(flashcards, forKey: "flashcards")
            
            // From flashcard array to dictionary array
            _ = flashcards.map { (card) -> [String:String] in return ["question": card.question, "answer":card.answer]
                
                //Log it
                print("Flashcards saved to UserDefaults")
            }
        }
        
        Button1.setTitle(extraAnswerOne, for: .normal)
        Button2.setTitle(answer, for: .normal)
        Button3.setTitle(extraAnswerTwo, for: .normal)
        
    }
    
    func updateNextPrevButtons() {
        // Disable next button if at the end
        print(currentIndex)
        print(flashcards.count-1)
        if currentIndex == flashcards.count - 1 {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
        
        // Disable prev button if at the beginning
        if currentIndex == 0 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
    }
    func updateLabels() {
        // Get current flashcard
        let currentFlashcard = flashcards[currentIndex]
        
        // Update labels
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
        
        //Update buttons
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnButton1(_ sender: Any) {Button1.isHidden = true
    }
    @IBAction func didTapOnButton2(_ sender: Any) {frontLabel.isHidden = true
    }
    
    @IBAction func didTapOnButton3(_ sender: Any) {Button3.isHidden = true
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
    
        // Increase current index
        //currentIndex = currentIndex + 1
        currentIndex += 1;
        //Update labels
        updateLabels()
        
        //Update buttons
        updateNextPrevButtons()
    
    }
    @IBAction func didTapOnPrev (sender:Any){
        // Decrease current index
        currentIndex -= 1;
        
        // Update labels
        updateLabels()
        
        // Update buttons
        updateNextPrevButtons()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
    let navigationController = segue.destination as! UINavigationController
   
        let creationController = navigationController.topViewController as! CreationViewController

creationController.flashcardsController = self
creationController.initialQuestion = frontLabel.text
creationController.initialAnswer = backLabel.text
    if segue.identifier == "EditSegue" {
    creationController.initialQuestion = frontLabel.text
    creationController.initialAnswer = backLabel.text
}
}
}
