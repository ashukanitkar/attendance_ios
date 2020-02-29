//
//  StudentCell.swift
//  AttendanceCoreData
//
//  Created by Asawari Kanitkar on 2/25/20.
//  Copyright © 2020 Asawari Kanitkar. All rights reserved.
//

import UIKit

class StudentCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
