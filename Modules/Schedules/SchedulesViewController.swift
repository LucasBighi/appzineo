//
//  SchedulesViewController.swift
//  Schedules
//
//  Created by Lucas Marques Bigh (P) on 09/04/21.
//

import UIKit

class SchedulesViewController: UIViewController {
    
    private let viewModel = ScheduleViewModel.shared
    
    private let monthsPickerView: HorizontalPickerView = {
        let pickerView = HorizontalPickerView()
        pickerView.selectedRow = Date().component(.month) - 1
        return pickerView
    }()
    
    private let calendarCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        collectionView.layer.cornerRadius = 10
        collectionView.register(MonthCollectionViewCell.self, forCellWithReuseIdentifier: "monthCell")
        
        collectionView.layer.shadowColor = UIColor.black.cgColor
        collectionView.layer.shadowOffset = .zero
        collectionView.layer.shadowOpacity = 0.7
        collectionView.layer.shadowRadius = 5
        collectionView.layer.masksToBounds = false
        collectionView.clipsToBounds = false
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let schedulesTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: "eventCell")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let calendarMonthSymbols: [String] = {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "pt-BR")
        return calendar.monthSymbols.map { return $0.capitalized }
    }()
    
    private let calendarCellWidth: CGFloat = 35
    
    private var schedules: [Schedule] = {
        return [Schedule]()
//        return Database.default.getObjects(ofType: Schedule.self).filter { $0.date.hasSame([.day, .month, .year], as: Date()) }
    }()
    
    private var pets = [Pet]()
    
    private var daysArray = [String]()
    private var selectedIndexPath: IndexPath = {
        return IndexPath(row: 5 + Date().firstWeekDay + Date().component(.day), section: 0)
    }()
    
    private var selectedDate = Date() {
        didSet {
            getDays()
            getSchedules()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction))
        add.tintColor = .white
        navigationItem.rightBarButtonItem = add
        setupPurpleView()
        setupMonthsPickerView()
        setupCalendarCollectionView()
        setupSchedulesTableView()
        Database.default.get(Pet.self) { result in
            switch result {
            case .success(let pets):
                self.pets = pets
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        monthsPickerView.selectRow(Date().component(.month) - 1, animated: false)
    }
    
    private func getSchedules() {
        
        Database.default.get(Pet.self, completion: { result in
            switch result {
            case .success(let pets):
                self.schedules = self.viewModel.getSchedules(inDate: self.selectedDate)
                self.schedulesTableView.reloadSections(IndexSet(integer: 0), with: .fade)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    private func setupPurpleView() {
        let purpleView = UIView()
        purpleView.backgroundColor = .purple
        view.addSubview(purpleView)
        purpleView.addAnchors([.top(equalTo: view.topAnchor),
                               .leading(equalTo: view.leadingAnchor),
                               .trailing(equalTo: view.trailingAnchor),
                               .height(constant: 250)])
    }
    
    private func setupMonthsPickerView() {
        monthsPickerView.dataSource = self
        monthsPickerView.delegate = self
        view.addSubview(monthsPickerView)
        monthsPickerView.addAnchors([.top(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     .leading(equalTo: view.leadingAnchor, constant: 20),
                                     .trailing(equalTo: view.trailingAnchor, constant: -20),
                                     .height(constant: 40)])
        
        let previousButton = PetsCoArrowButton(arrowImage: #imageLiteral(resourceName: "left-arrow"))
        previousButton.addTarget(self, action: #selector(previousAction), for: .touchUpInside)
        previousButton.tintColor = .white
        view.addSubview(previousButton)
        previousButton.addAnchors([.leading(equalTo: view.leadingAnchor, constant: 10),
                                   .centerY(equalTo: monthsPickerView.centerYAnchor),
                                   .width(constant: 25, aspectRadio: true)])
        
        let nextButton = PetsCoArrowButton(arrowImage: #imageLiteral(resourceName: "right-arrow"))
        nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        nextButton.tintColor = .white
        view.addSubview(nextButton)
        nextButton.addAnchors([.trailing(equalTo: view.trailingAnchor, constant: -10),
                               .centerY(equalTo: monthsPickerView.centerYAnchor),
                               .width(constant: 25, aspectRadio: true)])
    }
    
    @objc private func addAction() {
        let navController = AppzineoModalNavigationController(rootViewController: NewScheduleViewController())
        navController.modalDelegate = self
        present(navController, animated: true)
    }
    
    @objc private func previousAction() {
        let currentRow = monthsPickerView.selectedRow()
        if currentRow > 0 {
            monthsPickerView.selectRow(currentRow - 1, animated: true)
        }
    }
    
    @objc private func nextAction() {
        let currentRow = monthsPickerView.selectedRow()
        if currentRow < 11 {
            monthsPickerView.selectRow(currentRow + 1, animated: true)
        }
    }
    
    private func setupCalendarCollectionView() {
        calendarCollectionView.dataSource = self
        calendarCollectionView.delegate = self
        view.addSubview(calendarCollectionView)
        calendarCollectionView.addAnchors([.top(equalTo: monthsPickerView.bottomAnchor, constant: 10),
                                           .height(constant: 7 * calendarCellWidth, aspectRadio: true),
                                           .centerX(equalTo: view.centerXAnchor)])
    }
    
    private func getDays() {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "pt-BR")
        
        daysArray = calendar.shortWeekdaySymbols.map { return $0.capitalized }
        daysArray.append(contentsOf: (1..<selectedDate.firstWeekDay).map {_ in return ""})
        daysArray.append(contentsOf: (1...selectedDate.getDaysInMonth()).map {return "\($0)"})
        
        calendarCollectionView.reloadSections(IndexSet(integer: 0))
    }
    
    private func setupSchedulesTableView() {
        schedulesTableView.delegate = self
        schedulesTableView.dataSource = self
        view.addSubview(schedulesTableView)
        schedulesTableView.addAnchors([.top(equalTo: calendarCollectionView.bottomAnchor, constant: 10),
                                       .leading(equalTo: view.leadingAnchor, constant: 20),
                                       .trailing(equalTo: view.trailingAnchor, constant: -20),
                                       .bottom(equalTo: view.bottomAnchor)])
    }
}

extension SchedulesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventTableViewCell {
            cell.setup(withSchedule: schedules[indexPath.row], ofPet: pets[0])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerLabel = UILabel()
        headerLabel.backgroundColor = .white
        if selectedDate.hasSame([.year, .month, .day], as: Date()) {
            headerLabel.text = "Eventos hoje"
        } else if selectedDate.hasSame([.year, .month], as: Date()) {
            headerLabel.text = "Eventos do dia \(selectedDate.component(.day))"
        } else {
            headerLabel.text = "Eventos do dia \(selectedDate.withFormat("dd/MM"))"
        }
        headerLabel.font = .systemFont(ofSize: 20, weight: .bold)
        return headerLabel
    }
}

extension SchedulesViewController: HorizontalPickerViewDelegate, HorizontalPickerViewDataSource {
    func pickerView(_ pickerView: HorizontalPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return calendarMonthSymbols[row]
    }
    
    func numberOfComponents(in pickerView: HorizontalPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: HorizontalPickerView, numberOfRowsInComponent component: Int) -> Int {
        return calendarMonthSymbols.count
    }
    
    func pickerView(_ pickerView: HorizontalPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
    
    func pickerView(_ pickerView: HorizontalPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedDate = selectedDate.setting(row + 1, toComponent: .month)
    }
}

extension SchedulesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "monthCell", for: indexPath) as? MonthCollectionViewCell {
            if let day = Int(daysArray[indexPath.row]) {
                let month = selectedDate.component(.month)
                let year = selectedDate.component(.year)
                let cellDate = Date(day: day, month: month, year: year)
                let cellSchedules = schedules.filter { $0.date.hasSame([.year, .month, .day], as: cellDate) }
                cell.setup(withDate: cellDate, hasSchedules: !cellSchedules.isEmpty)
                if selectedIndexPath == indexPath {
                    cell.makeSelected()
                }
            } else {
                cell.setup(withWeekDay: daysArray[indexPath.row], onMonth: selectedDate.component(.month))
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: calendarCellWidth, height: calendarCellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? MonthCollectionViewCell,
           let selectedCell = collectionView.cellForItem(at: selectedIndexPath) as? MonthCollectionViewCell,
           let day = Int(daysArray[indexPath.row]),
           let selectedDay = Int(daysArray[selectedIndexPath.row]) {
            let selectedCellDate = selectedDate.setting(selectedDay, toComponent: .day)
            cell.makeSelected()
            let cellSchedules = schedules.filter { $0.date.hasSame([.year, .month, .day], as: selectedCellDate) }
            selectedCell.setup(withDate: selectedCellDate, hasSchedules: !cellSchedules.isEmpty)
            selectedIndexPath = indexPath
            selectedDate = selectedDate.setting(day, toComponent: .day)
        }
    }
}

extension SchedulesViewController: AppzineoModalNavigationControllerDelegate {
    func didDisappear() {
        getSchedules()
    }
}
