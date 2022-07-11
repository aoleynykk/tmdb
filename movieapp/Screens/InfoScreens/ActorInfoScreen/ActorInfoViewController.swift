//
//  ActorInfoViewController.swift
//  movieapp
//
//  Created by Олександр Олійник on 09.07.2022.
//

import UIKit
import Alamofire

class ActorInfoViewController: UIViewController {

    var id: Int = 0
    
    @IBOutlet weak var actorImage: UIImageView!
    @IBOutlet weak var actorName: UILabel!
    @IBOutlet weak var birthday: UILabel!
    @IBOutlet weak var birthPlace: UILabel!
    @IBOutlet weak var actorDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup(id: id)
    }
    
    func setup(id: Int) {
        AF.request("https://api.themoviedb.org/3/person/\(id)?api_key=ab04cd0db471f8aec7ec3b6be80f900c&language=en-US", method: .get).responseJSON { response in
            let jsonDecoder = JSONDecoder()
            guard let responseData = response.data else { return }
            if let responseModel = try! jsonDecoder.decode(ActorModel?.self, from: responseData) {
                if (responseModel.profile_path != nil) {
                    guard let imageString = responseModel.profile_path else { return }
                    guard let imageUrl = URL(string: "https://image.tmdb.org/t/p/original" + imageString) else { return }
                    self.actorImage.sd_setImage(with: imageUrl)
                } else {
                    self.actorImage.image = UIImage(named: "no_image")
                    self.actorImage.contentMode = .scaleAspectFill
                }
                self.actorName.text = responseModel.name ?? Constants().empty
                self.birthday.text = responseModel.birthday ?? Constants().empty
                self.birthPlace.text = responseModel.place_of_birth ?? Constants().empty
                self.actorDescription.text = responseModel.biography ?? Constants().empty
            }
        }
    }
}
