//
//  AdoptionDetailViewController.swift
//  HugAPet
//
//  Created by Lucas Marques Bigh (P) on 09/04/21.
//

import UIKit

class AdoptionDetailViewController: UIViewController {
    
    private let petImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let infosView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 5
        view.layer.masksToBounds = false
        view.clipsToBounds = false
        return view
    }()
    
    private let petNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .labelBlack
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        return label
    }()
    
    private let petBreedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .labelBlack
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    private let petGenderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .labelBlack
        return imageView
    }()
    
    private let addressImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "location"))
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .labelBlack
        return imageView
    }()
    
    private let adoptionAddressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .labelBlack
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    private let petAgeImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "clock"))
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .labelBlack
        return imageView
    }()
    
    private let petAgeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .labelBlack
        return label
    }()
    
    private let petOwnerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .lightGray
        imageView.layer.cornerRadius = 40
        return imageView
    }()
    
    private let petOwnerNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .labelBlack
        label.font = .systemFont(ofSize: 20, weight: .heavy)
        return label
    }()
    
    private let adoptionDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .labelBlack
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    private let ownerPhoneButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let adoptionDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .labelBlack
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    private let viewModel = AdoptionViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBarController?.tabBar.isHidden = true
        setupNavigationBar()
        setupPetImageView()
        setupInfosView()
        setupPetNameLabel()
        setupPetGenderImageView()
        setupPetBreedLabel()
        setupPetAgeLabel()
        setupPetAgeImageView()
        setupAddressImageView()
        setupAdoptionAddressLabel()
        setupOwnerImageView()
        setupOwnerNameLabel()
        setupOwnerPhoneButton()
        setupAdoptionDateLabel()
        setupAdoptionDescriptionLabel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setupNavigationBar() {
        navigationItem.setHidesBackButton(true, animated: false)
        
        let leftBarButtonItem = AppzineoBarButtonItem(image: UIImage(named: "back"), tint: .labelBlack) {
            self.navigationController?.popViewController(animated: true)
        }
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        let shareBarButtonItem = AppzineoBarButtonItem(image: UIImage(named: "share"), tint: .labelBlack) {
            
        }
        
        let favoriteBarButtonItem = AppzineoBarButtonItem(image: UIImage(named: "heart"), tint: .labelBlack) {
            
        }
        navigationItem.rightBarButtonItems = [shareBarButtonItem, favoriteBarButtonItem]
    }
    
    private func setupPetImageView() {
        view.addSubview(petImageView)
        petImageView.addAnchors([.top(equalTo: view.topAnchor),
                                 .leading(equalTo: view.leadingAnchor),
                                 .trailing(equalTo: view.trailingAnchor),
                                 .bottom(equalTo: view.centerYAnchor)])
        petImageView.image = #imageLiteral(resourceName: "bordercollie") //viewModel.getPet(ofAdoption: viewModel.selectedAdoption)?.image
    }
    
    private func setupInfosView() {
        view.addSubview(infosView)
        infosView.addAnchors([.centerY(equalTo: petImageView.bottomAnchor),
                              .leading(equalTo: view.leadingAnchor, constant: 15),
                              .trailing(equalTo: view.trailingAnchor, constant: -15)])
    }
    
    private func setupPetNameLabel() {
        infosView.addSubview(petNameLabel)
        petNameLabel.addAnchors([.top(equalTo: infosView.topAnchor, constant: 18),
                                 .leading(equalTo: infosView.leadingAnchor, constant: 18)])
        petNameLabel.text = viewModel.getPet(ofAdoption: viewModel.selectedAdoption)?.name
    }
    
    private func setupPetBreedLabel() {
        infosView.addSubview(petBreedLabel)
        petBreedLabel.addAnchors([.top(equalTo: petNameLabel.bottomAnchor, constant: 18),
                                  .leading(equalTo: petNameLabel.leadingAnchor)])
        petBreedLabel.text = viewModel.getPet(ofAdoption: viewModel.selectedAdoption)?.breed.name.capitalized
    }
    
    private func setupPetGenderImageView() {
        infosView.addSubview(petGenderImageView)
        petGenderImageView.addAnchors([.centerY(equalTo: petNameLabel.centerYAnchor),
                                       .trailing(equalTo: infosView.trailingAnchor, constant: -18),
                                       .height(constant: 15, aspectRadio: true)])
        petGenderImageView.image = viewModel.getPet(ofAdoption: viewModel.selectedAdoption)?.gender.symbol
    }
    
    private func setupPetAgeLabel() {
        infosView.addSubview(petAgeLabel)
        petAgeLabel.addAnchors([.centerY(equalTo: petBreedLabel.centerYAnchor),
                                .trailing(equalTo: petGenderImageView.trailingAnchor)])
        petAgeLabel.text = viewModel.getPet(ofAdoption: viewModel.selectedAdoption)?.age
    }
    
    private func setupPetAgeImageView() {
        infosView.addSubview(petAgeImageView)
        petAgeImageView.addAnchors([.centerY(equalTo: petAgeLabel.centerYAnchor),
                                    .trailing(equalTo: petAgeLabel.leadingAnchor, constant: -5),
                                    .height(constant: 20, aspectRadio: true)])
    }
    
    private func setupAddressImageView() {
        infosView.addSubview(addressImageView)
        addressImageView.addAnchors([.top(equalTo: petBreedLabel.bottomAnchor, constant: 9),
                                     .leading(equalTo: petNameLabel.leadingAnchor),
                                     .height(constant: 15, aspectRadio: true)])
    }
    
    private func setupAdoptionAddressLabel() {
        infosView.addSubview(adoptionAddressLabel)
        adoptionAddressLabel.addAnchors([.centerY(equalTo: addressImageView.centerYAnchor),
                                         .leading(equalTo: addressImageView.trailingAnchor, constant: 0),
                                         .bottom(equalTo: infosView.bottomAnchor, constant: -18)])
        adoptionAddressLabel.text = viewModel.selectedAdoption?.address.fullAddressDescription
    }
    
    private func setupOwnerImageView() {
        view.addSubview(petOwnerImageView)
        petOwnerImageView.addAnchors([.leading(equalTo: view.leadingAnchor, constant: 10),
                                      .top(equalTo: infosView.bottomAnchor, constant: 20),
                                      .width(constant: 80, aspectRadio: true)])
        petOwnerImageView.image = viewModel.getOwner(ofAdoption: viewModel.selectedAdoption)?.image ?? #imageLiteral(resourceName: "user-placeholder")
    }
    
    private func setupOwnerNameLabel() {
        view.addSubview(petOwnerNameLabel)
        petOwnerNameLabel.addAnchors([.bottom(equalTo: petOwnerImageView.centerYAnchor, constant: 5),
                                      .leading(equalTo: petOwnerImageView.trailingAnchor, constant: 10)])
        petOwnerNameLabel.text = viewModel.getOwner(ofAdoption: viewModel.selectedAdoption)?.name ?? "Teste"
    }
    
    private func setupOwnerPhoneButton() {
        view.addSubview(ownerPhoneButton)
        ownerPhoneButton.addAnchors([.top(equalTo: petOwnerImageView.centerYAnchor, constant: 5),
                                     .leading(equalTo: petOwnerImageView.trailingAnchor, constant: 10)])
        
        let attributes: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 14, weight: .light),
                                                          .foregroundColor: UIColor.purple,
                                                          .underlineStyle: NSUnderlineStyle.thick]
        let attributedString = NSMutableAttributedString(string: viewModel.selectedAdoption?.phone ?? "",
                                                         attributes: attributes)
        ownerPhoneButton.setAttributedTitle(attributedString, for: .normal)
        ownerPhoneButton.addTarget(self, action: #selector(callAction(_:)), for: .touchUpInside)
    }
    
    private func setupAdoptionDateLabel() {
        view.addSubview(adoptionDateLabel)
        adoptionDateLabel.addAnchors([.centerY(equalTo: petOwnerNameLabel.centerYAnchor),
                                      .trailing(equalTo: view.trailingAnchor, constant: -10)])
        adoptionDateLabel.text = viewModel.selectedAdoption?.createdAt.withFormat("dd/MM/yyyy")
    }
    
    private func setupAdoptionDescriptionLabel() {
        view.addSubview(adoptionDescriptionLabel)
        adoptionDescriptionLabel.addAnchors([.leading(equalTo: petOwnerImageView.leadingAnchor),
                                             .trailing(equalTo: adoptionDateLabel.trailingAnchor),
                                             .top(equalTo: petOwnerImageView.bottomAnchor, constant: 10)])
        adoptionDescriptionLabel.text = viewModel.selectedAdoption?.description
    }
    
    @objc func backToMain() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func callAction(_ sender: UIButton) {
        if let phone = viewModel.selectedAdoption?.phone, let url = URL(string: "tel://\(phone)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
