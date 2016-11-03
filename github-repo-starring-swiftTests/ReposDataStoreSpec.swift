//
//  ReposDataStoreSpec.swift
//  github-repo-starring-swift
//
//  Created by Haaris Muneer on 7/26/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Quick
import Nimble
import OHHTTPStubs

@testable import github_repo_starring_swift
class ReposDataStoreSpec: QuickSpec {
    
    override func spec() {
        OHHTTPStubs.stubRequests(passingTest: { (request) -> Bool in
            
            return(request.url?.host == "api.github.com" && request.url?.path == "/repositories")
            
        }) { (request) -> OHHTTPStubsResponse in
            let response = OHHTTPStubsResponse(fileAtPath: OHPathForFileInBundle("repositories.json", Bundle(for: type(of: self)))!, statusCode: 200, headers: ["Content-Type": "application/json"])
            return response
        }
        
        describe("getRepositories") {
            it("should get the correct repo dictionaries and create repository objects from them") {
                
                let store = ReposDataStore.sharedInstance
                
                waitUntil(action: { (done) in
                    store.getRepositoriesFromAPI() {
                        expect(store.repositories.count).to(equal(2))
                        
                        let repo1 = store.repositories[0]
                        expect(repo1.fullName).to(equal("mojombo/grit"))
                        expect(repo1.repositoryID).to(equal("1"))
                        expect(repo1.htmlURL).to(equal(URL(string: "https://github.com/mojombo/grit")))
                        
                        let repo2 = store.repositories[1]
                        expect(repo2.fullName).to(equal("wycats/merb-core"))
                        expect(repo2.repositoryID).to(equal("26"))
                        expect(repo2.htmlURL).to(equal(URL(string: "https://github.com/wycats/merb-core")))
                        done()
                    }
                })
            }
        }
    }

}
