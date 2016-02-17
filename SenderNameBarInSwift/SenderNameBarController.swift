//
//  SenderNameBarController.swift
//  SenderNameBarInSwift
//
//  Created by OSX on 16/02/16.
//  Copyright © 2016 Vijayvir. All rights reserved.
//

import UIKit

//MARK: Delegate Class

@objc protocol LeoSenderBarControllerDelegate
{

    optional func leoPredictionArry() ->Array<String>

    
    // Required
    func leoCustomCell(cell: SenderTableViewCell , cellForRowAtIndexPath indexPath: NSIndexPath , currentArr : [String] ) ->()
    
   optional  func leoCustomCelldidSelectRowAtIndexPath(indexPath : NSIndexPath , tableViewArray tableArr : [String] , withSearchArray arr : [String] ) ->( Bool )
    
    
    func leoCustomizeChip(chip : ChipViewControl  , objectIndex index : Int , withSearchArray arr : [String] )
    
    optional  func leoSenderBarUpdateHeightConstaint (height : CGFloat) ->()
}


//MARK:- SenderNameBarController
class SenderNameBarController: UIControl,UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource
{


    //MARK:  variable outlets
    
    var txt_CurrentName: UITextField?
 
    
    @IBOutlet weak var btn_Add: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBInspectable var  maxheight : CGFloat = 60 
    
    //MARK:  variable
    
    var predictionArray :[String] = []
    var searchArray : [String] = []
    
    var leoDelegate  : LeoSenderBarControllerDelegate?
    var predictionTableView : UITableView?
    var parentViewController : UIViewController?
    var    contentView  : UIControl?
    var frameOFTableView : CGRect?
    
    //MARK:- CLASS LIFE CYCLE

  
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    // MARK: CLASS HELPER FUNTIONS
    

    
    func initializeSubviews(viewframe: CGRect? , parentViewController : UIViewController? , leoDelegate  : LeoSenderBarControllerDelegate?  )
    {
        // Added custom Container in Above View
        let customView : UIView = NSBundle.mainBundle().loadNibNamed("SenderNameBarContainer", owner: self, options: nil)[0] as! UIView
        self.addSubview(customView)
        
       self.leoDelegate = leoDelegate
        
       
 
        
        self.parentViewController =  parentViewController
        
        customiseTableView(viewframe , parentViewController: parentViewController)
        
    
            customiseContentView()
        
     
        
       
    
        
    }
    
    func customiseTableView (viewframe: CGRect? , parentViewController : UIViewController?)
        
    {
        
        let frame : CGRect = CGRectMake(10, viewframe!.origin.y + viewframe!.size.height , UIScreen.mainScreen().bounds.size.width - 20 , 250)
        
        
        predictionTableView = UITableView(frame: frame, style: UITableViewStyle.Plain)
        self.parentViewController?.view.addSubview(predictionTableView!)
        
        
        predictionTableView!.backgroundColor = UIColor.clearColor()
        
        predictionTableView!.delegate = self;
        
        predictionTableView!.dataSource = self;
        
        predictionTableView!.scrollEnabled = true;
        
        //
        predictionTableView!.registerNib(UINib(nibName: "SenderTableViewCell", bundle: nil), forCellReuseIdentifier: "SenderTableViewCell")
        
        hideSelf()
    }
    func customiseContentView()
    {
        contentView = UIControl()
        contentView?.tag = 0
        contentView?.addTarget(self, action: "contentViewTouchUpInside", forControlEvents: UIControlEvents.TouchUpInside)
        contentView!.translatesAutoresizingMaskIntoConstraints = true
        contentView!.frame = scrollView.bounds
   
                scrollView!.contentSize = contentView!.frame.size
        
        scrollView.addSubview(contentView!)
        
        
        
        
       setUpScrollView()
        
     
        
    }
    
    
    //MARK: Targets 
    
    func contentViewTouchUpInside()
    {
        showSelf()
        self.txt_CurrentName?.becomeFirstResponder()
    }
 
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
  
    //MARK: Actions
    
    @IBAction func action_Add(sender: AnyObject)
    {
    
         
         showSelf()
    }
    
    //MARK: TextFieldDelegate
   func textFieldDidBeginEditing(textField: UITextField){
    showSelf()
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        hideSelf()
        return true
    }
    
    func autoTextFieldValueChanged(textFieldTemp: UITextField)
    {
       
        
        let frame : CGRect = (textFieldTemp.window?.subviews[0].convertRect(textFieldTemp.frame, fromView: textFieldTemp.superview))!
        
        self.predictionTableView?.frame = CGRectMake(10, frame.origin.y + frame.size.height, ((self.predictionTableView?.frame.size.width)! - 20), 250);
        
        
        let currentString  = textFieldTemp.text as String!
        
      
        
        if(currentString?.characters.count > 0)
        {
            
            showSelf()
            
            var tempArray :[String] = []
            
            
            self.predictionArray =  (leoDelegate?.leoPredictionArry!())! ?? []
            
            for tempVale : String   in self.predictionArray
            {
                
                
                
                
                let range: NSRange = (tempVale as NSString).rangeOfString(currentString , options: [NSStringCompareOptions.CaseInsensitiveSearch])
                
                
                if(range.length>0)
                {
                    tempArray += [tempVale];
                }
                
            }
            
            
            if(tempArray.count > 0)
            {
                self.predictionArray = tempArray
                
                self.predictionTableView!.reloadData()
            }
            else
            {
                hideSelf()
            }
            
            
        }
        else
        {
            hideSelf()
        }
        
        
    }

    
    
    
    
    
    //MARK:- TableView 
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return predictionArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SenderTableViewCell", forIndexPath: indexPath) as! SenderTableViewCell
        
