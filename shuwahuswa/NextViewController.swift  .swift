//
//  NextViewController.swift  .swift
//  shuwahuswa
//
//  Created by 志賀翔太 on 2024/09/15.
//

import UIKit

class NextViewController: UIViewController {

    // スタート画面に戻るボタンと、もう一度カウントをやり直すボタン
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var retryButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // スタート画面に戻るボタン
    @IBAction func backButtonTapped(_ sender: UIButton) {
        // スタート画面に戻る
        if let navigationController = presentingViewController?.presentingViewController as? UINavigationController {
            navigationController.dismiss(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }

    // もう一度カウントをやり直すボタン
    @IBAction func retryButtonTapped(_ sender: UIButton) {
        // カウントアプリを最初から始めるために ViewController へ戻る
        if let navigationController = presentingViewController as? UINavigationController {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
}




