//
//  HomeViewController.swift
//  Home
//
//  Created by Lucas Marques Bigh (P) on 12/05/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let viewModel = HomeViewModel.shared
    
    private let homeTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .white
        tableView.register(PetSectionTableViewCell.self, forCellReuseIdentifier: "petCell")
        tableView.register(ScheduleSectionTableViewCell.self, forCellReuseIdentifier: "scheduleCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHomeTableView()
        getHomeData()
    }
    
    private func getHomeData() {
        viewModel.getHomeData {
            self.homeTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .right)
            self.homeTableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .right)
        }
    }
    
    private func setupHomeTableView() {
        view.addSubview(homeTableView)
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.addAnchors([.top(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                                  .leading(equalTo: view.leadingAnchor, constant: 10),
                                  .trailing(equalTo: view.trailingAnchor, constant: -10),
                                  .bottom(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)])
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "petCell", for: indexPath) as! PetSectionTableViewCell
            if let pets = viewModel.sectionData(at: indexPath.section) as? [Pet] {
                cell.setup(withPets: pets, presentingViewController: self)
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! ScheduleSectionTableViewCell
            if let schedules = viewModel.sectionData(at: indexPath.section) as? [Schedule] {
                cell.setup(withSchedules: schedules, presentingViewController: self)
            }
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerLabel = UILabel()
        headerLabel.backgroundColor = .white
        headerLabel.font = .systemFont(ofSize: 20, weight: .bold)
        headerLabel.textColor = .purple
        headerLabel.text = viewModel.title(of: section)
        return headerLabel
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

extension HomeViewController: AppzineoModalNavigationControllerDelegate {
    func didDisappear() {
        homeTableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
}
