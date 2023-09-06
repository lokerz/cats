//
//  CatsVC.swift
//  Cats
//
//  Created by Ridwan Abdurrasyid on 31/08/23.
//

import UIKit

class CatsVC: BaseVC {
    var viewModel: CatsVM!
    
    lazy var factLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 17)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var animalImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupButton()
        
        self.fetchVM()
    }
    
    override func setupVM() {
        self.viewModel.onTextReceived = { text in
            DispatchQueue.main.async {
                self.factLabel.change(to: "\"\(text)\"")
            }
        }
        self.viewModel.onImageReceived = { image in
            DispatchQueue.main.async {
                self.animalImage.change(to: image)
                self.nextButton.enableButton()
            }
        }
    }
    
    
    
    @objc func fetchVM() {
        self.nextButton.disableButton()
        self.viewModel.fetch()
    }

    func setupUI() {
        self.view.backgroundColor = .white
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = -12
        
        let view = UIView()
        view.backgroundColor = .white
        view.makeRounded(radius: 16)
        view.addSubview(self.factLabel)

        let buttonView = UIView()
        buttonView.addSubview(self.nextButton)
        
        self.view.addSubview(stackView)
        stackView.bindFrameToSafeBounds(bottom: 24)
        stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = false
        stackView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true


        stackView.addArrangedSubview(self.animalImage)
        self.animalImage.translatesAutoresizingMaskIntoConstraints = false
        self.animalImage.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.6).isActive = true
        
        stackView.addArrangedSubview(view)
        self.factLabel.bindFrameToSuperviewBounds(left: 24, right: 24)
        
        stackView.addArrangedSubview(buttonView)
        self.nextButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.nextButton.bindFrameToSuperviewBounds(left: 12, right: 12)
    }
    
    func setupButton() {
        self.nextButton.setTitle("More Cat Facts?", for: .normal)
        self.nextButton.addTarget(self, action: #selector(fetchVM), for: .touchUpInside)
    }
}
