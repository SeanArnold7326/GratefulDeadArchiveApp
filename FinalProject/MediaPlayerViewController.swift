//
//  MediaPlayerViewController.swift
//  FinalProject
//
//  Created by Sean on 12/15/19.
//  Copyright © 2019 Sean. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class MediaPlayerViewController: UIViewController {
    
    var mediaPlayer : AVPlayer!
    
    var recording : Recording?
    var selectedFile : Int?
    
    var d1 : String = ""
    var dir : String = ""
    
    var currentlyPlaying : Int?
    
    @IBOutlet weak var navBar: UINavigationItem!

    
    @IBAction func goToPrevious(_ sender: Any) {
        self.previousSong()
    }
    
    @IBAction func playOrPause(_ sender: Any) {
        self.controlPlayback()
    }
    @IBAction func goToNext(_ sender: Any) {
        self.nextSong()
    }
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    
    @IBOutlet weak var playingSlider : UISlider!
    @IBOutlet weak var playingTimer: UILabel!
    @IBOutlet weak var totalTime: UILabel!

    @IBOutlet weak var playingImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        d1 = recording?.getD1() as! String
        dir = recording?.getDir() as! String
        let file = recording?.getFiles()[selectedFile!] as! SongFile
        let fileName = file.getFileName() as String
        let labelText = "\(file.getTrack())      \(file.getTitle())"
        
        totalTime.text = file.getLength() as String
        playingSlider.maximumValue = self.timeToSeconds(time: file.getLength())
        var time = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
        
        playerLabel.text = labelText
        let url = URL(string: "https://\(d1)\(dir)/\(fileName)")
        let nowPlayingCenter = MPNowPlayingInfoCenter.default()
        var playerItem = AVPlayerItem(url: url!)
        mediaPlayer = AVPlayer(playerItem: playerItem)
        navBar.title = "\(recording?.getDate() as! String)"
        venueLabel.text = "\(recording?.getVenue() as! String)"
        
        mediaPlayer?.play()
        currentlyPlaying = selectedFile
        
        NotificationCenter.default.addObserver(self, selector: #selector(didFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        mediaPlayer.pause()
    }
    
    func controlPlayback() {
        if(mediaPlayer.rate != 0) {
            playButton.setTitle("Play", for: .normal)
            mediaPlayer.pause()
        } else {
            playButton.setTitle("Pause", for: .normal)
            mediaPlayer.play()
        }
    }
    
    func previousSong() {
        mediaPlayer.pause()
        mediaPlayer = nil
        if(currentlyPlaying != 0) {
            var newFile = recording?.getFiles()[currentlyPlaying! - 1] as! SongFile
            currentlyPlaying! -= 1
            
            var newFileName = newFile.getFileName()
            let labelText = "\(newFile.getTrack())      \(newFile.getTitle())"
            totalTime.text = newFile.getLength() as String
            playingSlider.maximumValue = self.timeToSeconds(time: newFile.getLength())
            var time = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
            playerLabel.text = labelText
            
            var url = URL(string: "https://\(d1)\(dir)/\(newFileName)")
            var newPlayerItem = AVPlayerItem(url: url!)
            mediaPlayer = AVPlayer(playerItem: newPlayerItem)
            mediaPlayer?.play()
        } else {
            mediaPlayer.seek(to: .zero)
            mediaPlayer.play()
        }
    }
    
    func nextSong() {
        mediaPlayer.pause()
        mediaPlayer = nil
        print(currentlyPlaying)
        print(recording?.getFiles().count)
        if(currentlyPlaying != ((recording?.getFiles().count)!+1)) {
            var newFile = recording?.getFiles()[currentlyPlaying! + 1] as! SongFile
            currentlyPlaying! += 1
            
            var newFileName = newFile.getFileName()
            let labelText = "\(newFile.getTrack())      \(newFile.getTitle())"
            totalTime.text = newFile.getLength() as String
            playingSlider.maximumValue = self.timeToSeconds(time: newFile.getLength())
            var time = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
            playerLabel.text = labelText
            
            var url = URL(string: "https://\(d1)\(dir)/\(newFileName)")
            var newPlayerItem = AVPlayerItem(url: url!)
            mediaPlayer = AVPlayer(playerItem: newPlayerItem)
            mediaPlayer?.play()
        } else {
            mediaPlayer.pause()
            mediaPlayer = nil
        }
    }
    
    func timeToSeconds(time: String) -> Float{
        var timeArray = time.split(separator: ":")
        var minutes = Int(timeArray[0])!
        var seconds = Int(timeArray[1])!
        
        var minutesToSeconds = minutes * 60
        var total = minutesToSeconds + seconds
        return Float(total)
    }
    
    @objc func updateSlider() {
        playingSlider.value = Float(CMTimeGetSeconds(mediaPlayer.currentTime()))
        let (m, s) = secondsToMinutesSeconds(seconds: Int(playingSlider.value))
        let string = "\(m):\(s)"
        playingTimer.text = string
        
    }
    
    @objc func didFinishPlaying() {
        nextSong()
    }
    
    func secondsToMinutesSeconds(seconds: Int) -> (Int, Int) {
        return ((seconds%3600)/60, (seconds%3600)%60)
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
