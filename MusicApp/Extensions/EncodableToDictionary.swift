//
//  EncodableToDictionary.swift
//  MusicApp
//
//  Created by Semih Özsoy on 20.08.2021.
//

import Foundation

extension Encodable {
    func asDictionary()->[String:String]{
        guard let data = try? JSONEncoder().encode(self) else {return [:]}
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String:String] } ?? [:]
    }
}

