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
    var isVibrationTriggered = false // 一度だけバイブレーションを実行するためのフラグ
    
    let shakeCountLabel: UILabel = {
        let label = UILabel()
        label.text = "Shake count: 0"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(shakeCountLabel)
        
        NSLayoutConstraint.activate([
            shakeCountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shakeCountLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
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
                        self?.createBubble() // 泡の生成
                        self?.triggerWeakVibration() // 振るたびに弱いバイブレーション
                    }
                }
            }
        }
    }
    
    // 振った回数を増やす
    func incrementShakeCount() {
        shakeCount += 1
        shakeCountLabel.text = "Shake count: \(shakeCount)"
        
        // 目標回数に達したかつ、まだバイブレーションを実行していない場合
        if shakeCount >= targetShakeCount && !isVibrationTriggered {
            isVibrationTriggered = true // フラグを立てて二重実行を防ぐ
            triggerVibrationAndTransition() // バイブレーションと画面遷移を実行
        }
    }
    
    // 弱いバイブレーションを振った際に発生させる
    func triggerWeakVibration() {
        let generator = UIImpactFeedbackGenerator(style: .light) // 弱いハプティックフィードバック
        generator.impactOccurred() // バイブレーションを発生
    }
    
    // バイブレーションを3秒間実行し、同時に画面遷移を行う
    func triggerVibrationAndTransition() {
        // 3秒間、0.5秒ごとに振動を繰り返す
        let vibrationDuration: TimeInterval = 3.0
        let vibrationInterval: TimeInterval = 0.5
        let repeatCount = Int(vibrationDuration / vibrationInterval)
        
        for i in 0..<repeatCount {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * vibrationInterval) {
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate) // 強いバイブレーション
            }
        }
        
        // バイブレーション中に画面遷移
        transitionToNextScreen()
    }
    
    // 泡の生成とアニメーション
    func createBubble() {
        let bubbleSize: CGFloat = CGFloat.random(in: 20...50) // 泡の大きさをランダムに設定
        let bubble = UIView()
        bubble.frame = CGRect(x: CGFloat.random(in: 0...view.frame.width - bubbleSize), y: view.frame.height, width: bubbleSize, height: bubbleSize)
        bubble.layer.cornerRadius = bubbleSize / 2
        bubble.backgroundColor = UIColor(red: CGFloat.random(in: 0.7...1), green: CGFloat.random(in: 0.7...1), blue: CGFloat.random(in: 0.7...1), alpha: 0.7)
        
        view.addSubview(bubble)
        
        // アニメーション: 泡を下から上に動かす
        UIView.animate(withDuration: Double.random(in: 2.0...4.0), animations: {
            bubble.frame.origin.y = -bubbleSize
        }, completion: { _ in
            bubble.removeFromSuperview() // アニメーションが終わったら泡を消す
        })
    }
    
    // 画面遷移メソッド
    func transitionToNextScreen() {
        let nextVC = NextViewController() // 次の画面をインスタンス化
        nextVC.modalTransitionStyle = .flipHorizontal // 遷移アニメーションの設定
        present(nextVC, animated: true, completion: nil) // 次の画面へ遷移
    }
}
