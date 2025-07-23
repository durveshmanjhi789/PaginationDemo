//
//  UserCell.swift
//  PaginationDemo
//
//  Created by Durvesh Manjhi on 22/07/25.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameTxt: UILabel!
    @IBOutlet weak var emailTxt: UILabel!
    @IBOutlet weak var shopBtn: UIButton!
    @IBOutlet weak var dobTxt: UILabel!
    @IBOutlet weak var ageTxt: UILabel!
    @IBOutlet weak var childView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImg.clipsToBounds = true
        profileImg.layer.cornerRadius = 5
        shopBtn.clipsToBounds = true
        shopBtn.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with user: User) {
        nameTxt.text = "Name: \(user.name)"
        emailTxt.text = "Email:" + user.email
        dobTxt.text = "DOB:" + user.dob
        ageTxt.text = "Age: \(user.age)"
        
        if let url = URL(string: user.image) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.profileImg.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}
