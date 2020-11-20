//
//  SeinfeldService.swift
//  Handover-demo
//
//  Created by Petter Holstad Wright on 19/11/2020.
//

import Foundation

enum SeinfeldSeason: Int, CaseIterable {
    case first = 1, second, third, fourth, sixth, sventh, eight, nine
    var episodes: [Episode] {
        switch self.rawValue {
        case 1:
            return [
                Episode(season: 1, numberInSeason: 1, totalNumber: 1, name: "The Seinfeld Chronicles", director: "Art Wolff", writers: ["Larry David", "Jerry Seinfeld"], originalAirDate: Date(day: 5, month: 6, year: 1989), description: "The series opens with Jerry Seinfeld (Jerry Seinfeld) and George Costanza (Jason Alexander) seated at Pete's Luncheonette, debating the placement of one of George's shirt buttons. Jerry tells George about a woman he met in Lansing, Michigan, Laura (Pamela Brull), who is coming to New York, and the two discuss whether or not she has romantic intentions. The next evening, Jerry tells his neighbor Kessler (Michael Richards) that he thinks he misunderstood the situation with Laura. However, he then receives a telephone call from Laura, who asks if she can stay overnight at his apartment. Though Jerry agrees, he is still unsure whether or not her visit is intended to be romantic. George and Jerry continue to debate the issue, with Jerry determined to find the true nature of her visit.\nWhile waiting at the airport for Laura to arrive, Jerry and George try to identify the possible signals Laura might give upon her arrival, with George explaining the meaning of various greetings. However, when Laura arrives, her greeting is ambiguous. Upon arriving at Jerry's apartment Laura removes her shoes and some excess clothing to get comfortable, asks for wine, and turns down the light and asks if she can stay over a second night. As Jerry removes his own shoes and begins to grow confident, the phone rings for Laura. When Laura gets off the phone she tells Jerry: \"Never get engaged.\" Jerry then realizes that he has no chance with Laura, but has already committed himself – and his one-bedroom apartment – to an entire weekend with her, including a five-hour sightseeing boat ride around Manhattan."),
                Episode(season: 1, numberInSeason: 2, totalNumber: 2, name: "The Stake Out", director:"Tom Cherones", writers: ["Larry David", "Jerry Seinfeld"], originalAirDate: Date(day: 5, month: 5, year: 1990)),
                Episode(season: 1, numberInSeason: 3, totalNumber: 3, name: "The Robbery" , director:"Tom Cherones", writers: ["Matt Goldman"], originalAirDate: Date(day: 7, month: 6, year: 1990)),
                Episode(season: 1, numberInSeason: 4, totalNumber: 4, name: "Male Unbonding" , director: "Tom Cherones", writers: ["Larry David", "Jerry Seinfeld"], originalAirDate: Date(day: 14, month: 6, year: 1990)),
                Episode(season: 1, numberInSeason: 5, totalNumber: 5, name: "The Stock Tip", director:"Tom Cherones", writers: ["Larry David", "Jerry Seinfeld"], originalAirDate: Date(day: 21, month: 6, year: 1990))
            ]
        case 2:
            return [
                Episode(season: 2, numberInSeason: 1, totalNumber: 6, name: "The Ex-Girlfriend", director:"Tom Cherones", writers: ["Larry David", "Jerry Seinfeld"], originalAirDate: Date(day: 23, month: 1, year: 1991)),
                Episode(season: 2, numberInSeason: 2, totalNumber: 7, name: "The Pony Remark", director: "Tom Cherones", writers: ["Larry David", "Jerry Seinfeld"], originalAirDate: Date(day: 30, month: 1, year: 1991)),
                Episode(season: 2, numberInSeason: 3, totalNumber: 8, name: "The Jacket" , director: "Tom Cherones", writers: ["Larry David", "Jerry Seinfeld"], originalAirDate: Date(day: 6, month: 2, year: 1991)),
                Episode(season: 2, numberInSeason: 4, totalNumber: 9, name: "The Phone Message", director:"Tom Cherones", writers: ["Larry David", "Jerry Seinfeld"], originalAirDate: Date(day: 13, month: 2, year: 1991)),
                Episode(season: 2, numberInSeason: 5, totalNumber: 10, name: "The Apartment" , director:"Tom Cherones", writers: ["Peter Mehlman"], originalAirDate: Date(day: 4, month: 4, year: 1991)),
                Episode(season: 2, numberInSeason: 6, totalNumber: 11, name: "The Statue" , director: "Tom Cherones", writers: ["Larry Charles"], originalAirDate: Date(day: 1, month: 4, year: 1991)),
                Episode(season: 2, numberInSeason: 7, totalNumber: 12, name: "The Revenge" , director:"Tom Cherones", writers: ["Larry David"], originalAirDate: Date(day: 18, month: 4, year: 1991)),
                Episode(season: 2, numberInSeason: 8, totalNumber: 13, name: "The Heart Attack", director:"Tom Cherones", writers: ["Larry Charles"], originalAirDate: Date(day: 25, month: 4, year: 1991)),
                Episode(season: 2, numberInSeason: 9, totalNumber: 14, name: "The Deal" , director:"Tom Cherones", writers: ["Larry David"], originalAirDate: Date(day: 2, month: 5, year: 1991)),
                Episode(season: 2, numberInSeason: 10, totalNumber: 15, name: "The Baby Shower", director: "Tom Cherones", writers: ["Larry Charles"], originalAirDate: Date(day: 16, month: 5, year: 1991)),
                Episode(season: 2, numberInSeason: 11, totalNumber: 16, name: "The Chinese Restaurant", director: "Tom Cherones", writers:  ["Larry David", "Jerry Seinfeld"], originalAirDate: Date(day: 23, month: 5, year: 1991)),
                Episode(season: 2, numberInSeason: 12, totalNumber: 17, name: "The Busboy" , director: "Tom Cherones", writers: ["Larry David", "Jerry Seinfeld"], originalAirDate: Date(day: 26, month: 6, year: 1991)),
            ]
        default:
            return []
        }
    }
}


struct Episode: Hashable {
    var season: Int
    var numberInSeason: Int
    var totalNumber: Int
    var name: String
    var director: String
    var writers: [String]
    var originalAirDate: Date
    var description: String?
    var originalAirDateText: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: self.originalAirDate)
    }
    var writersText: String {
        var text = writers.joined(separator: ", ")
        if let lastCommaLocation = text.range(of: ",") {
            text.replaceSubrange(lastCommaLocation, with: " &")
        }
        return text
    }
}

extension Date {
    init(day: Int, month: Int, year: Int) {
        let cal = Calendar(identifier: .gregorian)
        var date = Date(timeIntervalSince1970: 0)
        date = cal.date(bySetting: .day, value: day, of: date)!
        date = cal.date(bySetting: .month, value: month, of: date)!
        date = cal.date(bySetting: .year, value: year, of: date)!
        self = date
    }
}
