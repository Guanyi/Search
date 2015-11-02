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
    
    var categorizedDwarves: [String] = []
    
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
            return categorizedDwarves.count
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
            cell?.textLabel!.text = categorizedDwarves[indexPath.row]
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
    
    /*Implement this function for entering search text in the search bar
      This search is not based on the full name list, as we have added scope
      bar. Each text search is based on dwarves' name categories which are
      full name list, long name list and short name list.
    */
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredDwarves = categorizedDwarves.filter({ (text) -> Bool in
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
        case 1:  //long names
            categorizedDwarves = dwarves.filter({ (text) -> Bool in
                return text.characters.count > 4
            })
        case 2:  //short names
            categorizedDwarves = dwarves.filter({ (text) -> Bool in
                return text.characters.count <= 4
            })
        default:  //all names
            categorizedDwarves = dwarves
        }
        
        filteredDwarves = categorizedDwarves
        searchActive = true
        self.tableView.reloadData()
    }

    //Implemented for UISearchBarDelegate***************************************


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        categorizedDwarves = dwarves
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

