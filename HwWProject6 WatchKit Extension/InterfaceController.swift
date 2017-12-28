//
//  InterfaceController.swift
//  HwWProject6 WatchKit Extension
//
//  Created by Skyler Svendsen on 12/28/17.
//  Copyright © 2017 Skyler Svendsen. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    @IBOutlet var image: WKInterfaceImage!
    
    @IBAction func multiInputTapped() {
        presentTextInputController(withSuggestions: ["Hacking with Swift", "Hacking with macOS", "Server-Side Swift"], allowedInputMode: .allowAnimatedEmoji) { result in
            if let result = result?.first as? String {
                print(result)
            } else if let result = result?.first as? Data {
                guard let imageData = UIImage(data: result) else { return }
                self.image.setImage(imageData)
            }
        }
    }
    
    @IBAction func recordingTapped() {
        let saveURL = getDocumentsDirectory().appendingPathComponent("recording.wav")
        
        if FileManager.default.fileExists(atPath: saveURL.path) {
            let options = [WKMediaPlayerControllerOptionsAutoplayKey: "true"]
            
            presentMediaPlayerController(with: saveURL, options: options) { didPlayToEnd, endtime, error in
                //do nothing here
            }
        } else {
            let options: [String: Any] = [WKAudioRecorderControllerOptionsMaximumDurationKey : 60, WKAudioRecorderControllerOptionsActionTitleKey: "Done"]
            
            presentAudioRecorderController(withOutputURL: saveURL, preset: .narrowBandSpeech, options: options) { success, error in
                if success {
                    print("Saved succesfully!")
                } else {
                    print(error?.localizedDescription ?? "Unknown error")
                }
            }
        }
        
       
    }
    
    @IBAction func dictateTapped() {
        presentTextInputController(withSuggestions: nil, allowedInputMode: .plain) { result in
            guard let result = result?.first as? String else { return }
            print(result)
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
