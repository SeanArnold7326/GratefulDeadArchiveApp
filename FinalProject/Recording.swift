//
//  Recording.swift
//  FinalProject
//
//  Created by Sean on 12/11/19.
//  Copyright © 2019 Sean. All rights reserved.
//

import Foundation


class Recording : NSObject, NSCoding {
    func encode(with coder: NSCoder) {
        coder.encode(identifier, forKey: "identifier")
        coder.encode(mediatype, forKey: "mediatype")
        coder.encode(subject, forKey: "subject")
        coder.encode(concertDescription, forKey: "concertDescription")
        coder.encode(date, forKey: "date")
        coder.encode(venue, forKey: "venue")
        coder.encode(files, forKey: "files")
        coder.encode(d1, forKey: "d1")
        coder.encode(dir, forKey: "dir")
    }
    
    private var identifier : String = ""
    private var mediatype : String = ""
    private var subject : String = ""
    private var concertDescription: String = ""
    private var date : String = ""
    private var venue : String = ""
    private var files : [SongFile] = []
    private var d1 : String = ""
    private var dir : String = ""
    
    init(identifier: String, mediatype: String, subject: String, concertDescription: String, date: String, venue: String, files: [SongFile], d1: String, dir: String) {
        super.init()
        self.set(newIdentifier: identifier)
        self.set(newMediatype: mediatype)
        self.set(newSubject: subject)
        self.set(newDesc: concertDescription)
        self.set(newDate: date)
        self.set(newVenue: venue)
        self.set(newFiles: files)
        self.set(newD1: d1)
        self.set(newDir: dir)
    }
    
    required init?(coder: NSCoder) {
        super.init()
        self.set(newIdentifier: coder.decodeObject(forKey: "identifier") as! String)
        self.set(newMediatype: coder.decodeObject(forKey: "mediaType") as! String)
        self.set(newSubject: coder.decodeObject(forKey: "subject") as! String)
        self.set(newDesc: coder.decodeObject(forKey: "description") as! String)
        self.set(newDate: coder.decodeObject(forKey: "date") as! String)
        self.set(newVenue: coder.decodeObject(forKey: "venue") as! String)
        self.set(newFiles: coder.decodeObject(forKey: "files") as! [SongFile])
        self.set(newD1: coder.decodeObject(forKey: "d1") as! String)
        self.set(newDir: coder.decodeObject(forKey: "dir") as! String)
    }
    
    override convenience init() {
        self.init(identifier: "Unknown", mediatype: "Unknown", subject: "Unknown", concertDescription: "Unknown", date: "Unknown", venue: "Unknown", files: [], d1: "Unknown", dir: "Unknown")
    }
    
    func getIdentifier() -> String { return identifier }
    func getSubject() -> String { return subject }
    func getMediatype() -> String { return mediatype }
    func getDescription() -> String { return concertDescription }
    func getDate() -> String { return date }
    func getVenue() -> String { return venue }
    func getFiles() -> [SongFile] { return files }
    func getD1() -> String { return d1 }
    func getDir() -> String { return dir }
    
    func set(newIdentifier: String) {
        identifier = newIdentifier
    }
    
    func set(newSubject: String) {
        subject = newSubject
    }
    
    func set(newMediatype: String) {
        mediatype = newMediatype
    }
    
    func set(newDesc: String) {
        concertDescription = newDesc
    }
    
    func set(newDate: String) {
        date = newDate
    }
    func set(newVenue: String) {
        venue = newVenue
    }
    
    func set(newFiles: [SongFile]) {
        files = newFiles
    }
    func set(newD1: String) {
        d1 = newD1
    }
    
    
    func set(newDir: String) {
        dir = newDir
    }
}
