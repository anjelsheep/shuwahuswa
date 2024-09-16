//
//  NextViewController.swift  .swift
//  shuwahuswa
//
//  Created by 志賀翔太 on 2024/09/15.
//

import UIKit

class NextViewController: UIViewController {

    // ボタンを接続するための @IBOutlet
    @IBOutlet weak var backButton: UIButton! // スタート画面に戻るボタン
    @IBOutlet weak var retryButton: UIButton! // もう一度カウントをやり直すボタン

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // スタート画面に戻るボタンを押したときのアクション
    @IBAction func backButtonTapped(_ sender: UIButton) {
        // スタート画面に戻る
        dismiss(animated: true, completion: nil)
    }

    // もう一度カウントをやり直すボタンを押したときのアクション
    @IBAction func retryButtonTapped(_ sender: UIButton) {
        // カウントを初めからやり直すために ViewController に戻る
        let gameVC = ViewController() // ViewControllerをインスタンス化
        gameVC.modalTransitionStyle = .flipHorizontal // アニメーション効果
        present(gameVC, animated: true, completion: nil)
    }
}


