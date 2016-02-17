//
//  ViewController.swift
//  SenderNameBarInSwift
//
//  Created by OSX on 16/02/16.
//  Copyright © 2016 Vijayvir. All rights reserved.
//

import UIKit

class ViewController: UIViewController, LeoSenderBarControllerDelegate
{

   
    
    //MARK: Outlets
    
    @IBOutlet weak var obj_SNBCon: SenderNameBarController!
    

    var fritNameArr : [String] = []
    
    //MARK: CLC
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        obj_SNBCon.initializeSubviews(obj_SNBCon.frame, parentViewController: self, leoDelegate: self)
        
        fritNameArr += [ "vijayvir"," harminder"," shanni","avneet","ricky","satvir","param", "cijay", "Boysenberry", "Cantaloupe"," cucumber"," Currant"," Cherry"," Cherimoya"," Cloudberry"," Coconut", "Cranberry"," Damson", "Date"," Dragonfruit", "Durian","Elderberry","Feijoa","Fig", "Goji ber"]
       
        
        
        
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
      
    }

    //MARK: Actions
    @IBAction func action_HideUnHideNav(sender: UIButton)
    {
     obj_SNBCon.hidden = !obj_SNBCon.hidden
    }

    
    //MARK: LEODelgate
    
   
    @objc func leoPredictionArry () ->Array<String>
    {
        
        return fritNameArr
    }
}

