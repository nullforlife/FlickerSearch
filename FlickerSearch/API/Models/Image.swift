//
//  Image.swift
//  FlickerSearch
//
//  Created by Oskar Jönsson on 2021-07-08.
//

import Foundation

struct Image: Decodable {
    let title: String
    let id: String
    let url_m: URL
}
