//
//  BadgeTableViewCell.swift
//  Foot Prints
//
//  Created by Nelson Pierce on 5/2/23.
//

import UIKit

class BadgeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameOfBadge: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func locationPage(_ sender: UIButton) {
        
    }
    
    @IBAction func showLocation(_ sender: UIButton) {
    }
    

}
