//
//  StartViewController.swift
//  project3 Xcode
//
//  Created by Joseph Daniel Ramli on 10/8/19.
//  Copyright © 2019 Joseph Daniel Ramli. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NSLog("STARTED THE STARTVIEW CONTROLLER!")
        //self.view.backgroundColor = UIColor(red: 4.0, green: 52.0, blue: 96.0, alpha: 1.0)
       
        
    }
    override func viewWillDisappear(_ animated: Bool) {
       //print("This is where the screen can be removed from being run if necessary")
        
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
