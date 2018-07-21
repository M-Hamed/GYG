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
        initNavBar()
    }
    
    func initNavBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addReview))
        navigationItem.rightBarButtonItems = [addButton]
    }
    
    @objc func addReview(sender: UIBarButtonItem) {
        let vc = CreateReviewViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupPresenter() {
        presenter.loadedReviews = { [weak self] in
            self?.stopLoading()
            self?.tableView.reloadData()
        }
        
        presenter.failedToLoad = { [weak self] error in
            self?.stopLoading()
            Activity.showAlert(self, message: error.localizedDescription)
        }
        
        presenter.updateLoadingStatus = { loading in
            if !loading {
                Activity.stopAnimating()
            }
        }
        
        Activity.startAnimating()
        presenter.loadReviews(reset: false)
    }
    
    func stopLoading() {
        refreshControl.endRefreshing()
        tableView.finishInfiniteScroll()
    }
    
    @objc func handleRefresh(refreshControl: UIRefreshControl) {
        presenter.loadReviews(reset: true)
    }
}
//MARK: TableView
extension ReviewsViewController {
    
    var cells: [UITableViewCell.Type] {
        return [ReviewTableViewCell.self, FilterTableViewCell.self]
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        registerCells()
        tableView.addSubview(refreshControl)
        
        tableView.infiniteScrollTriggerOffset = 500
        
        tableView.addInfiniteScroll { (tableView) -> Void in
            self.presenter.loadReviews(reset: false)
            print("infinte ")
        }
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return presenter.numberOfCells
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FilterTableViewCell.self)) as! FilterTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ReviewTableViewCell.self)) as! ReviewTableViewCell
            cell.configure(review: presenter.reviewAtIndex(at: indexPath))
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            Activity.startAnimating()
            presenter.toggleFilter()
        }
    }
}
