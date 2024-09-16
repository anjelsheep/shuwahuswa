//
//  StartViewController.swift
//  shuwahuswa
//
//  Created by 志賀翔太 on 2024/09/16.
//

import UIKit

class StartViewController: UIViewController {

    // Storyboard上のスタートボタンを接続する
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // ここでUIの初期設定を行うことも可能です
    }

    // スタートボタンを押したときに呼ばれるアクション
    @IBAction func startButtonTapped(_ sender: UIButton) {
        let gameVC = ViewController() // ゲームのViewControllerに遷移
        gameVC.modalTransitionStyle = .flipHorizontal // アニメーション効果を追加
        present(gameVC, animated: true, completion: nil) // 画面遷移
    }
}
