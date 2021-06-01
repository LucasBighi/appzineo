//
//  MonthCollectionViewCell.swift
//  Schedules
//
//  Created by Lucas Marques Bigh (P) on 09/04/21.
//

import UIKit

class MonthCollectionViewCell: UICollectionViewCell {
    
    let monthNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        return label
    }()
    
    let markerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = 2.5
        view.isHidden = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        contentView.clipsToBounds = true
        setupMonthNameLabel()
        setupMarkerView()
    }
    
    private func setupMonthNameLabel() {
        contentView.addSubview(monthNameLabel)
        monthNameLabel.addAnchors([.top(equalTo: contentView.topAnchor, constant: 2.5),
                                   .bottom(equalTo: contentView.bottomAnchor, constant: -2.5),
                                   .leading(equalTo: contentView.leadingAnchor, constant: 2.5),
                                   .trailing(equalTo: contentView.trailingAnchor, constant: -2.5)])
    }
    
    private func setupMarkerView() {
        contentView.addSubview(markerView)
        markerView.addAnchors([.centerX(equalTo: contentView.centerXAnchor),
                               .bottom(equalTo: contentView.bottomAnchor),
                               .height(constant: 5, aspectRadio: true)])
    }
    
    func setup(withDate date: Date, hasSchedules: Bool) {
        monthNameLabel.backgroundColor = .white
        markerView.isHidden = !hasSchedules
        monthNameLabel.text = "\(date.component(.day))"
        monthNameLabel.textColor = date.isToday ? .purple : .black
        monthNameLabel.font = .systemFont(ofSize: 17)
    }
    
    func setup(withWeekDay weekday: String, onMonth month: Int) {
        monthNameLabel.backgroundColor = .white
        markerView.isHidden = true
        monthNameLabel.text = weekday
        monthNameLabel.textColor = .gray
        monthNameLabel.font = .systemFont(ofSize: 12, weight: .light)
    }
    
    func makeSelected() {
        monthNameLabel.backgroundColor = .purple
        monthNameLabel.textColor = .white
    }
}
