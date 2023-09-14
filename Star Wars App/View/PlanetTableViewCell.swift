//
//  PlanetTableViewCell.swift
//  Star Wars App
//
//  Created by Madushan Senavirathna on 2023-09-14.
//

import UIKit

class PlanetTableViewCell: UITableViewCell {
    @IBOutlet weak var planetName: UILabel!
    @IBOutlet weak var climate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
