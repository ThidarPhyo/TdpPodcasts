//
//  PodcastSearchController.swift
//  TdpPodcasts
//
//  Created by Thidar Phyo on 3/11/21.
//

import UIKit
import Alamofire

class PodcastSearchController: UITableViewController, UISearchBarDelegate {
    
    var podcasts = [
        Podcast(trackName: "Lets Build that app", artistName: "Thidar Phyo"),
        Podcast(trackName: "Lets Build that app", artistName: "Thidar Phyo")
    ]
    
    let cellId = "cellId"
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupSearchBar()
        setupTableView()
        
    }
    
    //MARK:- Setup Work
    
    fileprivate func setupSearchBar() {
        navigationItem.searchController = searchController
        
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("----\(searchText)")
        
        //let url = "https://yahoo.com"
        //let url = "https://itunes.apple.com/search?term=\(searchText)"
        let url = "https://itunes.apple.com/search"
        let parameters = ["term": searchText]
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            
            if let err = dataResponse.error {
                print("Failed to contact yahoo", err)
                return
            }
            
            guard let data = dataResponse.data else { return }
            let dummyString = String(data: data, encoding: .utf8)
            print(dummyString ?? "")
            
            do {
                
                let searchResult = try JSONDecoder().decode(SearchResults.self, from: data)
                //print(" Search Result Count \(searchResult.resultCount)")
//                searchResult.results.forEach { (podcast) in
//                    print("Artist Name\(podcast.artistName) Track Name \(podcast.trackName)")
//                }
                self.podcasts = searchResult.results
                self.tableView.reloadData()
                
            } catch let decodeError {
                print("Failed to decode:", decodeError)
            }
            
        }
        
        
    }
    
    struct SearchResults: Decodable {
        
        let resultCount: Int
        let results: [Podcast]
        
    }
    
    //MARK:- UITableView
    
    fileprivate func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return podcasts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let podcast = self.podcasts[indexPath.row]
        cell.textLabel?.text = "\(podcast.trackName ?? "") \n \(podcast.artistName ?? "")"
        cell.textLabel?.numberOfLines = -1
        cell.imageView?.image = #imageLiteral(resourceName: "appicon")
        
        return cell
    }

}
