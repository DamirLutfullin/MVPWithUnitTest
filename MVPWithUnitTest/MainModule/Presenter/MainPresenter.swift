//
//  MainPresenter.swift
//  MVP-Level One
//
//  Created by Damir Lutfullin on 13.10.2020.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func successfulDownloadOfComments()
    func failedToDownloadComments(error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {
    var comments: [Comment]? {get set}
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func downloadComments()
    func tapOnTheComment(comment: Comment)
}

class MainPresenter: MainViewPresenterProtocol {
  
    var comments: [Comment]?
    var router: RouterProtocol?
    weak var view: MainViewProtocol?
    weak var networkService: NetworkServiceProtocol?
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        downloadComments()
    }

    func downloadComments() {
        networkService?.downloadComments(completion: { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let comments):
                    self.comments = comments
                    self.view?.successfulDownloadOfComments()
                case .failure(let error):
                    self.view?.failedToDownloadComments(error: error)
                }
            }
        })
    }
    
    func tapOnTheComment(comment: Comment) {
        router?.showDetail(comment: comment)
    }
}
