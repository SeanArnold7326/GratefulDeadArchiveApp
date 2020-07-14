//
//  SongsTableViewController.swift
//  FinalProject
//
//  Created by Sean on 12/12/19.
//  Copyright © 2019 Sean. All rights reserved.
//

import UIKit

class SongsTableViewController: UITableViewController {
    
    var recording : Recording?
    var files : [SongFile]?
    
    var selectedFile : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        //print(files)
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
        return files!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = files?[indexPath.row].getTitle() as? String
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.selectedFile = indexPath.row
        performSegue(withIdentifier: "MediaPlayerSegue", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "MediaPlayerSegue") {
            var vc = segue.destination as! MediaPlayerViewController
            vc.selectedFile = self.selectedFile
            vc.recording = self.recording
            
        }
        
    }
    

}
