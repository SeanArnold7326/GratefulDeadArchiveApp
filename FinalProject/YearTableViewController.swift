//
//  YearTableViewController.swift
//  FinalProject
//
//  Created by Sean on 12/11/19.
//  Copyright © 2019 Sean. All rights reserved.
//

import UIKit

class YearTableViewController: UITableViewController {

    var yearsList = ["1965", "1966", "1967", "1968", "1969", "1970",
                    "1971", "1972", "1973", "1974", "1975", "1976",
                    "1977", "1978", "1979", "1980", "1981", "1982",
                    "1983", "1984", "1985", "1986", "1987", "1988",
                    "1989", "1990", "1991", "1992", "1993", "1994", "1995"]
    
    var selectedYear : String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return yearsList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YearCell", for: indexPath)

        cell.textLabel?.text = yearsList[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        selectedYear = yearsList[indexPath.row] as! String
        performSegue(withIdentifier: "toConcertYearView", sender: self)
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "toConcertYearView") {
            var vc = segue.destination as! ConcertTableViewController
            vc.year = selectedYear
        }
    }
    

}
