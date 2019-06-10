//
//  ChannelsTableViewCell.swift
//  ChannelsAssignment
//
//  Created by Suraj on 10/06/19.
//  Copyright © 2019 Suraj. All rights reserved.
//
import UIKit

class Utility: NSObject {
    
    //MARK: - Static(Class) Methods
    
    static func createAlertWithoutAction(message: String, title: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle:.alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        alert.addAction(okAction)
        return alert
    }
    

    
}
