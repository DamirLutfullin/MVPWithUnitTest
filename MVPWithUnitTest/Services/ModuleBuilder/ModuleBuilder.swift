//
//  ModuleBuilder.swift
//  MVP-Level One
//
//  Created by Damir Lutfullin on 13.10.2020.
//

import UIKit

protocol AssemblyBuilderProtocol: AnyObject {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(comment: Comment?, router: RouterProtocol) -> UIViewController
}

class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let networkService = NetworkService()
        let view = MainViewController()
        let presenter = MainPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createDetailModule(comment: Comment?, router: RouterProtocol) -> UIViewController {
        let storyBoard: UIStoryboard = UIStoryboard(name: "DetailStoryboard", bundle: nil)
        let detailViewController = storyBoard.instantiateViewController(withIdentifier: "DetailStoryboard") as! DetailViewController
        let presenter = DetailPresenter(view: detailViewController, router: router, comment: comment)
        detailViewController.detailPresenter = presenter
        return detailViewController
    }
}
