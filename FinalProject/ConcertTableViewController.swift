//
//  ConcertTableViewController.swift
//  FinalProject
//
//  Created by Sean on 12/11/19.
//  Copyright © 2019 Sean. All rights reserved.
//

import UIKit


class ConcertTableViewController: UITableViewController {
    
    var year : String!
    var identifiers : [String] = []
    var recordings : [Recording] = []
    
    var selectedRecording : Recording?
    var selectedFiles : [SongFile]?
    
    @IBOutlet weak var navBar: UINavigationItem!

    var elementName:String = String()
    var elementTitle: String = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.title = year
        print("view loaded")
        let urlString : String = "https://archive.org/advancedsearch.php?q=collection%3AGratefulDead+mediatype%3Aetree+date%3A%5B\(year!)-01-01+TO+\(year!)-12-31%5D&fl%5B%5D=creator&fl%5B%5D=date&fl%5B%5D=description&fl%5B%5D=format&fl%5B%5D=identifier&fl%5B%5D=item_size&fl%5B%5D=mediatype&fl%5B%5D=name&fl%5B%5D=publisher&fl%5B%5D=source&fl%5B%5D=subject&fl%5B%5D=title&fl%5B%5D=type&fl%5B%5D=year&sort%5B%5D=date+asc&sort%5B%5D=avg_rating+desc&sort%5B%5D=&rows=5000&page=1&output=json&save=yes"
        
        guard let url : URL = URL(string: urlString) else { return }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.getYear(url: url) { (data) in
            if let data = data {
                print(" we have data from the function")
                do {
                    if let json = try JSONSerialization.jsonObject(with: data as Data, options: .mutableLeaves) as? [String: Any]{
                        if let firstResponse = json["response"] as? [String: Any] {
                            if let docs = firstResponse["docs"] as? Array<Any> {
                                for i in 0...docs.count-1{
                                    let doc = docs[i] as! NSDictionary
                                    self.getRecordings(identifier: doc["identifier"] as! String)
                                }
                            }
                        }
                    }
                } catch {
                    print(error)
                }
            }
        }
        
//        for i in 0...identifiers.count-1 {
//            self.getConcert(identifier: identifiers[i])
//        }
    }
    
    func getYear(url: URL, completion: @escaping (NSData?) -> ()) {
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let response = response {
                if let data = data {
                    DispatchQueue.main.async {
                        completion(data as NSData)
                    }
                }
            }
        }.resume()
    }
    
    func getRecordings(identifier: String) {
        let newSession = URLSession.shared
        let urlString : URL = URL(string: "https://archive.org/metadata/\(identifier)")!
        
        var identifier : String = ""
        var mediatype : String = ""
        var subject : String = ""
        var concertDescription: String = ""
        var date : String = ""
        var venue : String = ""
        var files : [SongFile] = []
        var d1 : String = ""
        var d2 : String = ""
        var dir : String = ""
        
        newSession.dataTask(with: urlString) { (data, response, error) in
            if let response = response {
                if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                            if(json["d1"] != nil) {
                                d1 = json["d1"] as! String
                            }
                            if(json["dir"] != nil) {
                                dir = json["dir"] as! String
                            }
                            files = self.parseFiles(files: json["files"] as! Array<Any>)
                            let metadata = self.parseMetadata(metadata: json["metadata"] as! NSDictionary)
                            identifier = metadata["identifier"] ?? ""
                            mediatype = metadata["mediatype"] ?? ""
                            subject = metadata["subject"] ?? ""
                            concertDescription = metadata["description"] ?? ""
                            date = metadata["date"] ?? ""
                            venue = metadata["venue"] ?? ""
                            
                            let newRecording = Recording(identifier: identifier, mediatype: mediatype, subject: subject, concertDescription: concertDescription, date: date, venue: venue, files: files, d1: d1, dir: dir)
                            
                            self.recordings.append(newRecording)
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch {
                        print(error)
                    }
                }
            }
        }.resume()
    }
    
    func parseFiles(files: Array<Any>) -> [SongFile]{
        var returnFiles : [SongFile] = []
        for i in 0...files.count-1 {
            let file  = files[i] as! NSDictionary
            if(file["format"] as! String == "VBR MP3") {
                let newFile = SongFile(fileName: file["name"] as? String ?? "",
                                       source: file["source"] as? String ?? "",
                                       title: file["title"] as? String ?? "",
                                       track: file["track"] as? String ?? "",
                                       length: file["length"] as? String ?? "",
                                       format: file["format"] as? String ?? "")
                returnFiles.append(newFile)
            }
        }
        return returnFiles
    }
    
    func parseMetadata(metadata: NSDictionary) -> [String: String] {
        var returnMetadata : [String: String] = [:]
        

        returnMetadata["identifier"] = metadata["identifier"] as? String
        returnMetadata["mediatype"] = metadata["mediatype"] as? String
        returnMetadata["subject"] = metadata["subject"] as? String
        returnMetadata["description"] = metadata["description"] as? String
        returnMetadata["date"] = metadata["date"] as? String
        returnMetadata["venue"] = metadata["venue"] as? String
        
        return returnMetadata
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recordings.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordingCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = recordings[indexPath.row].getDate()

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        selectedRecording = recordings[indexPath.row]
        selectedFiles = selectedRecording?.getFiles()
        performSegue(withIdentifier: "ToSongsView", sender: self)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "ToSongsView"){
            var vc = segue.destination as! SongsTableViewController
            vc.recording = selectedRecording
            vc.files = selectedFiles
        }
    }
    

}
