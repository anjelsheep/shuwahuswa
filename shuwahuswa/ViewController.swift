//
//  ViewController.swift
//  shuwahuswa
//
//  Created by 志賀翔太 on 2024/09/13.
//

import UIKit
import CoreMotion
import AudioToolbox

class ViewController: UIViewController {
    
    let motionManager = CMMotionManager()
    var shakeCount = 0
    var targetShakeCount: Int = 0
    var isVibrationTriggered = false

    // カウントを表示するラベルを接続
    @IBOutlet weak var shakeCountLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        

        targetShakeCount = Int.random(in: 5...10)
        print("Target shake count: \(targetShakeCount)")
        
        startShakeDetection()
    }
    
    func startShakeDetection() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startAccelerometerUpdates(to: .main) { [weak self] (data, error) in
                if let acceleration = data?.acceleration {
                    if fabs(acceleration.x) > 2.0 || fabs(acceleration.y) > 2.0 || fabs(acceleration.z) > 2.0 {
                        self?.incrementShakeCount()
                        self?.triggerWeakVibration() // 振った際に弱いバイブレーション
                    }
                }
            }
        }
    }
    
    func incrementShakeCount() {
        shakeCount += 1
        shakeCountLabel.text = "Shake count: \(shakeCount)"
        
        if shakeCount >= targetShakeCount && !isVibrationTriggered {
            isVibrationTriggered = true
            triggerVibrationAndTransition()
            motionManager.stopAccelerometerUpdates()
        }
    }
    
    func triggerWeakVibration() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred() // 弱いバイブレーションを発生
    }
    
    func triggerVibrationAndTransition() {
        let vibrationDuration: TimeInterval = 3.0
        let vibrationInterval: TimeInterval = 0.5
        let repeatCount = Int(vibrationDuration / vibrationInterval)
        
        for i in 0..<repeatCount {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * vibrationInterval) {
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            }
        }
        
        transitionToNextScreen()
    }
    
    func transitionToNextScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let nextVC = storyboard.instantiateViewController(withIdentifier: "NextViewController") as? NextViewController {
            nextVC.modalTransitionStyle = .flipHorizontal
            nextVC.modalPresentationStyle = .fullScreen
            present(nextVC, animated: true, completion: nil)
        }
    }
}
