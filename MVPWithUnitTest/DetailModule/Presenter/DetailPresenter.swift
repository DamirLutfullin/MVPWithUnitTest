//
//  DetailPresenter.swift
//  MVP-Level One
//
//  Created by Damir Lutfullin on 14.10.2020.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    var detailPresenter: DetailPresenterProtocol! {get set}
    func setComment(comment: Comment?)
}

protocol DetailPresenterProtocol: AnyObject {
    var comment: Comment? {get}
    init(view: DetailViewProtocol, router: RouterProtocol, comment: Comment?)
    func setDetailComment()
    func tapToBack()
}


class DetailPresenter: DetailPresenterProtocol {

    var comment: Comment?
    var router: RouterProtocol
    weak var detailView: DetailViewProtocol!
    
    required init(view detailView: DetailViewProtocol, router: RouterProtocol, comment: Comment?) {
        self.detailView = detailView
        self.comment = comment
        self.router = router
    }
    
    func setDetailComment() {
        detailView.setComment(comment: comment)
    }
    
    func tapToBack() {
        router.popToRoot()
    }
    
}
