//
//  URL+Extensions.swift
//  FlickerSearch
//
//  Created by Oskar Jönsson on 2021-07-08.
//

import Foundation

extension URL {
    func appendingPathComponents(_ pathComponents: [String]) -> URL {
        pathComponents.reduce(self) { url, pathComponent in
            url.appendingPathComponent(pathComponent)
        }
    }
}
