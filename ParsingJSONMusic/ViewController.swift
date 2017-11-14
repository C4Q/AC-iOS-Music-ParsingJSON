//
//  ViewController.swift
//  ParsingJSONMusic
//
//  Created by C4Q  on 11/14/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var albums = [Album]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        loadData()
    }
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "music", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                self.albums = Album.getAlbums(from: data)
            }
        }
    }
    
    //MARK: - Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let album = albums[indexPath.row]
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Album Cell", for: indexPath)
        cell.textLabel?.text = album.collectionName
        cell.detailTextLabel?.text = album.artistName
        return cell
    }

}

