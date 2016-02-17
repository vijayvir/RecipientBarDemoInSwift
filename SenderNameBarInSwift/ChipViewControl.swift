//
//  ChipViewControl.swift
//  SenderNameBarInSwift
//
//  Created by OSX on 16/02/16.
//  Copyright © 2016 Vijayvir. All rights reserved.
//

import UIKit


class ChipViewControl: UIView
{

    //MARK: varible 
    var anyVarible : AnyObject?
    

 
    @IBOutlet weak var btnAction: UIButton!
   
  
    @IBOutlet weak var userName: UILabel!
    
    var completionHandler:((anyVarible :AnyObject)->Void)!
    
    //CLC
    
    
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
        
        

        
    }
   
 
  

 
 override func drawRect(rect: CGRect)
    {
        // Drawing code
        
        
        self.layer.backgroundColor = UIColor.clearColor().CGColor
        
        self.layer.cornerRadius = 4;
        
        self.layer.masksToBounds = true;
        
        
    }
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }
    
  
    
    @IBAction func action_removeFromView(sender: AnyObject)
    {
        
        completionHandler(anyVarible: anyVarible!)
    }

}
