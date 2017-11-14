//
//  Album.swift
//  ParsingJSONMusic
//
//  Created by C4Q  on 11/14/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class Album {
    let artistName: String
    let collectionName: String
    let trackCount: Int
    init(artistName: String, collectionName: String, trackCount: Int) {
        self.artistName = artistName
        self.collectionName = collectionName
        self.trackCount = trackCount
    }
    convenience init?(from dict: [String: Any]) {
        let artistName = dict["artistName"] as? String ?? "Unknown Artist"
        guard let collectionName = dict["collectionName"] as? String else {return nil}
        let trackCount = dict["trackCount"] as? Int ?? 0
        self.init(artistName: artistName, collectionName: collectionName, trackCount: trackCount)
    }
    
    static func getAlbums(from data: Data) -> [Album] {
        var albums = [Album]()
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            guard let jsonDict = json as? [String: Any] else { return [] }
            guard let albumArr = jsonDict["results"] as? [[String: Any]] else {return [] }
            for albumDict in albumArr {
                if let newAlbum = Album(from: albumDict) {
                    albums.append(newAlbum)
                }
            }
        }
        catch {
            print("Error")
        }
        return albums
    }
    
}