        leoDelegate?.leoCustomCell(cell, cellForRowAtIndexPath: indexPath, currentArr: predictionArray)
  
        return cell
    
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        
        self.txt_CurrentName?.text = ""
        
        hideSelf()
        
        
        
        if leoDelegate?.leoCustomCelldidSelectRowAtIndexPath?(indexPath, tableViewArray: self.predictionArray, withSearchArray: searchArray) ?? false  == true
        {
            searchArray += ["\(self.predictionArray[indexPath.row])"]
            setUpScrollView()
        }
       else
        {
        searchArray += ["\(self.predictionArray[indexPath.row])"]
        setUpScrollView()
        }
       
        
     
        
 
        
        
    
}


    func setUpScrollView()
    {
         for user : UIView   in (self.contentView?.subviews)!
         {
            user.removeFromSuperview()

        }
   
        var xAxis = 0
        var yAxis = 0
        
        

        
        
        for  (index, element) in searchArray.enumerate()
        
        {
            
            if let customView = NSBundle.mainBundle().loadNibNamed("ChipView", owner: self, options: nil)[0] as? ChipViewControl {
               
                customView.frame = CGRectMake(customView.frame.origin.x + ( CGFloat(index) * customView.frame.width)  , customView.frame.origin.y, customView.frame.width, customView.frame.height)
                
                
                if ((( CGFloat (xAxis) * (customView.frame.size.width + 5)) + customView.frame.size.width) > scrollView.frame.size.width)
                    {
                    yAxis++;
                    
                    xAxis = 0;
                    }
                
                customView.frame = CGRectMake((CGFloat(xAxis) * (customView.frame.size.width + 5)), (CGFloat(yAxis) * (customView.frame.size.height + 5)), customView.frame.size.width, customView.frame.size.height);
              
                xAxis++;

                customView.layoutIfNeeded()
                
          leoDelegate?.leoCustomizeChip(customView, objectIndex: index, withSearchArray: self.searchArray)
                
                customView.anyVarible = index 
                customView.completionHandler =
                    {
                         (anyVarible :AnyObject) -> Void in
                    
                        
                        
                        if let id = anyVarible as? Int
                        {
                          
                            self.searchArray.removeAtIndex(id )
                        }

                        
                        customView.removeFromSuperview()
                         self.setUpScrollView()
                     }
              
                self.contentView?.addSubview(customView)
                
        }
            
        }
        
    
        
               self.txt_CurrentName = UITextField(frame: CGRectMake(0, CGFloat(yAxis) * (30 + 5) + 30, 100, 30 ))
            
                if (((CGFloat(xAxis)  * (txt_CurrentName!.frame.size.width + 5)) + txt_CurrentName!.frame.size.width) > scrollView.frame.size.width)
                {
                yAxis++;
            
            
                xAxis = 0;
            
            
               self.txt_CurrentName!.frame = CGRectMake(0, (CGFloat(yAxis) * (self.txt_CurrentName!.frame.size.height + 5)), scrollView.frame.size.width, 30);
                }
            
            
                self.txt_CurrentName!.frame = CGRectMake((CGFloat(xAxis) * (self.txt_CurrentName!.frame.size.width + 5)), (CGFloat(yAxis) * (self.txt_CurrentName!.frame.size.height + 5)), self.txt_CurrentName!.frame.size.width, self.txt_CurrentName!.frame.size.height);
            
            
        
            
                contentView!.frame = CGRectMake(0, 0, scrollView.frame.size.width/*110 * xAxis*/, 35 * (CGFloat(yAxis) + 1) + self.txt_CurrentName!.frame.size.height);
            
        
                scrollView.contentSize = contentView!.frame.size;
     
        
        
        self.txt_CurrentName?.text = ""
          txt_CurrentName!.autocorrectionType = UITextAutocorrectionType.No;
        self.txt_CurrentName!.addTarget(self, action: "autoTextFieldValueChanged:", forControlEvents: UIControlEvents.EditingChanged)
             self.txt_CurrentName!.delegate = self;
       
        
        self.contentView?.addSubview(self.txt_CurrentName!);
        
         scrollView!.contentSize = contentView!.frame.size
     
        let currrentHeight = ( 60 + (CGFloat(yAxis) * 30) + (CGFloat(yAxis) * 4))
        
        if currrentHeight > maxheight
        {
              leoDelegate?.leoSenderBarUpdateHeightConstaint!(maxheight)
        }
        else{
            leoDelegate?.leoSenderBarUpdateHeightConstaint!(60 + (CGFloat(yAxis) * 30) + (CGFloat(yAxis) * 4))
        }
        
        
        
        
    }


    
    
    
    func showSelf()
    {
       predictionTableView!.hidden = false;
        
        predictionArray = (leoDelegate?.leoPredictionArry!())!
        
        
        predictionTableView?.reloadData()
   
    
    }
    
    func hideSelf()
    {
       predictionTableView!.hidden = true;
      
     }
}
