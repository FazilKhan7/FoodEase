//
//  BasketViewController.swift
//  FoodEase
//
//  Created by Bakhtiyarov Fozilkhon on 02.09.2023.
//

import Foundation
import UIKit
import CoreLocation
import CoreData

final class BasketViewController: UIViewController {
    
    private lazy var customNavigationBar = CustomNavigationBar()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(BascetTableViewCell.self, forCellReuseIdentifier: BascetTableViewCell.reuseId)
        
        return tableView
    }()
    
    private lazy var payButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.2, green: 0.3921568627, blue: 0.8784313725, alpha: 1)
        button.layer.cornerRadius = 12
        
        return button
    }()
    
    
    private lazy var fetchResultController: NSFetchedResultsController = {
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "DishEntity")
        fetchReq.sortDescriptors = []
        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchReq, managedObjectContext: CoreDataManager.shared.context, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchedResultController
    }()
    
    private var presenter = BascetPresenter.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCoreData()
        addAllSubviews()
        setupViews()
        setConstraints()
    }
    
    private func setCoreData() {
        fetchResultController.delegate = self
        do {
            try fetchResultController.performFetch()
        }catch {
            print(error)
        }
    }
    
    private func addAllSubviews() {
        [tableView, payButton, customNavigationBar].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        payButton.setTitle("Оплатить \(presenter.sumPricesOfFetchResultController(fetchResultController: fetchResultController)) ₽", for: .normal)
    }
    
    private func setConstraints() {
        
        customNavigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(customNavigationBar.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(payButton.snp.top).offset(10)
        }
        
        payButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-25)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-12)
            make.height.equalTo(48)
        }
    }
}


extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchResultController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchResultController.sections {
            return sections[section].numberOfObjects
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BascetTableViewCell.reuseId, for: indexPath) as! BascetTableViewCell
        let dishEntities = fetchResultController.object(at: indexPath) as! DishEntity
        cell.delegate = self
        cell.configureCell(entity: dishEntities)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let dishEntity = fetchResultController.object(at: indexPath) as! DishEntity
            CoreDataManager.shared.context.delete(dishEntity)
            CoreDataManager.shared.saveContext()
        }
    }
}

extension BasketViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                let dishEntities = fetchResultController.object(at: indexPath) as! DishEntity
                let cell = tableView.cellForRow(at: indexPath) as! BascetTableViewCell
                cell.configureCell(entity: dishEntities)
            }
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        default:
            break
        }
        payButton.setTitle("Оплатить \(presenter.sumPricesOfFetchResultController(fetchResultController: fetchResultController)) ₽", for: .normal)
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}

extension BasketViewController: BascetTableViewCellDelegate {
    
    func stepperValueChanged(inCell cell: BascetTableViewCell, quantity: Int) {
        
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        let dishEntity = fetchResultController.object(at: indexPath) as! DishEntity
        dishEntity.quantity += Int16(quantity)
        CoreDataManager.shared.saveContext()
        
        payButton.setTitle("Оплатить \(presenter.sumPricesOfFetchResultController(fetchResultController: fetchResultController)) ₽", for: .normal)
    }
}
