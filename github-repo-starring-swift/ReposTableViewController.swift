//
//  FISReposTableViewController.swift
//  github-repo-list-swift
//
//  Created by  susan lovaglio on 10/23/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ReposTableViewController: UITableViewController {
    
    let store = ReposDataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.accessibilityLabel = "tableView"
        
        store.getRepositoriesFromAPI {
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
        
    }

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return store.repositories.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath)
        
        cell.textLabel?.text = store.repositories[indexPath.row].fullName
        
        return cell
    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let repo = store.repositories[indexPath.row]
        
        store.toggleStarStatus(for: repo) { (justStarred) in
            
            let alert: UIAlertController
            
            //when we came from the repoDataStore it was false = unstarred
            
            if justStarred {
                
                alert = UIAlertController(title: "GitHub I Guess", message: "You just starred \(repo.fullName), why?", preferredStyle: .alert)
                
                
            } else {
                
                 alert = UIAlertController(title: "GitHub I Guess", message: "You just unstarred \(repo.fullName), happy?", preferredStyle: .alert)
            }
            
            let okAction = UIAlertAction(title: "Mmkay", style: .default, handler: nil)
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

