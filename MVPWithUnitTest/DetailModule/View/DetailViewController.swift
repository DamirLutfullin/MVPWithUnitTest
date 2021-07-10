//
//  DetailViewController.swift
//  MVP-Level One
//
//  Created by Damir Lutfullin on 14.10.2020.
//

import UIKit

class DetailViewController: UIViewController {
    
    var comment: Comment!
    var detailPresenter: DetailPresenterProtocol!
    
    var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("back", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapToBack), for: .touchUpInside)
        return button
    }()
    
    @IBOutlet var detailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailPresenter.setDetailComment()
        self.view.addSubview(backButton)
    }
    
    override func viewDidLayoutSubviews() {
        setBackButton()
    }
    
    func setBackButton() {
        NSLayoutConstraint.activate([
            backButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension DetailViewController: DetailViewProtocol {
    
    @objc func tapToBack() {
        detailPresenter.tapToBack()
    }
    
    func setComment(comment: Comment?) {
        self.detailLabel.text = comment?.body
    }
    
}
