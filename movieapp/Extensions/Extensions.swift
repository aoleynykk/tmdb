//
//  Extensions.swift
//  movieapp
//
//  Created by Олександр Олійник on 10.07.2022.
//

import Foundation

extension SearchViewController {
    
    func clearSearchTables() {
        self.listOfSearchingFilms.removeAll()
        self.listOfSearchigActors.removeAll()
        self.listOfSearchingTVShows.removeAll()
        self.searchCollectionView.reloadData()
    }
}
