//
//  Router.swift
//  MVP-Level One
//
//  Created by Damir Lutfullin on 14.10.2020.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol)
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetail(comment: Comment?)
    func popToRoot()
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    required init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        guard let navigationController = self.navigationController,
              let initialController = assemblyBuilder?.createMainModule(router: self) else { return }
        navigationController.viewControllers = [initialController]
    }
    
    func showDetail(comment: Comment?) {
        guard let navigationController = self.navigationController,
              let detailViewController = assemblyBuilder?.createDetailModule(comment: comment, router: self) else { return }
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func popToRoot() {
        guard let navigationController = self.navigationController else { return }
        navigationController.popViewController(animated: true)
    }
}
