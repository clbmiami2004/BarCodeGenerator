//
//  ImagesTableViewCell.swift
//  BarCodeGenerator
//
//  Created by Christian Lorenzo on 4/20/22.
//

import UIKit

class ImagesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myIMagesViewOutlet: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
