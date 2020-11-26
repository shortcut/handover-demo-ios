//
//  UserActivities.swift
//  Handover-demo
//
//  Created by Petter Holstad Wright on 19/11/2020.
//

import Foundation
import CoreSpotlight


enum UserActivity {
    case seasonList
    case season(number: Int)
    case episode(season: Int, number: Int)

    init?(nsUserActivity: NSUserActivity) {
        switch nsUserActivity.activityType {
        case "no.shortcut.Handover-demo.seasonList":
            self = UserActivity.seasonList
        case "no.shortcut.Handover-demo.season":
            guard let seasonNumber = nsUserActivity.userInfo?["season"] as? Int else {
                return nil
            }
            self = .season(number: seasonNumber)
        case "no.shortcut.Handover-demo.episode":
            guard let seasonNumber = nsUserActivity.userInfo?["season"] as? Int,
                  let episodeNumber = nsUserActivity.userInfo?["number"] as? Int else {
                return nil
            }
            self = .episode(season: seasonNumber, number: episodeNumber)
        default:
            return nil
        }
    }

    // Remember to reflect info in NSUserActivityTypes in Info.plist
    var id: String {
        switch self {
        case .seasonList:
            return "no.shortcut.Handover-demo.seasonList"
        case .season:
            return "no.shortcut.Handover-demo.season"
        case .episode:
            return "no.shortcut.Handover-demo.episode"
        }
    }

    /// A representation of the state of your app at a moment in time.
    var nsActivity: NSUserActivity {
        let nsActivity = NSUserActivity(activityType: self.id)
        nsActivity.isEligibleForHandoff = true
        nsActivity.isEligibleForSearch = true
        nsActivity.isEligibleForPrediction = true

        // Beware of this!
        nsActivity.isEligibleForPublicIndexing = true

        // For some data this migt be nice to set, if you think the data might disappear at a late point.
        // nsActivity.expirationDate

        switch self {
        case .seasonList:
            nsActivity.webpageURL = URL(string: "https://seinfeld.fandom.com/wiki/Category:Seasons")!
        case .season(let season):
            nsActivity.webpageURL = URL(string: "https://seinfeld.fandom.com/wiki/Season_\(season)")!
            nsActivity.title = "Seinfeld - Season \(season)"
            nsActivity.requiredUserInfoKeys = ["season"]
            nsActivity.userInfo = ["season": season]
        case .episode(let season, let number):
            guard let season = SeinfeldSeason(rawValue: season), let episode = season.episodes.first(where: {$0.numberInSeason == number}) else {
                break
            }
            // This works pretty often, actually!
            let webName = episode.name.replacingOccurrences(of: " ", with: "_")
            nsActivity.webpageURL = URL(string: "https://seinfeld.fandom.com/wiki/\(webName)")!
            nsActivity.requiredUserInfoKeys = ["season", "number"]
            nsActivity.userInfo = ["season": episode.season, "number": episode.numberInSeason]
            nsActivity.title = "Seinfeld - \(episode.name)"

            // Not needed! Just if you'd like to add more data.
            let attributes = CSSearchableItemAttributeSet()
            attributes.title = nsActivity.title
            if let imageData = episode.image?.pngData() {
                attributes.thumbnailData = imageData
            }
            attributes.contentDescription = "Episode \(episode.numberInSeason) in season \(episode.numberInSeason)."
            attributes.keywords = ["Seinfeld", "Jerry", "George", "Elaine", "Kramer"]
            attributes.url = nsActivity.webpageURL

            nsActivity.contentAttributeSet = attributes
        }

        return nsActivity
    }
}
