//
//  DataManager.swift
//  movieapp
//
//  Created by Олександр Олійник on 09.07.2022.
//

import Foundation
import RealmSwift

struct DataManager {
    var realm = try? Realm()
    
    func save(movieId: Int) {
        let watchListMovie = WatchListMovie()
        watchListMovie.id = movieId
        
        try? realm?.write {
            realm?.add(watchListMovie)
        }
    }
    
    func getWatchList() -> [WatchListMovie] {
        var watchList = [WatchListMovie]()
        guard let DBWatchList = realm?.objects(WatchListMovie.self) else { return [ ] }
        for film in DBWatchList {
            watchList.append(film)
        }
        return watchList
    }
    
    func delete(movieToDelete: WatchListMovie) {
        let movieToDelete = movieToDelete
        try? realm?.write {
            if !movieToDelete.isInvalidated {
                realm?.delete(movieToDelete)
            }
        }
    }
}
