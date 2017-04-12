//
//  ViewController.swift
//  In-App Purchase Demo
//
//  Created by Andrew Voelker on 4/1/17.
//  Copyright © 2017 Andrew Voelker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var feature1Unlcoked : Bool?
    var feature2Unlcoked : Bool?

    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button1: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let appdelegate = UIApplication.shared.delegate
            as! AppDelegate
        appdelegate.homeViewController = self
        
        //initial states
        feature1Unlcoked = false
        feature2Unlcoked = false
        image1.isHidden = false
        image2.isHidden = false
        
        let userDefaults = UserDefaults.standard
        //check to see if feature 1 was unlocked
        if userDefaults.value(forKey: "1") != nil {
            enableLevel1()
        }
        //check to see if feature 2 was unlocked
        if userDefaults.value(forKey: "2") != nil {
            enableFeature2()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func enableLevel1() {
        feature1Unlcoked = true
        image1.isHidden = true
        // save true for key 1 - which saves feature 1 as unlocked
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(true, forKey: "1")
        userDefaults.synchronize()
    }
    
    func enableFeature2() {
        feature2Unlcoked = true
        image2.isHidden = true
        // save true for key 2 - which saves feature 2 as unlocked
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(true, forKey: "2")
        userDefaults.synchronize()
    }
    
    @IBAction func feature1ButtonCLick(_ sender: Any) {
        if (feature1Unlcoked == true){
            self.performSegue(withIdentifier: "feature1Segue", sender: button1)
        }
        else if(feature1Unlcoked == false){
            self.performSegue(withIdentifier: "purchaseSegue", sender: button1)
        }
    }
    @IBAction func feature2ButtonClick(_ sender: Any) {
        if (feature2Unlcoked == true){
            self.performSegue(withIdentifier: "feature2Segue", sender: button2)
        }
        else if(feature2Unlcoked == false){
            self.performSegue(withIdentifier: "purchaseSegue", sender: button2)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "purchaseSegue"){
                if ((sender as? UIButton)?.tag == 1){
                    print("button 1 click - pruchase segue")
                    productID = "keiretsuv.InAppPurchaseDemo"
                }
                else if ((sender as? UIButton)?.tag == 2){
                    print("button 2 click - pruchase segue")
                    productID = "keiretsuv.InAppPurchaseDemo2"
                }
            }
    }


}

