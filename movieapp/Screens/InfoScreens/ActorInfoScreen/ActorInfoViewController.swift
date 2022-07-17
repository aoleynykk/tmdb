//
//  ActorInfoViewController.swift
//  movieapp
//
//  Created by Олександр Олійник on 09.07.2022.
//

import UIKit

class ActorInfoViewController: UIViewController {

    var id: Int = 0
    
    let constants = Constants()
        
    @IBOutlet weak var actorImage: UIImageView!
    
    @IBOutlet weak var actorName: UILabel!
    
    @IBOutlet weak var birthday: UILabel!
    
    @IBOutlet weak var birthPlace: UILabel!
    
    @IBOutlet weak var actorDescription: UILabel!
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActorInfoPage(id: id)
    }
    
    // MARK: - Private Funcs
    
    private func setupActorInfoPage(id: Int) {
        NetworkManager.shared.requstInfo(infoRequest: "/3/person/", id: id, model: ActorModel?.self) { [self] response in
            if (response?.profile_path != nil) {
                guard let imageString = response?.profile_path else { return }
                guard let imageUrl = URL(string: "https://image.tmdb.org/t/p/original" + imageString) else { return }
                self.actorImage.sd_setImage(with: imageUrl)
            } else {
                self.actorImage.image = UIImage(named: "no_image")
                self.actorImage.contentMode = .scaleAspectFill
            }
            self.actorName.text = response?.name ?? constants.empty
            self.birthday.text = response?.birthday ?? constants.empty
            self.birthPlace.text = response?.place_of_birth ?? constants.empty
            self.actorDescription.text = response?.biography ?? constants.empty
        }
    }
}
