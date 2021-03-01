//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Gozde Kardas on 20.02.2021.
//  Copyright © 2021 Gozde Kardas. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController , AVAudioRecorderDelegate{
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI(recording: false)
        
    }
    
    @IBAction func recordAudio(_ sender: Any) {
        
        setUI(recording: true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        //print(filePath)
        print(1)
        let session = AVAudioSession.sharedInstance()
        print(2)
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        print(3)
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        print(4)
        audioRecorder.delegate = self
        print(5)
        audioRecorder.isMeteringEnabled = true
        print(6)
        audioRecorder.prepareToRecord()
        print(7)
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        setUI(recording: false)
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool)
    {
        if flag{
            
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)}
        else {
            print("recording was not successfull")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "stopRecording"{
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL =
            recordedAudioURL
        }
    }
    
    func setUI(recording: Bool) {
        if(recording==true){
            stopRecordingButton.isEnabled = true
            recordButton.isEnabled = false
            recordingLabel.text = "Recording in Progress"
        }else{
            stopRecordingButton.isEnabled = false
            recordButton.isEnabled = true
            recordingLabel.text = "Tap to Record"
        }
        
        
    }
    
}

