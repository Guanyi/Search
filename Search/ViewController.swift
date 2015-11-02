//
//  ViewController.swift
//  Search
//
//  Created by Guanyi Fang on 2015-11-01.
//  Copyright © 2015 Guanyi Fang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //boolean variable to indicate if there is a seach action or not
    var searchActive: Bool = false
    
    //data
    private let dwarves = ["sleepy", "sneezy", "Bashful", "Happy", "Doc", "Grumpy", "Dopey", "Thorin", "Dorin", "Nori", "Ori", "Barlin", "Dwalin", "Fili", "Kili", "Oin", "Gloin", "Bifur", "Bofur", "Bombur"]
    
    //filtered data array
    var filteredDwarves: [String] = []
    
    let simpleTableIdentifier = "SimpleTableIdentifier"
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchActive) {
            return filteredDwarves.count
        } else {
            return dwarves.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(simpleTableIdentifier)
        
        if (cell == nil) {
            cell = UITableViewCell(style: .Default, reuseIdentifier: simpleTableIdentifier)
        }

        if (searchActive) {
            cell?.textLabel!.text = filteredDwarves[indexPath.row]
        } else {
            cell?.textLabel!.text = dwarves[indexPath.row]
        }
        return cell!
    }
    
    
    //Implemented for UISearchBarDelegate***************************************
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredDwarves = dwarves.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: .CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        
        if (filteredDwarves.count == 0) {
            searchActive = false
        } else {
            searchActive = true
        }
        self.tableView.reloadData()
    }
    
    /*Implement this function for settting scope bar filter. Scope bar buttons are 
      represented by an integer index from 0 , 1, 2 ... GUI view buttom from left to
      right respectively. Update the filtered name list according to scope bar
      constrain, then let the table view reloadData()
    */
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        //if name length is more then 4 characters, it is a long name, otherwise, it is a short name
        switch selectedScope {
        case 0:
            filteredDwarves = dwarves.filter({ (text) -> Bool in
                return text.characters.count > 4
            })
        case 1:
            filteredDwarves = dwarves.filter({ (text) -> Bool in
                return text.characters.count <= 4
            })
        default:
            filteredDwarves = dwarves
        }
        searchActive = true
        self.tableView.reloadData()
    }

    //Implemented for UISearchBarDelegate***************************************


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

