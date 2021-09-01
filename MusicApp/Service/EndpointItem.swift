//
//  EndpointItem.swift
//  MusicApp
//
//  Created by Semih Özsoy on 18.08.2021.
//

import Foundation
import Alamofire
import StoreKit


public protocol Endpoint {
    var baseUrl: String {get}
    var method: HTTPMethod {get}
    var parameters: [String:String] {get}
    var headers: HTTPHeaders {get}
    var path: String {get}
}

public typealias HTTPMethod = Alamofire.HTTPMethod

public extension Endpoint {
    
    var headers: HTTPHeaders {
        let developerToken = JWT().developerToken
        let token = UserDefaults.standard.string(forKey: "MusicUserToken") ?? ""
        let headers: [String:String] = ["Authorization":"Bearer \(developerToken)",
                                        "Music-User-Token": token]
        return .init(headers)
    }
    var parameters: [String:String] {[:]}
    var mainUrl: String {"\(baseUrl)\(path)"}
    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
}

enum MusicEndpointItem: Endpoint {
    case playlists
    case catalogPlaylists(id:String)
    case search(queryParams:Encodable)
    case ratings(id:String)
    var baseUrl: String {"https://api.music.apple.com/v1/"}
    
    var path: String {
        switch self {
        case .playlists:
            return "me/library/playlists"
        case .ratings(let id):
            return "me/ratings/albums/\(id)"
        case .catalogPlaylists(let id):
            return "catalog/tr/playlists/\(id)"
        case .search(let queryParams):
            return prepareUrl(path: "catalog/us/search?", queryParams: queryParams.asDictionary())
        }
    }
    private func prepareUrl(path: String, queryParams: [String:String]) -> String{
        let text = ""
        let queryParams = ["term":"\(text)","limit":"2","types":"artists,albums"]
        var signParams = ""
        for(key,value) in queryParams {
            if value.count > 2 {
                var value = value
                value = value + "+"
            }
            signParams += key + "=" + value + "&"
        }
        if !signParams.isEmpty {
            signParams = "" + signParams
            if (signParams.hasPrefix("&")) {
                signParams.removeLast()
            }
        }
        let searchBaseUrl = baseUrl + signParams
        return searchBaseUrl
    }
    var method: HTTPMethod {
        switch self {
        case .playlists:
            return .get
        case .catalogPlaylists:
            return .get
        case .search:
            return .get
        case .ratings:
            return .get
        }
    }
}
// Swift lint kur!
// Encodable to dictionary
// pathin sonuna stringleri eklemek url'i hazır hale getirmek
// MainPageWorkerdaki fonksiyon search encodable beklicek

/*
 1-) Parçaların beğeni durumu için Get Personal Album Rating playlists https://api.music.apple.com/v1/me/ratings/albums/{id}
 example:https://api.music.apple.com/v1/me/ratings/albums/pl.f0a6bef09e1a4d75a5b69d5699effefc
 
 2 -) Playlistler için Get All Library Playlists https://api.music.apple.com/v1/me/library/playlists
 example: https://api.music.apple.com/v1/me/library/playlists
 
 3-)Arama içn search for catalog resources https://api.music.apple.com/v1/catalog/{storefront}/search
 example: https://api.music.apple.com/v1/catalog/us/search?term=james+brown&limit=2&types=artists,albums
 term=james+brown&limit=2&types=artists,albums
 */
