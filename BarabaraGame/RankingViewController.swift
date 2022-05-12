//
//  RankingViewController.swift
//  BarabaraGame
//
//  Created by 松田結衣 on 2022/05/11.
//

import UIKit

class RankingViewController: UIViewController {
    
    @IBOutlet var rankingLevel1: UILabel! // 1位を表示
    @IBOutlet var rankingLevel2: UILabel!
    @IBOutlet var rankingLevel3: UILabel!
    
    let defaults: UserDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // score1というキーの値を取得して表示
        rankingLevel1.text = String(defaults.integer(forKey: "score1"))
        rankingLevel2.text = String(defaults.integer(forKey: "score2"))
        rankingLevel3.text = String(defaults.integer(forKey: "score3"))
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
