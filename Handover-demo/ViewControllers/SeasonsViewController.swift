//
//  ViewController.swift
//  Handover-demo
//
//  Created by Petter Holstad Wright on 19/11/2020.
//

import UIKit

class SeasonsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        title = "Seinfeld"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        userActivity = UserActivity.seasonList.nsActivity
    }

    override func viewWillDisappear(_ animated: Bool) {
        userActivity?.invalidate()
    }

    func showSeason(_ season: SeinfeldSeason, animated: Bool = true) {
        let seasonVC = SeasonViewController()
        seasonVC.season = season
        self.navigationController?.pushViewController(seasonVC, animated: animated)
    }
}

extension SeasonsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SeinfeldSeason.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let season = SeinfeldSeason.allCases[indexPath.row]
        cell.textLabel?.text = "Sesong \(season.rawValue)"
        return cell
    }
}

extension SeasonsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let season = SeinfeldSeason.allCases[indexPath.row]
        showSeason(season)
    }
}
