//
//  ViewController.swift
//  VisualRecognition
//
//  Created by Anuj Gupta on 14/05/17.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit
import VisualRecognitionV3
import Alamofire
import AlamofireImage

class ViewController: UIViewController {

    let api_key = "db263b3f41551f431335ea5a1e1fc0ab240968f1"
    let version = "14-05-2017"
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func handleClick(_ sender: Any) {
        
        
        let rand = Int(arc4random_uniform(1000))
        let url = URL(string: "https://unsplash.it/400/700?image=\(rand)")
        imageview.af_setImage(withURL: url!)
        
        let recogURL = URL(string: "https://unsplash.it/60/100?image=\(rand)")
        
        let visualrecog = VisualRecognition(apiKey: api_key, version: version)
        
        let failure = {(error:Error) in
        
            DispatchQueue.main.async {
                self.label.text = "Cannot"
            }
        
        }
        
        visualrecog.classify(image: (recogURL?.absoluteString)!, failure: failure){
            classifiedImages in
            
            if let classifiedImage = classifiedImages.images.first{
                print(classifiedImage.classifiers)
                
                if let classification = classifiedImage.classifiers.first?.classes.first?.classification{
                    self.label.text = classification 
                }
                
            }else{
                print("error")
            }
            
            
            
        }
        
        
    }

}

