//
//  NetworkManager.swift
//  movieapp
//
//  Created by Олександр Олійник on 09.07.2022.
//

import Foundation
import Alamofire
import youtube_ios_player_helper

struct NetworkManager {
    
    let constants = Constants()
    // - !!!
    func requestCastInfo<T: Decodable>(infoRequest: String, id: Int, model: T.Type, completion: @escaping (T) -> ()) {
        let address = constants.address
        let apiKey = constants.apiKey
        let lang = constants.lang
        let id = "\(id)"
        let url = address + infoRequest + id + "/credits?" + apiKey + lang
        AF.request(url).responseJSON { response in
            guard let responseData = response.data else { return }
            do {
                let data = try JSONDecoder().decode(model, from: responseData)
                completion(data)
            } catch {
                print("JSON decode error:", error)
                return
            }
        }
    }

    func requstInfo<T: Decodable>(infoRequest: String, id: Int, model: T.Type, completion: @escaping (T) -> ()) {
        let address = constants.address
        let apiKey = constants.apiKey
        let lang = constants.lang
        let id = "\(id)"
        let url = address + infoRequest + id + "?" + apiKey + lang
        AF.request(url).responseJSON { response in
            guard let responseData = response.data else { return }
            do {
                let data = try JSONDecoder().decode(model, from: responseData)
                completion(data)
            } catch {
                print("JSON decode error:", error)
                return
            }
        }
    }
    
    
    func mainScreenMovieRequest<T: Decodable>(infoRequest: String, model: T.Type, completion: @escaping (T) -> ()){
        let address = constants.address
        let apiKey = constants.apiKey
        let lang = constants.lang
        let url = address + infoRequest + "?" + apiKey + lang
        AF.request(url).responseJSON { response in
            guard let responseData = response.data else { return }
            do {
                let data = try JSONDecoder().decode(model, from: responseData)
                completion(data)
            } catch {
                print("JSON decode error:", error)
                return
            }
        }
    }
    
    func search<T: Decodable>(infoRequest: String, nameOfMovie: String, model: T.Type, completion: @escaping (T) -> ()){
        let address = constants.address
        let apiKey = constants.apiKey
        let searchWord = "&query=\(nameOfMovie)"
        let lang = constants.lang
        let url = address + infoRequest + "?" + apiKey + lang + searchWord
        AF.request(url).responseJSON { response in
            guard let responseData = response.data else { return }
            do {
                let data = try JSONDecoder().decode(model, from: responseData)
                completion(data)
            } catch {
                print("JSON decode error:", error)
                return
            }
        }
    }
    
    func requestTrailer(id: Int, trailer: YTPlayerView) {
        // TVShow id < 99999!!!
        if id < 99999 {
            let mediaType = "tv"
            AF.request("\(Constants().address)/3/\(mediaType)/\(id)/videos?\(Constants().apiKey)&\(Constants().lang)", method: .get).responseJSON { response in
                let jsonDecoder = JSONDecoder()
                guard let responseData = response.data else { return }
                guard let responseModel = try! jsonDecoder.decode(MovieVideoModel?.self, from: responseData) else { return }
                for item in responseModel.results!{
                    if item.type == "Trailer" {
                        trailer.load(withVideoId: item.key!)
                    }
                }
            }
        } else {
            let mediaType = "movie"
            AF.request("\(Constants().address)/3/\(mediaType)/\(id)/videos?\(Constants().apiKey)&\(Constants().lang)", method: .get).responseJSON { response in
                let jsonDecoder = JSONDecoder()
                guard let responseData = response.data else { return }
                guard let responseModel = try! jsonDecoder.decode(MovieVideoModel?.self, from: responseData) else { return }
                for item in responseModel.results!{
                    if item.type == "Trailer" {
                        trailer.load(withVideoId: item.key!)
                    }
                }
            }
        }
    }
}
