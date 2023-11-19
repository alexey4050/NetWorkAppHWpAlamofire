//
//  Artwork.swift
//  NetworkingHW
//
//  Created by testing on 11.11.2023.
//

import Foundation

struct  Artwork: Decodable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
    
    init(albumId: Int, id: Int, title: String, url: String, thumbnailUrl: String) {
        self.albumId = albumId
        self.id = id
        self.title = title
        self.url = url
        self.thumbnailUrl = thumbnailUrl
    }
    
    init(artworkData: [String: Any]) {
        albumId = artworkData["userId"] as? Int ?? 0
        id = artworkData["id"] as? Int ?? 0
        title = artworkData["title"] as? String ?? ""
        url = artworkData["url"] as? String ?? ""
        thumbnailUrl = artworkData["body"] as? String ?? ""
    }
    
    static func getArtwork(from value: Any) -> [Artwork] {
        guard let artworksData = value as? [[String: Any]] else { return [] }
        return artworksData.compactMap { Artwork(artworkData: $0) }
    }
}

struct Post: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
    
    init(userId: Int, id: Int, title: String, body: String) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }
    
    init(postData: [String: Any]) {
        userId = postData["userId"] as? Int ?? 0
        id = postData["id"] as? Int ?? 0
        title = postData["title"] as? String ?? ""
        body = postData["body"] as? String ?? ""
    }
}

struct Todos: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
    
    init(userId: Int, id: Int, title: String, completed: Bool) {
        self.userId = userId
        self.id = id
        self.title = title
        self.completed = completed
    }
    
    init(todosData: [String: Any]) {
        userId = todosData["userId"] as? Int ?? 0
        id = todosData["id"] as? Int ?? 0
        title = todosData["title"] as? String ?? ""
        completed = todosData["completed"] as? Bool ?? false
    }
}

struct ShowInfo: Decodable {
    let id: Int
    let url: String?
    let number: Int
    let name: String
    let episodeOrder: Int
    let premiereDate: String
    let endDate: String
    let image: Image
    
    init(id: Int, url: String?, number: Int, name: String, episodeOrder: Int, premiereDate: String, endDate: String, image: Image) {
        self.id = id
        self.url = url
        self.number = number
        self.name = name
        self.episodeOrder = episodeOrder
        self.premiereDate = premiereDate
        self.endDate = endDate
        self.image = image
    }
    
    init(showInfoData: [String: Any]) {
        id = showInfoData["id"] as? Int ?? 0
        url = showInfoData["url"] as? String
        number = showInfoData["number"] as? Int ?? 0
        name = showInfoData["name"] as? String ?? ""
        episodeOrder = showInfoData["episodeOrder"] as? Int ?? 0
        premiereDate = showInfoData["premiereData"] as? String ?? ""
        endDate = showInfoData["endDate"] as? String ?? ""
        
        let imageDictionary = showInfoData["image"] as? [String: String]
        image = Image(imageData: imageDictionary ?? [:])
    }
}

struct Image: Decodable {
    let medium: String
    let original: String
    
    init(medium: String, original: String) {
        self.medium = medium
        self.original = original
    }
    
    init(imageData: [String: String]) {
        medium = imageData["medium"] ?? ""
        original = imageData["original"] ?? ""
    }
}
