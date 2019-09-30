//
//  ViewController.swift
//  MNGControlsKit
//
//  Created by Tommie Carter on 9/30/19.
//  Copyright © 2019 MING Technology LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var customSegmentedControl: MNGMultiSegmentControl!
    ///file:///Users/Shared/Working/iosapps/MNGControlsKit/MNGControlsKit/Main.storyboard: error: IB Designables: Failed to render and update auto layout status for UIViewController (hBF-oH-7Uf): Failed to load designables from path (null)
    @IBAction func customSegementIndexChanged() {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.customSegmentedControl.didFinishTappingButton = { btn in
                   
        }
        
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
