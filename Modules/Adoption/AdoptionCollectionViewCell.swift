//
//  AdoptionCollectionViewCell.swift
//  HugAPet
//
//  Created by Lucas Marques Bigh (P) on 07/04/21.
//

import UIKit

class AdoptionCollectionViewCell: UICollectionViewCell {
    
    private let petImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let petNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let petBreedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let petAgeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let petGenderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func commonInit() {
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        
//        setupPetNameLabel()
//        setupPetBreedLabel()
//        setupPetBreedLabel()
//        setupPetGenderLabel()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func setupPetImageView(isOdd: Bool) {
        contentView.addSubview(petImageView)
        petImageView.addAnchors([.top(equalTo: contentView.topAnchor, constant: isOdd ? 0 : 100),
                                 .leading(equalTo: contentView.leadingAnchor),
                                 .trailing(equalTo: contentView.trailingAnchor),
                                 .bottom(equalTo: contentView.bottomAnchor)])
        
    }
    
    private func setupPetNameLabel() {
        contentView.addSubview(petNameLabel)
        petNameLabel.addAnchors([.top(equalTo: contentView.topAnchor),
                                 .leading(equalTo: contentView.leadingAnchor),
                                 .bottom(equalTo: contentView.bottomAnchor),
                                 .trailing(equalTo: contentView.trailingAnchor)])
    }
    
    private func setupPetBreedLabel() {
        contentView.addSubview(petBreedLabel)
    }
    
    private func setupPetAgeLabel() {
        contentView.addSubview(petAgeLabel)
    }
    
    private func setupPetGenderLabel() {
        contentView.addSubview(petGenderLabel)
    }
    
    func setup(with adoption: Adoption, and pet: Pet?, isOdd: Bool) {
        setupPetImageView(isOdd: isOdd)
        petImageView.backgroundColor = .green
        petImageView.image = #imageLiteral(resourceName: "bordercollie") //pet?.image
        petNameLabel.text = pet?.name
        petBreedLabel.text = pet?.breed.name
        petAgeLabel.text = pet?.age
        petGenderLabel.text = pet?.gender.rawValue.capitalized
    }
}
