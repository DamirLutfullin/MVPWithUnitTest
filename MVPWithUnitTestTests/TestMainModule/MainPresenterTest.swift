//
//  MainPresenterTest.swift
//  MVP-Level OneTests
//
//  Created by Damir Lutfullin on 13.10.2020.
//

import XCTest
@testable import MVPWithUnitTest

class MokeView: MainViewProtocol {
    func successfulDownloadOfComments() {
    }
    func failedToDownloadComments(error: Error) {
    }
}

class MokeNetworkService: NetworkServiceProtocol {
    
    var comments: [Comment]!
   
    init() {}
    
    init(comment: [Comment]?) {
        self.comments = comment
    }
    
    func downloadComments(completion: @escaping (Result<[Comment], Error>) -> Void) {
        if let comments = comments {
            completion(.success(comments))
        } else {
            completion(.failure(NSError(domain: "0", code: 0)))
        }
    }
}

class MainPresenterTest: XCTestCase {

    var view: MokeView!
    var presenter: MainPresenter!
    var networkService: NetworkServiceProtocol!
    var router: RouterProtocol!
    var comments = [Comment]()
    
    override func setUpWithError() throws {
        let navController = UINavigationController()
        let assemblyBuilder = AssemblyModuleBuilder()
        
        self.router = Router(navigationController: navController, assemblyBuilder: assemblyBuilder)
    }

    override func tearDownWithError() throws {
        view = nil
        presenter = nil
        networkService = nil
    }
    
    func testGetSuccesComments() {
        let comment = Comment(body: "Foo")
        comments.append(comment)
        
        view = MokeView()
        networkService = MokeNetworkService(comment: comments)
        
        presenter = MainPresenter(view: view, networkService: networkService, router: router)
        
        var catchComments: [Comment]!
        
        networkService.downloadComments { (result) in
            switch result {
            case .success(let comments):
                catchComments = comments
                print()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        XCTAssertNotEqual(catchComments.count, nil)
        XCTAssertEqual(catchComments.count, comments.count)
    }
    
    func testGetFailureComments() {
        let comment = Comment(body: "Foo")
        comments.append(comment)
        
        view = MokeView()
        networkService = MokeNetworkService()
        presenter = MainPresenter(view: view, networkService: networkService, router: router)
        
        var catchError: Error?
        
        networkService.downloadComments { (result) in
            switch result {
            case .success(let comments):
                print(comments)
            case .failure(let error):
                catchError = error
            }
        }
        XCTAssertNotNil(catchError)
    }
}

