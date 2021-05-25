//
//  PetSectionTableViewCell.swift
//  Appzineo
//
//  Created by Lucas Marques Bigh (P) on 25/05/21.
//

import UIKit

class PetSectionTableViewCell: UITableViewCell {
    
    private var pets = [Pet]()
    
    private let petsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 150, height: 150)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(PetCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        contentView.backgroundColor = .blue
        setupHomeCollectionView()
    }
    
    func setup(withPets pets: [Pet]) {
        self.pets = pets
        petsCollectionView.reloadData()
    }
    
    private func setupHomeCollectionView() {
        contentView.addSubview(petsCollectionView)
        petsCollectionView.delegate = self
        petsCollectionView.dataSource = self
        petsCollectionView.addAnchors([.top(equalTo: contentView.topAnchor),
                                       .leading(equalTo: contentView.leadingAnchor),
                                       .trailing(equalTo: contentView.trailingAnchor),
                                       .bottom(equalTo: contentView.bottomAnchor)])
    }

}

extension PetSectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pets.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PetCollectionViewCell
        if indexPath.row != 0 {
            cell.setup(withPet: pets[indexPath.row - 1])
        }
        return cell
    }
}
