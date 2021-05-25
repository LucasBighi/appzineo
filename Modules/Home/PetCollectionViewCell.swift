//
//  PetCollectionViewCell.swift
//  Appzineo
//
//  Created by Lucas Marques Bigh (P) on 21/05/21.
//

import UIKit

class PetCollectionViewCell: UICollectionViewCell {
    
    private var newPetLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 50)
        label.textColor = .purple
        label.text = "+"
        return label
    }()
    
    private var petImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var petNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .heavy)
        label.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        label.textColor = .white
        return label
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 15
        contentView.backgroundColor = .lightGray
        setupNewPetLabel()
    }
    
    func setup(withPet pet: Pet) {
        newPetLabel.isHidden = true
        setupPetImageView(petImage: pet.image)
        setupPetNameLabel(petName: pet.name)
    }
    
    private func setupNewPetLabel() {
        contentView.addSubview(newPetLabel)
        newPetLabel.addAnchors([.top(equalTo: contentView.topAnchor),
                                .leading(equalTo: contentView.leadingAnchor),
                                .trailing(equalTo: contentView.trailingAnchor),
                                .bottom(equalTo: contentView.bottomAnchor)])
        
    }
    
    private func setupPetImageView(petImage: UIImage?) {
        contentView.addSubview(petImageView)
        petImageView.addAnchors([.top(equalTo: contentView.topAnchor),
                                 .leading(equalTo: contentView.leadingAnchor),
                                 .trailing(equalTo: contentView.trailingAnchor),
                                 .bottom(equalTo: contentView.bottomAnchor)])
        petImageView.image = petImage
    }
    
    private func setupPetNameLabel(petName: String) {
        contentView.addSubview(petNameLabel)
        petNameLabel.addAnchors([.bottom(equalTo: contentView.bottomAnchor),
                                 .leading(equalTo: contentView.leadingAnchor),
                                 .trailing(equalTo: contentView.trailingAnchor)])
        petNameLabel.text = petName
    }
}
