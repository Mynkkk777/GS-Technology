//
//  AddDataModel.swift
//  GS-Technology
//
//  Created by Mayank Rai on 14/05/20.
//  Copyright © 2020 Mayank Rai. All rights reserved.
//

//import Foundation
//
//
struct GuardData : Decodable {

    var Name : String!
    var Address : String!
    var DOB : String!
    var Gender : String!
    var ContactNumber : Int!
    var AadharNumber : Int!
    var BankName : String!
    var BankAccountNumber : Int!
     var BankIFSC : String!
      var Position : String!
      var SalaryPerDay : Int!
}
//
//struct GuardData : Codable {
//
//    var adult : Bool = false
//    var backdropPath : String = ""
//    var genreIds : [Int] = []
//    var id : Int = 0
//    var originalLanguage : String = ""
//    var originalTitle : String = ""
//    var overview : String = ""
//    var popularity : Float = 0.0
//    var posterPath : String = ""
//    var releaseDate : String = ""
//    var title : String = ""
//    var video : Bool = false
//    var voteAverage : Float = 0.0
//    var voteCount : Int = 0
//
//    var isVisited: Bool = false
//
//    enum CodingKeys: String, CodingKey {
//        case adult = "adult"
//        case backdropPath = "backdrop_path"
//        case genreIds = "genre_ids"
//        case id = "id"
//        case originalLanguage = "original_language"
//        case originalTitle = "original_title"
//        case overview = "overview"
//        case popularity = "popularity"
//        case posterPath = "poster_path"
//        case releaseDate = "release_date"
//        case title = "title"
//        case video = "video"
//        case voteAverage = "vote_average"
//        case voteCount = "vote_count"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        adult = try values.decodeIfPresent(Bool.self, forKey: .adult) ?? false
//        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath) ?? ""
//        genreIds = try values.decodeIfPresent([Int].self, forKey: .genreIds) ?? []
//        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
//        originalLanguage = try values.decodeIfPresent(String.self, forKey: .originalLanguage) ?? ""
//        originalTitle = try values.decodeIfPresent(String.self, forKey: .originalTitle) ?? ""
//        overview = try values.decodeIfPresent(String.self, forKey: .overview) ?? ""
//        popularity = try values.decodeIfPresent(Float.self, forKey: .popularity) ?? 0.0
//        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath) ?? ""
//        releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate) ?? ""
//        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
//        video = try values.decodeIfPresent(Bool.self, forKey: .video) ?? false
//        voteAverage = try values.decodeIfPresent(Float.self, forKey: .voteAverage) ?? 0.0
//        voteCount = try values.decodeIfPresent(Int.self, forKey: .voteCount) ?? 0
//    }
//
//}
