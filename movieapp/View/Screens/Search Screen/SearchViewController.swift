//
//  SearchViewController.swift
//  movieapp
//
//  Created by Олександр Олійник on 16.06.2022.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var listOfFilms: [SearchingMovie] = [ ]

    var listOfSearchingFilms: [SearchingMovie] = [ ]

    var isSearching = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        tableView.estimatedRowHeight = 1.001
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !isSearching {
            return listOfFilms.count
        } else {
            return listOfSearchingFilms.count
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "MovieInfoViewController") as! MovieInfoViewController
        //controller.modalPresentationStyle = .fullScreen
        controller.movieID = listOfSearchingFilms[indexPath.row].id!
        navigationController?.present(controller, animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        if !isSearching {
            cell.setup(data: listOfFilms[indexPath.row])
        } else {
            cell.setup(data: listOfSearchingFilms[indexPath.row])
        }
        return cell
    }
}
extension SearchViewController: UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.listOfSearchingFilms.removeAll()

        if searchText != "" || searchText != " " {
            searchMovie(nameOfMovie: searchText.lowercased())
        } else {
            isSearching = false
            return
        }
        
//        for film in listOfFilms {
//            let text = searchText.lowercased()
//            let isArrContain = film.title!.lowercased().range(of: text)
//
//            if isArrContain != nil {
//                self.listOfSearchingFilms.append(film)
//            }
//        }
        //
        if searchBar.text == " " {
            isSearching = false
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
            
        } else {
            isSearching = true
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }

    func searchMovie(nameOfMovie: String) {
        AF.request("https://tmdbapi.azurewebsites.net/Search?nameOfMovie=\(nameOfMovie)", method: .get).responseJSON { response in
            let jsonDecoder = JSONDecoder()
            guard let responseData = response.data else { return }
            if let responseModel = try! jsonDecoder.decode(SearchingMovieModel?.self, from: responseData) {
                self.listOfSearchingFilms = responseModel.results ?? self.listOfFilms
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

