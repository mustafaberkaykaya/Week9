//
//  Result.swift
//  Week9
//
//  Created by Mustafa Berkay Kaya on 1.12.2021.
//

import Foundation

struct Result: Codable {
    let originalTitle: String
    let backdropPath: String
    
    private enum CodingKeys: String, CodingKey {
          case
            originalTitle = "original_title",
            backdropPath = "backdrop_path"
      }
}
