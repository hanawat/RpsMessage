//
//  SelectViewController.swift
//  RSPMessage
//
//  Created by Hanawa Takuro on 2016/06/25.
//  Copyright © 2016年 Hanawa Takuro. All rights reserved.
//

import UIKit
import Messages
import CoreGraphics

protocol SelectedRps: class {

    func selectedRps(message: MSMessage)
}

class SelectViewController: UIViewController {

    static let identifier = "SelectViewController"

    @IBOutlet weak var rspImageView: UIImageView!
    
    weak var delegate: SelectedRps?
    var message: MSMessage?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillLayoutSubviews() {

        rspImageView.isHidden = message == nil ? true : false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectRock(_ sender: AnyObject) {
        selectRps(rps: .Rock)
    }

    @IBAction func selectPaper(_ sender: AnyObject) {
        selectRps(rps: .Paper)
    }

    @IBAction func selectScissors(_ sender: AnyObject) {
        selectRps(rps: .Scissors)
    }

    func selectRps(rps: Rps) {

        if let message = self.message {

            guard let url = message.url,
                var components = URLComponents(url: url, resolvingAgainstBaseURL: false),
                let queryItems = components.queryItems else {
                    fatalError("Invalid URL components.")
            }

            // TODO: Add localParticipantIdentifier to queryItems
            components.queryItems = queryItems + [URLQueryItem(name: "YourHand", value: rps.rawValue)]
            message.url = components.url

            let layout = MSMessageTemplateLayout()
            let rpsBattle = RpsBattle(message: message)

            UIGraphicsBeginImageContext(CGSize(width: 100, height: 200))
            rpsBattle?.myHand?.image.draw(at: CGPoint())
            rpsBattle?.yourHand?.image.draw(at: CGPoint(x: 0, y: 100))
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            layout.image = image
            layout.caption = "Finish😎"

            message.layout = layout

            delegate?.selectedRps(message: message)

        } else {

            let message = MSMessage(session: MSSession())

            guard let components = NSURLComponents(string: "https://www.rps.com") else {
                fatalError("Invalid base url")
            }

            // TODO: Add localParticipantIdentifier to queryItems
            components.queryItems = [URLQueryItem(name: "MyHand", value: rps.rawValue)]

            guard let url = components.url  else {
                fatalError("Invalid URL components.")
            }

            message.url = url

            let layout = MSMessageTemplateLayout()
            layout.image = UIImage(named: "rps")
            layout.caption = "Start😎"

            message.layout = layout

            delegate?.selectedRps(message: message)
        }
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
