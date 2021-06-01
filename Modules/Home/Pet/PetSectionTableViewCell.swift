//
//  PetSectionTableViewCell.swift
//  Appzineo
//
//  Created by Lucas Marques Bigh (P) on 25/05/21.
//

import UIKit

class PetSectionTableViewCell: UITableViewCell {
    
    private var pets = [Pet]()
    private var presentingViewController: HomeViewController?
    
    private let petsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 200)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
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
        contentView.backgroundColor = .white
        setupHomeCollectionView()
    }
    
    func setup(withPets pets: [Pet], presentingViewController: HomeViewController) {
        self.pets = pets
        self.presentingViewController = presentingViewController
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                let navController = AppzineoModalNavigationController(rootViewController: NewPetViewController())
                navController.modalDelegate = presentingViewController
                presentingViewController?.present(navController, animated: true)
            } else {
                //Show Pet details View Controller
            }
        default:
            break
        }
    }
}
