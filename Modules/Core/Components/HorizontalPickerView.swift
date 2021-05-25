//
//  HorizontalPickerView.swift
//  Core
//
//  Created by Lucas Marques Bigh (P) on 19/04/21.
//

import UIKit

protocol HorizontalPickerViewDelegate: NSObjectProtocol {
    func pickerView(_ pickerView: HorizontalPickerView, didSelectRow row: Int, inComponent component: Int)
    func pickerView(_ pickerView: HorizontalPickerView, rowHeightForComponent component: Int) -> CGFloat
}

protocol HorizontalPickerViewDataSource: NSObjectProtocol {
    func numberOfComponents(in pickerView: HorizontalPickerView) -> Int
    func pickerView(_ pickerView: HorizontalPickerView, numberOfRowsInComponent component: Int) -> Int
    func pickerView(_ pickerView: HorizontalPickerView, titleForRow row: Int, forComponent component: Int) -> String?
}

class HorizontalPickerView: UIView {
    
    weak var delegate: HorizontalPickerViewDelegate?
    weak var dataSource: HorizontalPickerViewDataSource?
    
    private let pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.transform = CGAffineTransform(rotationAngle: -90 * (.pi / 180))
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    var selectedRow: Int {
        get {
            return pickerView.selectedRow(inComponent: 0)
        }
        set {
            pickerView.selectRow(newValue, inComponent: 0, animated: false)
        }
    }
    
    private func commonInit() {
        pickerView.dataSource = self
        pickerView.delegate = self
        addSubview(pickerView)
        pickerView.addAnchors([.width(equalTo: heightAnchor),
                               .height(equalTo: widthAnchor),
                               .centerX(equalTo: centerXAnchor),
                               .centerY(equalTo: centerYAnchor)])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func selectRow(_ row: Int, inComponent component: Int = 0, animated: Bool) {
        pickerView.selectRow(row, inComponent: component, animated: animated)
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: row, inComponent: component)
    }
    
    func selectNextRow(inComponent component: Int = 0, animated: Bool) {
        pickerView.selectRow(selectedRow() + 1, inComponent: component, animated: animated)
    }
    
    func selectPreviousRow(inComponent component: Int = 0, animated: Bool) {
        pickerView.selectRow(selectedRow() - 1, inComponent: component, animated: animated)
    }
    
    func selectedRow(inComponent component: Int = 0) -> Int {
        return pickerView.selectedRow(inComponent: component)
    }
}

extension HorizontalPickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return dataSource?.numberOfComponents(in: self) ?? 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource?.pickerView(self, numberOfRowsInComponent: component) ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource?.pickerView(self, titleForRow: row, forComponent: component)
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let modeView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        let modeLabel = UILabel(frame: modeView.bounds)
        modeLabel.textColor = .white
        modeLabel.font = .systemFont(ofSize: 17, weight: .bold)
        modeLabel.text = dataSource?.pickerView(self, titleForRow: row, forComponent: component)
        modeLabel.textAlignment = .center
        
        modeView.addSubview(modeLabel)
        modeView.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))
        return modeView
    }
}

extension HorizontalPickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return delegate?.pickerView(self, rowHeightForComponent: component) ?? 100
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.pickerView(self, didSelectRow: row, inComponent: component)
    }
}
