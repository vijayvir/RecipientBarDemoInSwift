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
    
    @IBOutlet weak var heightConstraint_ObjSvb: NSLayoutConstraint!
    //MARK: CLC
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        obj_SNBCon.initializeSubviews(obj_SNBCon.frame, parentViewController: self, leoDelegate: self )
        
        fritNameArr += [ "vijayvir"," Yash"," Aman","ajay","jang","arsh","jaskirat", "raj", "jasvir", "jashan"," sonna"," avneep"," amit"," lali"," jasmeet"]

    
        
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

    
    //MARK: LEO Delgate
    
   
    @objc func leoPredictionArry () ->Array<String>
    {
        
        return fritNameArr
    }
    
     func leoCustomizeChip(chip : ChipViewControl  , objectIndex index : Int , withSearchArray arr : [String] )
     {
      chip.userName!.text = arr[index]
     }
    func leoCustomCell(cell: SenderTableViewCell , cellForRowAtIndexPath indexPath: NSIndexPath , currentArr : [String] ) ->()
    {
        cell.lbl_Name?.text = "\(currentArr[indexPath.row])"
    }
    @objc   func leoCustomCelldidSelectRowAtIndexPath(indexPath : NSIndexPath , tableViewArray tableArr : [String] , withSearchArray arr : [String] ) ->(Bool )
    {
        
        return false
        
    }
    
    @objc  func leoSenderBarUpdateHeightConstaint (height : CGFloat) ->()
    {
        heightConstraint_ObjSvb.constant = height
    }
}

