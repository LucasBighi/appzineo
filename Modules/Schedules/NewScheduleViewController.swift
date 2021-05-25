//
//  NewScheduleViewController.swift
//  Schedules
//
//  Created by Lucas Marques Bigh (P) on 20/04/21.
//

import UIKit

class NewScheduleViewController: UIViewController {
    
    private var pets = [Pet]()
    
    private let scheduleTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Tipo"
        return label
    }()
    
    private let scheduleTypePicker: PickerTextField = {
        let picker = PickerTextField(items: ["Veterinário", "Medicação", "Comida"])
        picker.borderStyle = .roundedRect
        return picker
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Título"
        textField.textAlignment = .left
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let petLabel: UILabel = {
        let label = UILabel()
        label.text = "Pra qual pet?"
        return label
    }()
    
    private let petPicker: PickerTextField = {
        let picker = PickerTextField()
        picker.placeholder = "Carregando..."
        picker.borderStyle = .roundedRect
        return picker
    }()
    
    private let locationTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Onde?"
        textField.textAlignment = .left
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(editingDidBegin(_:)), for: .editingDidBegin)
        return textField
    }()
    
    private let dateDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Quando?"
        return label
    }()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.date = Date()
        return datePicker
    }()
    
    private let repeatLabel: UILabel = {
        let label = UILabel()
        label.text = "Repete?"
        return label
    }()
    
    private let repeatSwitch: UISwitch = {
        let `switch` = UISwitch()
        `switch`.addTarget(self, action: #selector(switchRepeat(_:)), for: .valueChanged)
        return `switch`
    }()
    
    private let repeatTimesPicker: PickerTextField = {
        let picker = PickerTextField(items: (1...60).map { return "\($0)" })
        picker.borderStyle = .roundedRect
        return picker
    }()
    
    private let repeatTimesLabel: UILabel = {
        let label = UILabel()
        label.text = "vezes a cada"
        return label
    }()
    
    private let repeatIntervalPicker: PickerTextField = {
        let picker = PickerTextField(items: (1...60).map { return "\($0)" })
        picker.borderStyle = .roundedRect
        return picker
    }()
    
    private let repeatComponentPicker: PickerTextField = {
        let picker = PickerTextField(items: Calendar.Component.localizedCases.map { return $0.capitalized })
        picker.borderStyle = .roundedRect
        return picker
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSaveButton()
        setupType()
        setupTitleTextField()
        setupPet()
        setupDate()
        setupRepeat()
//        setupLocationTextField()
        setupStackView()
    }
    
    private func setupSaveButton() {
        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAction))
        save.tintColor = .purple
        navigationItem.leftBarButtonItem = save
    }
    
    private func setupType() {
        addHorizontalStackView(withViews: [scheduleTypeLabel, scheduleTypePicker])
    }
    
    private func setupTitleTextField() {
        stackView.addArrangedSubview(titleTextField)
        titleTextField.addAnchors([.width(constant: view.frame.width - 40),
                                   .height(constant: 30)])
    }
    
    private func setupPet() {
        addHorizontalStackView(withViews: [petLabel, petPicker])
        Database.default.get(Pet.self, completion: { result in
            switch result {
            case .success(let pets):
                self.petPicker.placeholder = nil
                self.pets = pets
                self.petPicker.items = pets.map { $0.name }
                self.petPicker.reloadComponents()
            case .failure(let error):
                print(error)
            }
        })
    }
    
    private func setupDate() {
        addHorizontalStackView(withViews: [dateDescriptionLabel, datePicker])
    }
    
    private func setupRepeat() {
        addHorizontalStackView(withViews: [repeatLabel, repeatSwitch])
    }
    
    private func setupLocationTextField() {
        stackView.addArrangedSubview(locationTextField)
        locationTextField.addAnchors([.width(constant: view.frame.width - 40),
                                      .height(constant: 30)])
    }
    
    private func setupStackView() {
        view.addSubview(stackView)
        stackView.addAnchors([.top(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                              .leading(equalTo: view.leadingAnchor, constant: 20),
                              .trailing(equalTo: view.trailingAnchor, constant: -20)])
    }
    
    private func addHorizontalStackView(withViews views: [UIView]) {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 20
        
        for view in views {
            stackView.addArrangedSubview(view)
            if !view.isKind(of: UILabel.self) {
                view.addAnchors([.width(constant: 180)])
            }
        }
        
        self.stackView.addArrangedSubview(stackView)
        stackView.addAnchors([.width(constant: view.frame.width - 40),
                              .height(constant: 40)])
    }
    
    @objc private func switchRepeat(_ sender: UISwitch) {
        if sender.isOn {
            addHorizontalStackView(withViews: [repeatTimesPicker, repeatTimesLabel, repeatIntervalPicker, repeatComponentPicker])
            repeatTimesPicker.addAnchors([.width(constant: 40)])
            repeatIntervalPicker.addAnchors([.width(constant: 40)])
            repeatComponentPicker.addAnchors([.width(constant: 80)])
        } else {
            stackView.removeArrangedSubview(stackView.arrangedSubviews.last!)
        }
    }
    
    @objc private func dismissAction() {
        dismiss(animated: true)
    }
    
    @objc private func saveAction() {
        let type = scheduleTypePicker.selectedItem
        let pet = pets[petPicker.selectedRow]
        guard let title = titleTextField.text else { return }
        let date = datePicker.date
        if repeatSwitch.isOn,
           let repeatTimes = Int(repeatTimesPicker.selectedItem),
           let repeatInterval = Int(repeatIntervalPicker.selectedItem),
           let repeatComponent = Calendar.Component(repeatComponentPicker.selectedItem) {
            for interval in stride(from: 1, to: repeatTimes * repeatInterval, by: repeatInterval) {
                let repeatDate = date.adding(interval, toComponent: repeatComponent)
                let repeatType = RepeatType(interval: repeatInterval, times: repeatTimes, component: repeatComponent)
                let schedule = Schedule(type: type, petId: pet.id, title: title, date: repeatDate, repeatType: repeatType)
                Database.default.save(schedule)
                PushNotification.default.new(title: "\(schedule.type) do \(pet.name)", body: title, scheduledFor: repeatDate)
            }
        } else {
            let schedule = Schedule(type: type, petId: pet.id, title: title, date: date, repeatType: nil)
            Database.default.save(schedule)
            PushNotification.default.new(title: "\(schedule.type) do \(pet.name)", body: title, scheduledFor: date)
        }
        dismissAction()
    }
    
    @objc private func editingDidBegin(_ sender: UITextField) {
        let navController = AppzineoModalNavigationController(rootViewController: ScheduleLocationViewController())
        present(navController, animated: true)
    }
}
