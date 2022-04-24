//
//  Networker.swift
//  ExerciseViewer
//
//  Created by Amit Sarker on 4/24/22.
//

import Foundation


class Networker {
    static let shared = Networker()
    
    private let session: URLSession
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    func makeRequest( path: Path , completion: @escaping ( Data? , Bool ) -> (Void) ) {
        guard let url = URL(string: baseURL + path.rawValue) else {
            Helper.showAlert(msg: "Invalid URL")
            DispatchQueue.main.async {
                completion(nil, false)
            }
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                DispatchQueue.main.async {
                    Helper.showAlert(msg: error.localizedDescription)
                    completion(nil, false)
                }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    Helper.showAlert(msg: "Bad Response")
                    completion(nil, false)
                }
                return
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    Helper.showAlert(msg: "Bad Status Code " + String(httpResponse.statusCode))
                    completion(nil, false)
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    Helper.showAlert(msg: "Bad Data")
                    completion(nil, false)
                }
                return
            }
                        
            DispatchQueue.main.async {
                completion(data, true)
            }
        }
        task.resume()
    }
}
