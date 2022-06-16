//
//  SearchViewController.swift
//  movieapp
//
//  Created by Олександр Олійник on 16.06.2022.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    let data = ["Alex", "John", "Anna", "Anet", "jake", "jimmy", "anton", "janet", "Timy", "Arnold", "Jacob", "Rick", "Mia", "Pen", "Josh", "Donald"]
    
    var searchedData: [String] = [ ]
    
    var isSearching = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !isSearching {
            return data.count
        } else {
            return searchedData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if !isSearching {
            cell.textLabel?.text = data[indexPath.row]
        } else {
            cell.textLabel?.text = searchedData[indexPath.row]
        }
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchedData.removeAll()
        
        guard searchText != "" || searchText != " " else {
            return
        }
        
        for item in data {
            let text = searchText.lowercased()
            let isArrContain = item.lowercased().range(of: text)
            
            if isArrContain != nil {
                searchedData.append(item)
            }
        }
        
        if searchBar.text == "" {
            isSearching = false
            DispatchQueue.main.async{
            self.tableView.reloadData()
            }
        } else {
            isSearching = true
            searchedData = data.filter({$0.contains(searchBar.text ?? "")})
            DispatchQueue.main.async{
            self.tableView.reloadData()
            }
        }
    }
    
}
