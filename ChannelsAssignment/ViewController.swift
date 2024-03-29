//
//  ViewController.swift
//  ChannelsAssignment
//
//  Created by Suraj on 10/06/19.
//  Copyright © 2019 Suraj. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController {

    @IBOutlet weak var channelsTable: UITableView!
    let url = "https://raw.githubusercontent.com/jvanaria/jvanaria.github.io/master/channels.json"
    var channelModelArray = [Channels]()
    var searchResultsArray = [Channels]()
    var resultSearchController = UISearchController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = TitleConstants.ViewControllerTitle
        channelsTable.delegate = self
        channelsTable.dataSource = self
        
        registerNibs()
        getDataFromWebServices()
        setUpSearchController()
        
        
    }
    
    func registerNibs() {
        
      let channelTableViewCellNIB = UINib(nibName: TableCellIdentifier.ChannelTableViewCell, bundle: nil)
        channelsTable.register(channelTableViewCellNIB, forCellReuseIdentifier: TableCellIdentifier.ChannelTableViewCell)
        
    }
    
    func getDataFromWebServices(){
        Alamofire.request(url).responseData { (data) in
            if data.result.isSuccess {
                print(data.result.description)
                guard let data = data.data else { return }
                do {
                    
                    let channel = try JSONDecoder().decode(ChannelsModel.self, from: data)
                    self.channelModelArray = channel.channels
                } catch {
                    fatalError()
                }
            } else {
                let errorAlert  = Utility.createAlertWithoutAction(message: "Error in fetching the data!!!", title: "Error")
                self.present(errorAlert, animated: true, completion: nil)
            }
            
            self.channelsTable.reloadData()
        }
    }

    func setUpSearchController() {
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            controller.searchBar.barStyle = UIBarStyle.black
            controller.searchBar.barTintColor = UIColor.white
            controller.searchBar.backgroundColor = UIColor.clear
            self.channelsTable.tableHeaderView = controller.searchBar
            return controller
            }
        )()
        
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if resultSearchController.isActive && resultSearchController.searchBar.text != "" {
            return searchResultsArray.count
        } else {
            return channelModelArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifier.ChannelTableViewCell, for: indexPath) as? ChannelsTableViewCell
            else {
            fatalError()
        }
        
        if resultSearchController.isActive && resultSearchController.searchBar.text != "" {
            cell.title.text = searchResultsArray[indexPath.row].title
            cell.titleDesc.text = searchResultsArray[indexPath.row].description
            cell.djName.text = searchResultsArray[indexPath.row].dj
            let image = searchResultsArray[indexPath.row].image
            if let url = URL(string: image!) {
                cell.channelsImg.af_setImage(withURL: url)
            }
            return cell
            
        } else {
            cell.title.text = channelModelArray[indexPath.row].title
            cell.titleDesc.text = channelModelArray[indexPath.row].description
            cell.djName.text = channelModelArray[indexPath.row].dj
            let image = channelModelArray[indexPath.row].image
            if let url = URL(string: image!) {
                cell.channelsImg.af_setImage(withURL: url)
            }
            return cell
        }
      // return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController {
            if resultSearchController.isActive && resultSearchController.searchBar.text != "" {
                detailsVC.channelModel = searchResultsArray[indexPath.row]
            } else {
                detailsVC.channelModel = channelModelArray[indexPath.row]
            }
            resultSearchController.isActive = false
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
}
extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.searchResultsArray = self.channelModelArray.filter {
           // ($0.dj.contains(searchController.searchBar.text!))
            ($0.description!.contains(searchController.searchBar.text!))
        }
        self.channelsTable.reloadData()
    }
}
