//
//  BadgeTableViewCell.swift
//  Foot Prints
//
//  Created by Nelson Pierce on 5/2/23.
//

import UIKit

class BadgeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameOfBadge: UILabel!
    @IBOutlet weak var mapButtonOutlet: UIButton!
        
    override func awakeFromNib() {
        super.awakeFromNib()
                    
    }

    func updateCell(with row: Int) {
        
        mapButtonOutlet.tag = row
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func locationPage(_ sender: UIButton) {
        
    }
    
    @IBAction func showLocation(_ sender: UIButton) {
    }
    

}
