//
//  SongFile.swift
//  FinalProject
//
//  Created by Sean on 12/12/19.
//  Copyright © 2019 Sean. All rights reserved.
//

import Foundation
class SongFile : NSObject, NSCoding {
    func encode(with coder: NSCoder) {
        coder.encode(fileName, forKey: "fileName")
        coder.encode(source, forKey: "source")
        coder.encode(title, forKey: "title")
        coder.encode(track, forKey: "track")
        coder.encode(length, forKey: "length")
        coder.encode(format, forKey: "format")
    }
    
    private var fileName : String = ""
    private var source : String = ""
    private var title : String = ""
    private var track : String = ""
    private var length : String = ""
    private var format : String = ""
    
    init(fileName: String, source: String, title: String, track: String, length: String, format: String) {
        super.init()
        self.set(newFilename: fileName)
        self.set(newSource: source)
        self.set(newTitle: title)
        self.set(newTrack: track)
        self.set(newLength: length)
        self.set(newFormat: format)
    }
    
    required init?(coder: NSCoder) {
        super.init()
        self.set(newFilename: coder.decodeObject(forKey: "fileName") as! String)
        self.set(newSource: coder.decodeObject(forKey: "source") as! String)
        self.set(newTitle: coder.decodeObject(forKey: "title") as! String)
        self.set(newTrack: coder.decodeObject(forKey: "track") as! String)
        self.set(newLength: coder.decodeObject(forKey: "length") as! String)
        self.set(newFormat: coder.decodeObject(forKey: "format") as! String)
    }
    
    override convenience init() {
        self.init(fileName: "Unknown", source: "Unknown", title: "Unknown", track: "Unknown", length: "Unknown", format: "Unknown")
    }
    
    func getFileName() -> String { return fileName }
    func getSource() -> String { return source }
    func getTitle() -> String { return title }
    func getTrack() -> String { return track }
    func getLength() -> String { return length }
    func getFormat() -> String { return format }

    func set(newFilename: String) {
        fileName = newFilename
    }
    
    func set(newSource: String) {
        source = newSource
    }
    
    func set(newTitle: String) {
        title = newTitle
    }
    
    func set(newTrack: String) {
        track = newTrack
    }
    
    func set(newLength: String) {
        length = newLength
    }
    
    func set(newFormat: String) {
        format = newFormat
    }
}
