//
//  EpisodeViewController.swift
//  Handover-demo
//
//  Created by Petter Holstad Wright on 19/11/2020.
//

import UIKit

class EpisodeViewController: UIViewController {

    var episode: Episode!

    @IBOutlet weak var seasonAndEpisodeLabel: UILabel!
    @IBOutlet weak var writersLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var airdateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        userActivity = UserActivity.episode(season: episode.season, number: episode.numberInSeason).nsActivity
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        userActivity?.invalidate()
    }

    func configureUI() {
        title = episode.name
        seasonAndEpisodeLabel.text = "Season \(episode.season) - Episode \(episode.numberInSeason) - Total episode \(episode.totalNumber)"
        writersLabel.text = "Writers: \(episode.writersText)"
        directorLabel.text = "Director: \(episode.director)"
        airdateLabel.text = "Aired: \(episode.originalAirDateText)"
        if let description = episode.description {
            descriptionLabel.text = description
        } else {
            descriptionLabel.removeFromSuperview()
        }
    }

    static func createFromStoryboard(withEpisode episode: Episode) -> EpisodeViewController {
        let storyboard = UIStoryboard(name: "Episode", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EpisodeViewController") as! EpisodeViewController
        vc.episode = episode
        return vc
    }
}
