//
//  RestaruntsTableViewController.swift
//  Yummy
//
//  Created by hackeru on 29/06/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import UIKit

protocol IdetailsDelegate: class {
    func didTapCell(_ viewModel: ResturantsViewModel)
}

class RestaruntsTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModels = [ResturantsViewModel]()
    weak var delegate : IdetailsDelegate?
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }
}


extension RestaruntsTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ResturantCell
        
        let vm = viewModels[indexPath.row]
        cell.configure(with: vm)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vm = viewModels[indexPath.row]
        self.performSegue(withIdentifier: "details", sender: vm)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailsFoodViewController
        self.delegate = vc
        delegate?.didTapCell(sender as! ResturantsViewModel)

    }
    
}
