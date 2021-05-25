//
//  PickerTextField.swift
//  SpreadSheet
//
//  Created by Lucas Marques Bigh (P) on 05/05/21.
//

import UIKit

protocol PickerTextFieldDelegate: NSObjectProtocol {
    func pickerTextField(_ pickerTextField: PickerTextField, didSelectRow row: Int)
}

class PickerTextField: UITextField {
    
    weak var pickerTextFieldDelegate: PickerTextFieldDelegate?
    
    var items: [String]
    
    var selectedItem: String {
        return items[pickerView.selectedRow(inComponent: 0)]
    }
    
    var selectedRow: Int {
        return pickerView.selectedRow(inComponent: 0)
    }
    
    private let pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    override init(frame: CGRect) {
        self.items = []
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        self.items = []
        super.init(coder: coder)
        commonInit()
    }
    
    convenience init(items: [String]) {
        self.init()
        self.items = items
        commonInit()
    }
    
    func reloadComponents() {
        pickerView.reloadAllComponents()
    }
    
    private func commonInit() {
        addTarget(self, action: #selector(didBeginEditing), for: .editingDidBegin)
        pickerView.delegate = self
        pickerView.dataSource = self
        inputView = pickerView
        text = items.first
        pickerView.selectRow(0, inComponent: 0, animated: false)
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = .systemBlue
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(doneAction(_:)))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancelar", style: .done, target: self, action: #selector(resignFirstResponder))
        
        toolBar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        inputAccessoryView = toolBar
    }
    
    @objc private func doneAction(_ sender: UIBarButtonItem) {
        resignFirstResponder()
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        pickerTextFieldDelegate?.pickerTextField(self, didSelectRow: selectedRow)
        text = items[selectedRow]
    }
    
    @objc private func didBeginEditing() {
        guard let text = text, let textIndex = items.firstIndex(of: text) else { return }
        pickerView.selectRow(textIndex, inComponent: 0, animated: false)
    }
}

extension PickerTextField: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(items[row])"
    }
}
