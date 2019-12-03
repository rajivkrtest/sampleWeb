//
//  CustomTableViewCell.swift
//  SamplePract1
//
//  Created by APPLE on 03/12/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var imageTitle : UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setupData( data: Employee) {
        lblTitle.text = data.employee_name
        DispatchQueue.global(qos: .userInitiated).async {
            if let profileImage = data.profile_image {
                 let url = URL(string: profileImage)
                let data = try? Data.init(contentsOf: url!)
                if data != nil {
                   let image = UIImage(data: data!)
                    DispatchQueue.main.async{
                    self.imageTitle.image = image
                    }
                }
                
            }
           
            
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
