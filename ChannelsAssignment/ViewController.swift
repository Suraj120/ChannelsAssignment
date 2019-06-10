//
//  ViewController.swift
//  ChannelsAssignment
//
//  Created by Suraj on 10/06/19.
//  Copyright © 2019 Suraj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var channelsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        channelsTable.delegate = self
        channelsTable.dataSource = self
        registerNibs()
    }
    
    func registerNibs() {
      let channelTableViewCellNIB = UINib(nibName: TableCellIdentifier.ChannelTableViewCell, bundle: nil)
        channelsTable.register(channelTableViewCellNIB, forCellReuseIdentifier: TableCellIdentifier.ChannelTableViewCell)
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
