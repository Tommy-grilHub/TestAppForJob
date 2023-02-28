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
