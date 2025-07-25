//
//  ProfileVC.swift
//  PaginationDemo
//
//  Created by Durvesh Manjhi on 22/07/25.
//


import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userCount: UILabel!
    
    let viewModel = UserViewModel()
    var spinner = UIActivityIndicatorView(style: .medium)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupSpinner()
//        viewModel.loadData {userCount in 
//            self.tableView.reloadData()
//            self.userCount.text = "Users Data : \(userCount)"
//        }
        
        Task{
            do{
                let count = try await viewModel.loadDataAsync()
                self.tableView.reloadData()
                self.userCount.text = "Users Data : \(count)"
            }catch{
                print("Error loading users: \(error.localizedDescription)")
                self.userCount.text = "Failed to load users"
            }
        }
        
        
    }
    
    private func setupTableView() {
        
        let nib = UINib(nibName: "UserCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "UserCell")
    }
    
    private func setupSpinner() {
        spinner.hidesWhenStopped = true
        spinner.color = .gray
        spinner.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44)
        tableView.tableFooterView = spinner
    }
    
    private func loadMoreIfNeeded(for indexPath: IndexPath) {
        if indexPath.row == viewModel.visibleUsers.count - 1 && viewModel.hasmore && !viewModel.isLoading {
            spinner.startAnimating()
            viewModel.isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.viewModel.loadMore()
                self.viewModel.isLoading = false
                self.spinner.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableView DataSource & Delegate

extension ProfileVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count ",viewModel.visibleUsers.count)
        return viewModel.visibleUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell else {
            return UITableViewCell()
        }

        let user = viewModel.visibleUsers[indexPath.row]
        cell.configure(with: user) // Ensure you have this method in your cell
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        loadMoreIfNeeded(for: indexPath)
    }
}
