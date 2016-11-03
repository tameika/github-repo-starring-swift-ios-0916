//
//  FISReposDataStore.swift
//  github-repo-list-swift
//
//  Created by  susan lovaglio on 10/23/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ReposDataStore {
    
    static let sharedInstance = ReposDataStore()
    
    var repositories: [GithubRepository] = []
    
    func getRepositoriesFromAPI(_ completion: @escaping () -> ()) {
        
        GithubAPIClient.getRepositories { (jsonArray) in
            
            if !self.repositories.isEmpty { self.repositories.removeAll() }
            
            for repoDict in jsonArray {
                
                let gitHubRepo = GithubRepository.init(dictionary: repoDict)
                
                self.repositories.append(gitHubRepo)
                
            }
            
            completion()
        }
        
    }
    
    
    func toggleStarStatus(for repoObject: GithubRepository, completion: @escaping (Bool) -> ()) {
        
        GithubAPIClient.checkIfRepositoryIsStarred(repoObject.fullName) { (starred) in
            
            if starred {
                
                GithubAPIClient.unstarRespository(named: repoObject.fullName, completion: {
                    
                    completion(false)
                })
                
            } else {
                
                GithubAPIClient.starRespository(named: repoObject.fullName, completion: {
                    
                    completion(true)
                })
            
            }
        }
    }
    
    
    
    
}
