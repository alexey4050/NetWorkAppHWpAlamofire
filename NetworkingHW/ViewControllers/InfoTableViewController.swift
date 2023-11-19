//
//  InfoTableViewController.swift
//  NetworkingHW
//
//  Created by testing on 15.11.2023.
//

import UIKit

final class InfoTableViewController: UITableViewController {
    private var showInform: [ShowInfo] = []
    private var networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 130
        fetchInfo()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        showInform.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
        guard let cell = cell as? InfoCell else { return UITableViewCell() }
        
        let showInfo = showInform[indexPath.row]
        cell.configure(with: showInfo)
        
        return cell
    }
}
extension InfoTableViewController {
    func fetchInfo() {
        networkManager.fetch([ShowInfo].self, from: Link.infoURL.url) { result in
            switch result {
            case.success(let showInform):
                self.showInform = showInform
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}




