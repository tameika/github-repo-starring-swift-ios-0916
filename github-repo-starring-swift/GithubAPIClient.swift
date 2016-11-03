//
//  FISGithubAPIClient.swift
//  github-repo-list-swift
//
//  Created by  susan lovaglio on 10/23/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import UIKit

class GithubAPIClient {
    
    //static so we don't need an instance
    
    static func getRepositories(with completion: @escaping ([[String : AnyObject]]) -> Void) {
        
        let urlString = "https://api.github.com/repositories?client_id=\(apiKey)&client_secret=\(apiClientSecret)"
        
        let url = URL(string: urlString)!
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                
                let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as! [[String : AnyObject]]
                
                completion(jsonArray)
                
            } catch { return }
        }
        
        dataTask.resume()
    }
    
    
    static func checkIfRepositoryIsStarred(_ fullName: String, completion: @escaping (Bool) -> ()) {
        
        let urlString = "https://api.github.com/user/starred/\(fullName)?access_token=\(token)"
        
        guard let url = URL(string: urlString) else {
            
            print("url string to url did not work, bruh")
            
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let response = response as? HTTPURLResponse else {
                
                print("response was not converted to httpurlresponse")
                
                return
            }
            
            // response.statusCode == 204 ? completion(true) : completion(false)
            // Bool ? Do this thing if true : Do this thing if false
            
            /* SAME AS...
             
             if response.statusCode == 204 {
                completion(true)
             } else {
                completion(false)
             }
             
             ONLY WORKS FOR "IF-ELSE", NOT FOR "IF-ELSE IF"
             
            */
            
            if response.statusCode == 204 {
                
                completion(true)
                
            } else if response.statusCode == 404 {
                
                completion(false)
            
                
            }
            
        }
        
        dataTask.resume()
    }
    
    
    static func starRespository(named fullName: String, completion: @escaping () -> Void) {
        
        let urlString = "https://api.github.com/user/starred/\(fullName)?access_token=\(token)"
        
        guard let url = URL(string: urlString) else {
            
            print("url string to url in starring did not work, bruh")
            
            return
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "PUT"
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            completion()
        }
        
        dataTask.resume()

    }
    
    
    static func unstarRespository(named fullName: String, completion: @escaping () -> Void) {
        
        let urlString = "https://api.github.com/user/starred/\(fullName)?access_token=\(token)"
        
        guard let url = URL(string: urlString) else {
            
            print("url string to url in starring did not work, bruh")
            
            return
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "DELETE"
        
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            completion()
        }
        
        dataTask.resume()
    
    }

    

}
















