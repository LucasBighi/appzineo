//
//  NewPetViewController.swift
//  Home
//
//  Created by Lucas Marques Bigh (P) on 12/05/21.
//

import UIKit

class NewPetViewController: UIViewController {
    
    private let petImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Nome do Pet"
        textField.textAlignment = .left
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let petTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Tipo"
        return label
    }()
    
    private let petTypePicker: PickerTextField = {
        var types = Breed.allTypes.map { return $0.capitalized }
        types.insert("", at: 0)
        let picker = PickerTextField(items: types)
        picker.borderStyle = .roundedRect
        return picker
    }()
    
    private let petBreedLabel: UILabel = {
        let label = UILabel()
        label.text = "Raça"
        return label
    }()
    
    private let petBreedPicker: PickerTextField = {
        let picker = PickerTextField(items: [""])
        picker.borderStyle = .roundedRect
        return picker
    }()
    
    private let bornDateDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Quando nasceu?"
        return label
    }()
    
    private let bornDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.tintColor = .purple
        datePicker.date = Date()
        return datePicker
    }()
    
    private let genderSegmentedControl: PetsCoSegmentedControl = {
        let segmentedControl = PetsCoSegmentedControl(items: ["Menino", "Menina", "Indefinido"])
        segmentedControl.tintColor = .purple
        return segmentedControl
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
        setupImage()
        setupNameTextField()
        setupType()
        setupBreed()
        setupDate()
        setupGender()
        setupStackView()
    }
    
    private func setupSaveButton() {
        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAction))
        save.tintColor = .purple
        navigationItem.leftBarButtonItem = save
    }
    
    private func setupImage() {
        stackView.addArrangedSubview(petImageView)
        petImageView.addAnchors([.width(constant: 100, aspectRadio: true)])
    }
    
    private func setupNameTextField() {
        stackView.addArrangedSubview(nameTextField)
        nameTextField.addAnchors([.width(constant: view.frame.width - 40),
                                  .height(constant: 30)])
    }
    
    private func setupType() {
        addHorizontalStackView(withViews: [petTypeLabel, petTypePicker])
        petTypePicker.pickerTextFieldDelegate = self
    }
    
    private func setupBreed() {
        addHorizontalStackView(withViews: [petBreedLabel, petBreedPicker])
        petBreedPicker.isEnabled = false
    }
    
    private func setupDate() {
        addHorizontalStackView(withViews: [bornDateDescriptionLabel, bornDatePicker])
    }
    
    private func setupGender() {
        stackView.addArrangedSubview(genderSegmentedControl)
        genderSegmentedControl.addAnchors([.width(constant: view.frame.width - 40),
                                           .height(constant: 50)])
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
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    @objc private func dismissAction() {
        dismiss(animated: true)
    }
    
    @objc private func saveAction() {
        guard let name = nameTextField.text,
              let gender = genderSegmentedControl.selectedItem else { return }
        let breed = Breed(type: petTypePicker.selectedItem.lowercased(),
                          name: petBreedPicker.selectedItem.lowercased())
        let pet = Pet(name: name,
                      breed: breed,
                      image: petImageView.image,
                      bornDate: bornDatePicker.date,
                      gender: Gender(gender))
        Database.default.save(pet)
        dismissAction()
    }

    
}

extension NewPetViewController: PickerTextFieldDelegate {
    func pickerTextField(_ pickerTextField: PickerTextField, didSelectRow row: Int) {
        petBreedPicker.items = Breed.breeds(ofType: petTypePicker.selectedItem).map { return $0.name.capitalized }
        petBreedPicker.reloadComponents()
        petBreedPicker.isEnabled = true
        petBreedPicker.text = nil
    }
}
