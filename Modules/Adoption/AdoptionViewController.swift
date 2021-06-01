//
//  AdoptionViewController.swift
//  HugAPet
//
//  Created by Lucas Marques Bigh (P) on 07/04/21.
//

import UIKit

public class AdoptionViewController: UIViewController {
    
    private var viewModel = AdoptionViewModel.shared
    
    private let locationButton: UIButton = {
        let button = UIButton()
        button.setTitle("---", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1)
        button.tintColor = .black
        button.layer.cornerRadius = 20
        return button
    }()
    
    private let petTypeSegmentedControl: AppzineoSegmentedControl = {
        let petTypeSegmentedControl = AppzineoSegmentedControl()
        return petTypeSegmentedControl
    }()

    private let adoptionCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(AdoptionCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private let newAdoptionButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.backgroundColor = .purple
        button.tintColor = .white
        button.layer.cornerRadius = 20
        return button
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = AppzineoBarButtonItem(image: UIImage(named: "plus"), tint: .white) {
            let navController = AppzineoModalNavigationController(rootViewController: NewScheduleViewController())
            
            self.present(navController, animated: true)
        }
        setupLocationButton()
        setupPetTypeScrollView()
        setupAdoptionCollectionView()
        setupNewAdoptionButton()
        getAdoptions()
    }
    
    private func getAdoptions() {
        viewModel.getAdoptions {
            self.adoptionCollectionView.reloadData()
        }
    }
    
    private func setupLocationButton() {
        view.addSubview(locationButton)
        locationButton.addAnchors([.top(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                                   .leading(equalTo: view.leadingAnchor, constant: 50),
                                   .trailing(equalTo: view.trailingAnchor, constant: -50),
                                   .height(constant: 40)])
        viewModel.getUserReverseGeocodeLocation { placemark in
            guard let placemark = placemark,
                  let subLocality = placemark.subLocality,
                  let locality = placemark.locality,
                  let isoCountryCode = placemark.isoCountryCode else { return }
            let buttonTitle = "\(subLocality), \(locality) - \(isoCountryCode)"
            DispatchQueue.main.async {
                self.locationButton.setTitle(buttonTitle, for: .normal)
            }
        }
    }
    
    private func setupPetTypeScrollView() {
        view.addSubview(petTypeSegmentedControl)
        petTypeSegmentedControl.addAnchors([.top(equalTo: locationButton.bottomAnchor, constant: 18),
                                            .leading(equalTo: view.leadingAnchor, constant: 18),
                                            .trailing(equalTo: view.trailingAnchor, constant: -18),
                                            .height(constant: 50)])
    }
    
    private func setupAdoptionCollectionView() {
        view.addSubview(adoptionCollectionView)
        adoptionCollectionView.delegate = self
        adoptionCollectionView.dataSource = self
        adoptionCollectionView.addAnchors([.top(equalTo: petTypeSegmentedControl.bottomAnchor, constant: 0),
                                           .leading(equalTo: view.leadingAnchor, constant: 18),
                                           .trailing(equalTo: view.trailingAnchor, constant: -18),
                                           .bottom(equalTo: view.bottomAnchor, constant: -18)])
    }
    
    private func setupNewAdoptionButton() {
        view.addSubview(newAdoptionButton)
        newAdoptionButton.addAnchors([.bottom(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -18),
                                      .trailing(equalTo: view.trailingAnchor, constant: -18),
                                      .width(constant: 40, aspectRadio: true)])
        newAdoptionButton.addTarget(self, action: #selector(newAdoptionAction), for: .touchUpInside)
    }
    
    @objc private func newAdoptionAction() {
        let alert = UIAlertController(title: "Nova Adoção", message: "Como deseja criar a adoção?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "De um pet da minha lista", style: .default) {_ in
            let petsAlert = UIAlertController(title: "Qual pet?", message: "Selecione...", preferredStyle: .actionSheet)
            for pet in PetViewModel.shared.pets {
                petsAlert.addAction(UIAlertAction(title: pet.name, style: .default, handler: {_ in
                    self.viewModel.newAdoption(with: pet, at: self)
                }))
            }
            petsAlert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
            self.present(petsAlert, animated: true)
        })
        alert.addAction(UIAlertAction(title: "Com novo pet", style: .default) {_ in
            self.viewModel.newAdoption(at: self)
        })
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        present(alert, animated: true)
    }
}

extension AdoptionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.adoptions.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? AdoptionCollectionViewCell {
            let adoption = viewModel.adoptions[indexPath.row]
            cell.setup(with: adoption, and: viewModel.getPet(ofAdoption: adoption), isOdd: indexPath.row % 2 == 0)
            return cell
        }
        return UICollectionViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.showAdoptionDetail(at: indexPath, at: self)
    }
}

extension AdoptionViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = indexPath.row % 2 == 0 ? 0 : 100
        return CGSize(width: (collectionView.bounds.width / 2) - 20, height: 200 + padding)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: -50, left: 10, bottom: 0, right: -10)
    }
}
