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
    case search(queryParams:String)
    case topCharts
    var baseUrl: String {"https://api.music.apple.com/v1/"}
    
    /*
     3-)Arama içn search for catalog resources https://api.music.apple.com/v1/catalog/{storefront}/search
     example: https://api.music.apple.com/v1/catalog/us/search?term=james+brown&limit=2&types=artists,albums
     term=james+brown&limit=2&types=artists,albums
     */
  
    var path: String {
        switch self {
        case .playlists:
            return "me/library/playlists"
        case .topCharts:
            return "catalog/tr/charts?types=songs,albums,playlists&genre=20&limit=20"
        case .catalogPlaylists(let id):
            return "catalog/tr/playlists/\(id)"
        case .search(let queryParams):
            return prepareUrl(path: "catalog/us/search?", text: queryParams)
        }
    }
    private func prepareUrl(path: String, text: String) -> String{
        let queryParams = ["term":"\(text)","limit":"2","types":"artists,albums"]
        
        var signParams = ""
        signParams += path
        for(key,value) in queryParams {
            var myValue = ""
            if value.contains(" ")  {
                myValue += value.replacingOccurrences(of: " ", with: "+")
            }
            signParams.append("\(key)=\(myValue)&")
        }
        signParams.removeLast()
        return signParams
    }
    var method: HTTPMethod {
        switch self {
        case .playlists:
            return .get
        case .catalogPlaylists:
            return .get
        case .search:
            return .get
        case .topCharts:
            return .get 
        }
    }
}

/*
 1-) Parçaların top chartı için https://api.music.apple.com/v1/catalog/tr/charts
 example:https://api.music.apple.com/v1/catalog/tr/charts?types=songs,albums,playlists&genre=20&limit=1
 
 2 -) Playlistler için Get All Library Playlists https://api.music.apple.com/v1/me/library/playlists
 example: https://api.music.apple.com/v1/me/library/playlists
 

 */
