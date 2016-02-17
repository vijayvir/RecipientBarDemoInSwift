//
//  SenderTableViewCell.swift
//  SenderNameBarInSwift
//
//  Created by OSX on 16/02/16.
//  Copyright © 2016 Vijayvir. All rights reserved.
//

import UIKit

class SenderTableViewCell: UITableViewCell {

    //MARK:- IBOUTs
    
    @IBOutlet weak var lbl_Name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    
    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)


    }
    
}
