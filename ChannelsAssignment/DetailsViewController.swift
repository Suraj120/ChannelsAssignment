//
//  DetailsViewController.swift
//  ChannelsAssignment
//
//  Created by Suraj on 13/06/19.
//  Copyright © 2019 Suraj. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var djLabel: UILabel!
    @IBOutlet weak var djEmailLabel: UILabel!
    @IBOutlet weak var listenerLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    
    var channelModel: Channels?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateData()
    }
    
    private func populateData() {
        if let channelModel = channelModel {
            if let image = channelModel.image {
                if let url = URL(string: image) {
                    thumbImageView.af_setImage(withURL: url)
                }
                
            }
            
            
            if let dj = channelModel.dj{
                djLabel.text = "Dj -> \(dj)"
                
            }
            
            if let djmail = channelModel.djmail {
                djEmailLabel.text = "Email -> \(djmail)"
                
            }
            
            if let listeners = channelModel.listeners {
                listenerLabel.text = "Listners -> \(listeners)"
                
            }
            
            if let genre = channelModel.genre {
                genresLabel.text = "Genre -> \(genre)"
                
            }
            
            if let title = channelModel.title {
                titleLabel.text = "Title -> \(title)"
                
            }
            
            
        }
        
        
    }
   
}
