//
//  MusicPlayerCell.swift
//  MusicApp
//
//  Created by Lauv Edward on 10/08/2021.
//

import UIKit

class MusicPlayerCell: UITableViewCell {

    @IBOutlet weak var labelMusicDescription: UILabel!
    @IBOutlet weak var labelMusicTitle: UILabel!
    @IBOutlet weak var imageMusic: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
