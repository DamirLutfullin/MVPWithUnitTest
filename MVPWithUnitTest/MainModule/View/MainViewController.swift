//
//  ViewController.swift
//  MVP-Level One
//
//  Created by Damir Lutfullin on 13.10.2020.
//

import UIKit

//Выполняет роль вью
class MainViewController: UIViewController {
    
    var presenter: MainViewPresenterProtocol!
    
    //MARK: - IBOutlet
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

//MARK: - MainViewProtocol
extension MainViewController: MainViewProtocol {
    func successfulDownloadOfComments() {
        tableView.reloadData()
    }
    
    func failedToDownloadComments(error: Error) {
        print(error.localizedDescription)
    }
}

//MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.comments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = presenter.comments?[indexPath.row].body
        return cell
    }
}

//MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let comment = presenter.comments?[indexPath.row] else { return }
        presenter.tapOnTheComment(comment: comment)
    }
}


