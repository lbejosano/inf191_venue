//
//  ViewController.swift
//  venueapp
//
//  Created by Max Kirchgesner on 5/24/17.
//  Copyright © 2017 venue. All rights reserved.
//

import UIKit
import Speech

class ViewController: UIViewController, SFSpeechRecognizerDelegate  {
    
    // MARK: Variables
    private let sr = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))!
    private var sabrr: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    
    // MARK: Outlets/Actions
    @IBOutlet weak var micbutton: UIButton!
    @IBOutlet weak var textview: UITextView! {
        didSet {
            textview.layer.borderColor = UIColor.black.cgColor
            textview.layer.borderWidth = 1
            textview.layer.cornerRadius = 6
        }
    }
    @IBOutlet weak var pressmiclabel: UILabel!
    @IBOutlet weak var nextpagebutton: UIButton! {
        didSet {
            nextpagebutton.layer.borderColor = UIColor.black.cgColor
            nextpagebutton.layer.borderWidth = 1
            nextpagebutton.layer.cornerRadius = 6
        }
    }
    @IBOutlet weak var whattosearchforlabel: UILabel!
    
    @IBAction func mictapped(_ sender: Any) {
        if audioEngine.isRunning {
            audioEngine.stop()
            sabrr?.endAudio()
            micbutton.isEnabled = false
        } else {
            startRecording()
        }
    }

    // MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        micbutton.isEnabled = false
        
        sr.delegate = self
        
        
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            
            var isButtonEnabled = false
            
            switch authStatus {
            case .authorized:
                isButtonEnabled = true
                print("Successful authorization")
            case .denied:
                isButtonEnabled = false
                print("User has denied access to speech recognition")
                
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition is restricted on this device")
                
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition is not authorized")
            }
            
            OperationQueue.main.addOperation() {
                self.micbutton.isEnabled = isButtonEnabled
            }
        }
    }
    
    @IBAction func microphoneTapped(_ sender: AnyObject) {
        if audioEngine.isRunning {
            audioEngine.stop()
            print("IN HERE")
            sabrr?.endAudio()
            micbutton.isEnabled = false
            micbutton.setTitle("Start Recording", for: .normal)
        } else {
            startRecording()
            micbutton.setTitle("Stop Recording", for: .normal)
        }
    }
    
    func startRecording() {
        
        if recognitionTask != nil {  //1
            recognitionTask?.cancel()
            recognitionTask = nil
            print("IN recog task")
        }
        
        let audioSession = AVAudioSession.sharedInstance()  //2
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        
        sabrr = SFSpeechAudioBufferRecognitionRequest()  //3
        
        guard let inputNode = audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
        }  //4
        
        guard let recognitionRequest = sabrr else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        } //5
        
        sabrr?.shouldReportPartialResults = true  //6
        
        recognitionTask = sr.recognitionTask(with: sabrr!, resultHandler: { (result, error) in  //7
            
            var isFinal = false  //8
            
            if result != nil {
                print("DOG1")
                self.textview.text = result?.bestTranscription.formattedString  //9
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {  //10
                //                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                //                self.recognitionRequest = nil
                self.recognitionTask = nil
                self.cancelRecording()
                
                self.micbutton.isEnabled = true
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)  //11
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.sabrr?.append(buffer)
        }
        
        audioEngine.prepare()  //12
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
        textview.text = "Say something, I'm listening!"
        
    }
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        micbutton.isEnabled = available
    }
    
    func cancelRecording() {
        audioEngine.stop()
        sabrr?.endAudio()
        recognitionTask?.cancel()
    }



}

