//
//  CreationViewController.swift
//  Flashcardz
//
//  Created by Rebeca Chavez on 10/27/18.
//  Copyright © 2018 Rebeca Chavez. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {

var flashcardsController: ViewController!

    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var extraanswer1TextField: UITextField!
    @IBOutlet weak var extraanswer2TextField: UITextField!
    var initialQuestion: String?
    var initialAnswer: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        questionTextField.text = initialQuestion
        questionTextField.text = initialAnswer
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)}
    
    @IBAction func didTapOnDone(_ sender: Any) {
   let questionText = questionTextField.text
   let answerText = answerTextField.text
        if (questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty){
            let alert = UIAlertController (title: "Missing Text", message: "You need to enter both a question and an answer", preferredStyle: .alert)
            alert.addAction(UIAlertAction (title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true)
        }
        else {
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, extraAnswerOne: extraanswer1TextField.text, extraAnswerTwo: extraanswer2TextField.text)
        }
  dismiss(animated: true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


    
}
