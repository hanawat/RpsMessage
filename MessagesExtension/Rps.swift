//
//  Rps.swift
//  RSPMessage
//
//  Created by Hanawa Takuro on 2016/06/25.
//  Copyright © 2016年 Hanawa Takuro. All rights reserved.
//

import Foundation
import Messages

enum Rps: String {

    case Rock = "rock"
    case Paper = "paper"
    case Scissors = "scissors"

    static let face = (loser: "😭", sober: "😐", winner: "😎")

    var image: UIImage {
        switch self {
        case .Rock:
            return UIImage(named: "rock")!
        case .Paper:
            return UIImage(named: "paper")!
        case .Scissors:
            return UIImage(named: "scissors")!
        }
    }

    var hand: String {
        switch self {
        case .Rock:
            return "👊"
        case .Paper:
            return "✋"
        case .Scissors:
            return "✌️"
        }
    }

    // A method can define Swift enum.
    func duel(rps: Rps) -> String {
        switch (self, rps) {
        case (Rock, Scissors), (Paper, Rock), (Scissors, Paper):
            return self.hand + Rps.face.winner + " < Win!"
        case (Rock, Paper), (Paper, Scissors), (Scissors, Rock):
            return self.hand + Rps.face.loser + " < Lose..."
        default:
            return self.hand + Rps.face.sober + " < Sober."
        }
    }
}

struct RpsBattle {

    var myHand: Rps?
    var yourHand: Rps?

    var canBattle: Bool {
        return self.myHand != nil && self.yourHand != nil
    }

    var result: String? {

        guard let myHand = self.myHand,
            yourHand = self.yourHand else { return nil }

        return myHand.duel(rps: yourHand)
    }
}

extension RpsBattle {

    init?(message: MSMessage?) {

        guard let messageURL = message?.url,
            urlComponents = NSURLComponents(url: messageURL, resolvingAgainstBaseURL: false),
            queryItems = urlComponents.queryItems else { return nil }

        queryItems.forEach { queryItem in

            switch queryItem.name {
            case "MyHand":
                guard let value = queryItem.value,
                    myHand = Rps(rawValue: value) else { return }

                self.myHand = myHand

            case "YourHand":
                guard let value = queryItem.value,
                    yourHand = Rps(rawValue: value) else { return }

                self.yourHand = yourHand

            default:
                return
            }
        }
    }
}
