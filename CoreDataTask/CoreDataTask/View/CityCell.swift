//
//  CityCell.swift
//  CoreDataTask
//
//  Created by Snehal Garbhe on 3/21/19.
//  Copyright © 2019 Snehal Garbhe. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {

    @IBOutlet var cityTemp: UILabel!
    @IBOutlet var cityName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
