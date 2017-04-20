//
//  ViewController.swift
//  CodepathLab4
//
//  Created by Akshay Bhandary on 4/19/17.
//  Copyright © 2017 AkshayBhandary. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    
    var trayOriginalCenter: CGPoint!

    var trayCenterWhenOpen : CGPoint!
    var trayCenterWhenClosed : CGPoint!
    
    var newlyCreatedFace: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        trayCenterWhenOpen = CGPoint(x: trayView.center.x, y: self.view.frame.size.height - trayView.frame.size.height / 2)
        trayCenterWhenClosed =  CGPoint(x: trayView.center.x, y: self.view.frame.height + trayView.frame.size.height / 4)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func panGesture(_ panGestureRecognizer: UIPanGestureRecognizer) {

        let point = panGestureRecognizer.location(in: self.view)
        
        let translation  = panGestureRecognizer.translation(in: trayView)
        let velocity = panGestureRecognizer.velocity(in: trayView)
        
        if panGestureRecognizer.state == .began {
            print("Gesture began at: \(point)")
            trayOriginalCenter = trayView.center
        } else if panGestureRecognizer.state == .changed {
            print("Gesture changed at: \(point)")
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        } else if panGestureRecognizer.state == .ended {
            print("Gesture ended at: \(point)")
            let finalValue = velocity.y > 0 ? trayCenterWhenClosed : trayCenterWhenOpen
            
            UIView.animate(withDuration: 0.8,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 2.0,
                           options: .beginFromCurrentState,
                           animations: {
                            self.trayView.center = finalValue! },
                           completion: nil)
        }
    }

    @IBAction func panGestureOnImage(_ panGestureRecognizer: UIPanGestureRecognizer) {
        
        let imageView = panGestureRecognizer.view as! UIImageView
        
        let point = panGestureRecognizer.location(in: self.view)
        let translation = panGestureRecognizer.translation(in: trayView)
        
        if panGestureRecognizer.state == .began {
            // Create a new image view that has the same image as the one currently panning
            newlyCreatedFace = UIImageView(image: imageView.image)
            
            // Add the new face to the tray's parent view.
            view.addSubview(newlyCreatedFace)
            
            // Initialize the position of the new face.
            newlyCreatedFace.center = imageView.center
            
            // Since the original face is in the tray, but the new face is in the
            // main view, you have to offset the coordinates
            newlyCreatedFace.center.y += trayView.frame.origin.y

        } else if panGestureRecognizer.state == .changed {
            newlyCreatedFace.center = point
        } else if panGestureRecognizer.state == .ended {
            print("Gesture ended at: \(point)")
            
            
        }

        
    }
}

