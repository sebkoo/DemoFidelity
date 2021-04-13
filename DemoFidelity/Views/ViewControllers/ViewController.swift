//
//  FidelityHealthcareVC.swift
//  DemoFidelity
//
//  Created by Ben Koo on 4/12/21.
//

import UIKit

class ViewController: UIViewController {
  // MARK: - Outlets
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - Property
  private var searchController: UISearchController!
  private var animeViewModel = AnimeViewModel()
  private var isActiveFirstTime = true

  // MARK: - Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
    configureViewModel()
  }
  override func viewDidAppear(_ animated: Bool) {
    
    super.viewDidAppear(animated)
    
    if isActiveFirstTime {
      searchController.isActive = true
      isActiveFirstTime = false
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  private func showAlert(title: String = "Anime curated by Ben Koo", message: String?) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    let action = UIAlertAction(title:NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.default)
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }
}

//MARK:- Configure UI
extension ViewController {
  
  fileprivate func configureUI() {
    setSearchBar()
    tableView.tableFooterView = UIView()
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = UITableView.automaticDimension
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationItem.largeTitleDisplayMode = .automatic
  }
}

extension ViewController {
  fileprivate func configureViewModel() {
    animeViewModel.alert = { [weak self] msg in
      self?.searchController.isActive = false
      self?.showAlert(message: msg)
    }
    animeViewModel.newData = { [weak self] in
      print("The data source was updated!")
      self?.tableView.reloadData()
    }
  }
}

extension ViewController: UISearchControllerDelegate, UISearchBarDelegate {
  private func setSearchBar() {
    searchController = UISearchController(searchResultsController: nil)
    self.navigationItem.searchController = searchController
    searchController.delegate = self
    searchController.searchBar.delegate = self
    searchController.obscuresBackgroundDuringPresentation = false
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let text = searchBar.text, text.count > 1 else { return }
    
    self.tableView.reloadData()
    
    animeViewModel.search(text: text) {
      print("The search was completed.")
    }
    
    searchController.searchBar.resignFirstResponder()
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    self.animeViewModel.dataSource.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)
            as? SearchCell else { return UITableViewCell() }
    
    cell.viewModel = self.animeViewModel.dataSource[indexPath.row]
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    UITableView.automaticDimension
  }
}




