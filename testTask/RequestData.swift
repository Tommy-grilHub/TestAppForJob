//
//  RequestData.swift
//  testTask
//
//  Created by BigSynt on 22.01.2023.
//  Copyright © 2023 BigSynt. All rights reserved.
//

import Foundation
import Alamofire

class RequestData {
    func getData(urlString: String, token: String, headers: HTTPHeaders, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
//        let sessionConfiguration = URLSessionConfiguration.default
//        let session = URLSession(configuration: sessionConfiguration)
        request.headers = headers
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let safeData = data else { return }
                //if let jsonString = String(data: safeData, encoding: .utf8) { print("response:\(jsonString)") } // для проверки данных, приходящих по api
                completion(.success(safeData))
            }
        }
        task.resume()
    }
}

//guard let url = URL(string: "https://*********/api/get/text") else {return}
//var request  = URLRequest(url: url)
//let sessionConfiguration = URLSessionConfiguration.default
//let session = URLSession(configuration: sessionConfiguration)
//request.httpMethod = "GET"
//request.addValue("Bearer GqvKi5RWYjdGpH64MHB8McgKe2_UU-Hq", forHTTPHeaderField: "Authorization")
//session.dataTask(with: request) { (data, response, error) in
//    if let response = response{
//        print(response)
//    }
//
//    guard let data = data else {return}
//    do {
//        let json = try JSONSerialization.jsonObject(with: data, options: [])
//        print(json)
//    } catch{
//        print(error)
//    }
//}.resume()
        
//        AF.request(URLConvertible as! URLConvertible, method: HTTPMethod, encoding: URLEncoding.default, headers: HTTPHeaders)
//            .responseData { response in
//                switch response.result {
//                case .success(let data):
//                    do {
//                        let drug = try JSONDecoder().decode(Drugs.self, from: data)
//                        self.view?.getDrugs(drugs: drug)
//                        self.view?.collectionViewDidLoad()
//                    } catch {
//                        print("error JSONdecoding")
//                    }
//                case .failure(let error):
//                    print("error:\(error.localizedDescription)")
//                }
//        }
//    }


//func getMusic(url: String, params: Parameters, headers: HTTPHeaders) {
//    Alamofire.request(url,
//                      method: .get,
//                      parameters: params,
//                      encoding: URLEncoding.default,
//                      headers: headers)
//        .responseData { response in
//            switch response.result {
//            case .success(let data):
//                do {
//                    let decoder = JSONDecoder()
//                    decoder.keyDecodingStrategy = .convertFromSnakeCase
//                    let result = try decoder.decode(Joke.self, from: data)
//                    print(result)
//                    self.array = result.items
//                    self.tableView.reloadData()
//                } catch { print(error) }
//            case let .failure(error):
//                print(error)
//            }
//    }
//}
