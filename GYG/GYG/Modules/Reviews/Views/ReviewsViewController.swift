//
//  ReviewsViewController.swift
//  GYG
//
//  Created by Mohamed Hamed on 7/21/18.
//  Copyright © 2018 Hamed. All rights reserved.
//

import UIKit

class ReviewsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let presenter = ReviewsPresenter()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(refreshControl:)), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupPresenter()
    }
    
    
    func setupPresenter() {
        presenter.loadedReviews = { [weak self] reviewData in
            self?.refreshControl.endRefreshing()
            self?.tableView.reloadData()
        }
        
        presenter.failedToLoad = { [weak self] error in
            Activity.showAlert(self, message: error.localizedDescription)
        }
        
        presenter.updateLoadingStatus = { loading in
            if loading {
                Activity.startAnimating()
            } else {
                Activity.stopAnimating()
            }
        }
        presenter.loadReviews(reset: false)
    }
    
    @objc func handleRefresh(refreshControl: UIRefreshControl) {
        presenter.loadReviews(reset: true)
    }
}
//MARK: TableView
extension ReviewsViewController {
    
    var cells: [UITableViewCell.Type] {
        return [ReviewTableViewCell.self]
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        registerCells()
        tableView.addSubview(refreshControl)
    }
    
    func registerCells() {
        cells.forEach { cellKlass in
            let cellName = String(describing: cellKlass)
            let nib      = UINib(nibName: cellName, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: cellName)
        }
    }
}

extension ReviewsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ReviewTableViewCell.self)) as! ReviewTableViewCell
        cell.configure(review: presenter.reviewAtIndex(at: indexPath))
        return cell
    }
    
}
