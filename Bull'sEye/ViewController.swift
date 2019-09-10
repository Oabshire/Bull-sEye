//
//  ViewController.swift
//  Bull'sEye
//
//  Created by Onie on 04/09/2019.
//  Copyright © 2019 Onie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var sliderValue : Int = 0
    var targetValue : Int = 0
    var scoreValue : Int = 0
    var roundValue : Int = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var target: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var round: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startOverAction()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizeble = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizeble, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizeble = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizeble, for: .normal)
        
    }
    
  
    
    @IBAction func hitMeButton() {
        
        var points = calculatePoint()
        
        var title = String()
        
        if points < 90{
            title = "Not even close..."
        }
        else if points < 95{
            title  = "Pretty good!"
        }
        else if points < 100{
            title = "You almost had it!"
        }
        else {
            title = "Perfect!"
            points = points+100
        }
        
        scoreValue = scoreValue+points
        let message = "The value of the slider is: \(sliderValue)\nYou scored \(points) points!"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Awesome", style: .default, handler: {
            action in
            self.startNewRound()
            self.score.text = String(self.scoreValue)
        })
        alert.addAction(alertAction)
        present(alert, animated: true,completion: nil)
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        let value = sender.value
        let roundValue = value.rounded()
        sliderValue = Int(roundValue)
    }
    
    func startNewRound(){
        let value = slider.value.rounded()
        sliderValue = Int(value)
        
        targetValue = Int.random(in: 1...100)
        target.text = String(targetValue)
        
        roundValue = roundValue + 1
        
        score.text = String(scoreValue)
        round.text = String(roundValue)
    }
    
    func calculatePoint() -> Int{
        var difference:Int = 0
        if sliderValue>targetValue{
            difference = sliderValue-targetValue
        }
        else if targetValue>sliderValue{
            difference = targetValue-sliderValue
        }
        return 100 - difference
    }
    
    
    @IBAction func startOverAction() {
        scoreValue = 0
        roundValue = 0
        startNewRound()
    }
}

