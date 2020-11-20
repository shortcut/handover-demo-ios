//
//  SeasonViewController.swift
//  Handover-demo
//
//  Created by Petter Holstad Wright on 19/11/2020.
//

import UIKit

class SeasonViewController: UIViewController {

    var season: SeinfeldSeason!

    override func viewDidLoad() {
        super.viewDidLoad()
        let tableView = UITableView(frame: self.view.frame)
        self.view.addSubview(tableView)
        tableView.dataSource =  self
        tableView.delegate = self
        title = "Season \(season.rawValue)"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        userActivity = UserActivity.season(number: season.rawValue).nsActivity
    }

    override func viewWillDisappear(_ animated: Bool) {
        userActivity?.invalidate()
    }

    func showEpisodeView(_ episode: Episode) {
        let episodeVC = EpisodeViewController.createFromStoryboard(withEpisode: episode)
        self.navigationController?.pushViewController(episodeVC, animated: true)
    }
}

extension SeasonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return season.episodes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let episode = season.episodes[indexPath.row]
        cell.textLabel?.text = episode.name
        return cell
    }
}

extension SeasonViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let episode = season.episodes[indexPath.row]
        showEpisodeView(episode)
    }
}
