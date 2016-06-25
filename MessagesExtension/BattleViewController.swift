//
//  BattleViewController.swift
//  RSPMessage
//
//  Created by Hanawa Takuro on 2016/06/25.
//  Copyright © 2016年 Hanawa Takuro. All rights reserved.
//

import UIKit
import Messages

class BattleViewController: UIViewController {

    static let identifier = "BattleViewController"

    @IBOutlet weak var yourHandImageView: UIImageView!
    @IBOutlet weak var myHandImageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!

    var rpsBattle = RpsBattle()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillLayoutSubviews() {

        myHandImageView.image = rpsBattle.myHand?.image
        yourHandImageView.image = rpsBattle.yourHand?.image
        resultLabel.text = rpsBattle.result
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
