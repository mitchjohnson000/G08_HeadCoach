//
//  HCGameResult.swift
//  HeadCoach
//
//  Created by Ian Malerich on 4/7/16.
//  Copyright © 2016 Group08. All rights reserved.
//

import UIKit

class HCGameResult: CustomStringConvertible {

    /// Primary key for this HCGameResult, this will probably never be needed.
    internal var id = 0

    /// Tuple containing the two user ID's involved in this game.
    internal var users = (HCUser(), HCUser())

    /// Tuple containing the scores of each player in this match.
    /// The ordering of the scores corresponds to the ordering of
    /// the data in the 'users' property.
    internal var scores = (0, 0)

    /// The week number for this game.
    /// Possible value for this value are as follows:
    ///     0 - Pre Season
    ///     [1-17] - Regular Season
    internal var week = 0

    /// Whether or not this game is completed or not.
    /// If it is not completed the scores will be 0 and
    /// should not be shown to the user. In the current 
    /// implementation of the API, this value will 
    /// always be 'true' for a valid HCGameResult.
    internal var completed = false

    /// String conversion for debug printing.
    var description: String {
        return "{\nid: \(id)\nusers: \(users)\nscores: \(scores)\nweek: \(week)" +
            "\ncompleted: \(completed)\n}\n"
    }

    /// Initializes an HCGameResult with data returned
    /// by the HeadCoach API.
    init(json: Dictionary<String, AnyObject>) {
        let score0 = Int(json["score_0"] as! String)!
        let score1 = Int(json["score_1"] as! String)!

        id = Int(json["id"] as! String)!
        scores = (score0, score1)
        week = Int(json["week"] as! String)!
        completed = Int(json["completed"] as! String)! == 1

        let user0 = json["user_0"] as! Dictionary<String, String>
        let user1 = json["user_1"] as! Dictionary<String, String>

        users = (HCUser(json: user0), HCUser(json: user1))
    }

    /// Creates an empty game result, any API call will fail
    /// with this HCGameResult
    init() { }
}
