//
//  SearchViewController.swift
//  FoodEase
//
//  Created by Bakhtiyarov Fozilkhon on 26.09.2023.
//

import Foundation
import UIKit
import SnapKit

class SearchViewController: UIViewController, SearchPresenterDelegate {
    
    private lazy var searchController = UISearchController(searchResultsController: nil)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.reuseID)
        
        return tableView
    }()
    
    private lazy var searchedDishes: [Dish] = []
    private var presenter = SearchPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        addSubviews()
        setupViews()
        setSearchController()
        setConstrainsts()
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        presenter.setViewDelegate(delegate: self)
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    private func setConstrainsts() {
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func presentSearchedDishes(searchedDishes: [Dish]) {
        self.searchedDishes = searchedDishes
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension SearchViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        presenter.fetchSearchedDishes(searchText: searchText)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedDishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseID, for: indexPath) as! SearchTableViewCell
        
        let dish = searchedDishes[indexPath.row]
        
        cell.configureCell(dish: dish)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CategoriesViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

