//
//  GameViewController.swift
//  BarabaraGame
//
//  Created by 松田結衣 on 2022/05/11.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var imgView1: UIImageView! //　上の画像
    @IBOutlet var imgView2: UIImageView! //　真ん中の画像
    @IBOutlet var imgView3: UIImageView! //　下の画像
    
    @IBOutlet var resultLabel: UILabel! //　スコア表示するラベル
    
    var timer: Timer! //　画像を動かすためのタイマー
    var score: Int = 1000 // スコアの値
    let defaults: UserDefaults = UserDefaults.standard // スコアを保存するための変数
    
    let width: CGFloat = UIScreen.main.bounds.size.width // 画面幅
    var positionX: [CGFloat] = [0.0, 0.0, 0.0] // 画像の位置の配列
    var dx: [CGFloat] = [1.0, 0.5, -1.0]  // 画像の動かす幅の配列
    
    func start() {
        // 結果ラベルを見えなくする
        resultLabel.isHidden = true
        
        // タイマーを動かす
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(self.up), userInfo: nil, repeats: true)
        timer.fire()
    }
 
    

    override func viewDidLoad() {
        super.viewDidLoad()
        positionX = [width/2, width/2, width/2] // 画像の位置を中心にする
        self.start() //　startというメソッドを呼び出す
    }
    
    @objc func up() {
        for i in 0..<3 {
            // 端に来たら動かす向きを逆にする
            if positionX[i] > width || positionX[i] < 0 {
                dx[i] = dx[i] * (-1)
            }
            // 画像の位置をdx分ずらす
            positionX[i] += dx[i]
        }
        //　上の画像をずらした位置に移動させる
        imgView1.center.x = positionX[0]
        //　真ん中の画像をずらした位置に移動させる
        imgView2.center.x = positionX[1]
        //　下の画像をずらした位置に移動させる
        imgView3.center.x = positionX[2]
    }
    
    @IBAction func stop() {
        // もしタイマーが動いていたら
        if timer.isValid == true {
            // タイマーを止める（無効にする）
            timer.invalidate()
            
            for i in 0..<3 {
                score = score - abs(Int(width/2 - positionX[i]))*2 // スコアの計算をする
            }
            resultLabel.text = "Score: " + String(score) // スコアを表示する
            resultLabel.isHidden = false // 結果ラベルを隠さない
        }
        
        let highScore1: Int = defaults.integer(forKey: "score1") // ユーザーデフォルトに"score1というキーの値を取得"
        let highScore2: Int = defaults.integer(forKey: "score2")
        let highScore3: Int = defaults.integer(forKey: "score3")
        
        if score > highScore1 {
            defaults.set(score, forKey: "score1")
            defaults.set(highScore1, forKey: "score2")
            defaults.set(highScore2, forKey: "score3")
        } else if score > highScore2 {
            defaults.set(score, forKey: "score2")
            defaults.set(highScore2, forKey: "score3")
        } else if score > highScore3 {
            defaults.set(score, forKey: "score3")
        }
     }
    
    @IBAction func retry(){
            score = 1000 //　スコアの値をリセットする
            positionX = [width/2, width/2, width/2] // 画像の位置を真ん中に戻す
            if timer.isValid == false {
                self.start() // スタートメソッドを呼び出す
            }
    }
    
    @IBAction func toTop() {
        self.dismiss(animated: true, completion: nil)
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
