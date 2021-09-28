//
//  JWT.swift
//  MusicApp
//
//  Created by Semih Özsoy on 17.08.2021.
//

import UIKit
import SwiftJWT
import StoreKit

struct JWT {
    let teamId = "RE9892F24F"
    let keyId = "J766FNQUAL"
    let authToken = """
        -----BEGIN PRIVATE KEY-----
        MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQgnK4yCkJg0X5XpyNV
        uqu1BoXcMdZMq/kxYpXVOICriSOgCgYIKoZIzj0DAQehRANCAASLXcfXS1YywpHN
        dFlexEieaFJoZy3KPEqHK+uB7JNoBI1uYFfLlqAvfAIANQ2QrVwGbdcGZyySptma
        R67v9MnJ
        -----END PRIVATE KEY-----
        """
    let developerToken = """
        eyJ0eXAiOiJKV1QiLCJhbGciOiJFUzI1NiIsImtpZCI6Iko3NjZGTlFVQUwifQ.eyJpc3MiOiJSRTk4OTJGMjRGIiwiaWF0IjoxNjI5MTkxNTMzLjY5Mjc5MTksImV4cCI6MTYzNzgzMTUzMy42OTI3OTE5fQ.aq-aEcXhJBT4dryNwSX7L91Pg5BG_yZs8ib-ZtI_oxK2Bu4aGWMzC0zM6beJIP4XUT3coj1wtw-IUfUk2DJ3nw
        """
    
    func generateToken()->String{
        let myHeader = Header(kid:keyId)
        let claims = JWTClaim(iss: teamId, iat: Date(), exp: Date() + 60 * 60 * 24 * 100 )
        var jwt = SwiftJWT.JWT(header: myHeader, claims: claims)
        
        guard let tokenData = authToken.data(using: .utf8) else { return "" }
        do {
            let token = try jwt.sign(using: .es256(privateKey: tokenData))
            return token
        } catch {
            print(error.localizedDescription)
        }
        return ""
    }
}

struct JWTClaim: Claims {
    let iss: String
    let iat: Date?
    let exp: Date?
}

struct MusicUserToken{
    func generateMusicToken(completion: @escaping (String) -> Void) {
        let token = JWT().developerToken
        SKCloudServiceController().requestUserToken(forDeveloperToken: token) { userToken,error in
            if let musicUserToken = userToken {
              completion(musicUserToken)
            }
        }
    }
}





