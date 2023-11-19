//
//  ImageViewController.swift
//  NetworkingHW
//
//  Created by testing on 12.11.2023.
//

import UIKit
import Alamofire

final class ImageViewController: UIViewController {
    private var artworks: [Artwork] = []
    private var currentIndex: Int = 0
    private var timer: Timer?
    private var networkManager = NetworkManager.shared
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchArtworks()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(showNextArtwork), userInfo: nil, repeats: true)
    }
    
    private func fetchArtworks() {
        AF.request(Link.photosURL.url)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let json):
                    guard json is [[String: Any]] else {
                        print("Invalid JSON format")
                        return
                    }
                    
                    let artworks = Artwork.getArtwork(from: json)
                    self.artworks = artworks
                    self.showArtwork(at: self.currentIndex)
                    
                case .failure(let error):
                    print("Error fetching artwork: \(error.localizedDescription)")
                    
                }
            }
    }
    
    private func showArtwork(at index: Int) {
        guard index >= 0 && index < artworks.count else {
            print("Invalid index")
            return
        }
        let artwork = artworks[index]
        guard let url = URL(string: artwork.url ) else {
            print("Invalid URL")
            return
        }
        
        networkManager.fetchImage(from: url) { result in
            switch result {
            case .success(let data):
                self.imageView.image = UIImage(data: data)
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                print("Error fetching image: \(error.localizedDescription)")
            }
        }
    }
    
    @objc private func showNextArtwork() {
        currentIndex = (currentIndex + 1) % artworks.count
        showArtwork(at: currentIndex)
    }
}

