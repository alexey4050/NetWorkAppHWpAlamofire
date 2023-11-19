//
//  InfoCellTableViewCell.swift
//  NetworkingHW
//
//  Created by testing on 15.11.2023.
//

import UIKit

final class InfoCell: UITableViewCell {
    
    private let networkManager = NetworkManager.shared
    
    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var numberInfoLabel: UILabel!
    @IBOutlet weak var nameInfoLabel: UILabel!
    @IBOutlet weak var primaryDataLabel: UILabel!
    @IBOutlet weak var episodeInfoLabel: UILabel!
    @IBOutlet weak var endData: UILabel!
    
    func configure(with info: ShowInfo) {
        numberInfoLabel.text = "Number: \(info.number)"
        nameInfoLabel.text = "Name: \(info.name)"
        primaryDataLabel.text = "Primary data: \(info.premiereDate)"
        episodeInfoLabel.text = "Episode info: \(info.episodeOrder)"
        endData.text = "End data \(info.endDate)"
        
        if let imageUrl = URL(string: info.image.medium) {
            networkManager.fetchImage(from: imageUrl) { result in
                switch result {
                case .success(let imageData):
                    self.infoImage.image = UIImage(data: imageData)
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            print("Invalid image URL")
        }
    }
}
