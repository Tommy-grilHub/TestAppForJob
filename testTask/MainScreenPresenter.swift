//
//  MainScreenPresenter.swift
//  testTask
//
//  Created by BigSynt on 22.01.2023.
//  Copyright © 2023 BigSynt. All rights reserved.
//

import Foundation
import Alamofire

class MainScreenPresenter {
    
    var view: MainScreenProtocol?
    var urlDrugs = "http://shans.d2.i-partner.ru/api/ppp/index/"
    let requestData = RequestData()
    var token = "dimaYak"
    
    var headers: HTTPHeaders {
        get {
            return ["Authorization": "Bearer \(token)"]
        }
    }
    
    func getData() {
        requestData.getData(urlString: urlDrugs, token: token, headers: headers) { result in
            switch result {
            case .success(let data):
                do {
                    let drugs = try JSONDecoder().decode(Drugs.self, from: data)
                    let entityDrugs = drugs.map{ DrugEntity(data: $0) }
                    self.view?.getDrugs(drugs: entityDrugs)
                    self.view?.collectionViewDidLoad()
                } catch {
                    print("error JSONdecoding: \(error)")
                }
            case .failure(let error):
                print("error:\(error.localizedDescription)")
            }
        }
    }
}
