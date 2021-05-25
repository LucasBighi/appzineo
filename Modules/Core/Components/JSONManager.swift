//
//  JSONManager.swift
//  Core
//
//  Created by Lucas Marques Bigh (P) on 19/05/21.
//

import Foundation

struct JSONManager {
    static func readJSON<T: Codable>(filename: String,
                                            as: T.Type) -> T? {
        if let url = Bundle.main.url(forResource: filename, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
