//
//  MovieModel.swift
//  MovieApp
//
//  Created by 정성희 on 2024/02/23.
//

import Foundation
// 네트워크 데이터 받아올때 구조는 이런식으로 짤것
struct MovieModel: Codable {
    let resultCount: Int
    let results: [MovieResult]

}

struct MovieResult: Codable {
    // 백엔드에서 주는 데이터는 상황에 따라 줄 때도 있고 못줄때도 있으므로 optional 로 지정해둘 것
    let trackName: String?
    let previewUrl: String?
    let image: String?
    let shortDescription: String?
    let longDescription: String?
    let trackPrice: Double?
    let currency: String?
    let releaseDate: String?
    
    
    // json key 이름이 마음에 들지 않는다면 이름을 직접 바꿔서 사용할 수 있음
    enum CodingKeys: String, CodingKey {
        case trackName
        case previewUrl
        case image = "artworkUrl100"
        case shortDescription
        case longDescription
        case trackPrice
        case currency
        case releaseDate
    }
}


