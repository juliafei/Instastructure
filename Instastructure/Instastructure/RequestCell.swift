//
//  RequestCell.swift
//  Instastructure
//
//  Created by Joel Annenberg on 3/29/16.
//  Copyright © 2016 Joel A. All rights reserved.
//

import UIKit
import Parse
import AFNetworking

class RequestCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var voteCountLabel: UILabel!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    
    var request: PFObject! {
        didSet {
            titleLabel.text = request["title"] as? String
            descriptionLabel.text = request["description"] as? String
            timeLabel.text = "" //figure out
            voteCountLabel.text = request["voteCount"] as? String
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
