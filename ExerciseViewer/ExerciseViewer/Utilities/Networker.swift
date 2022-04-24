//
//  Networker.swift
//  ExerciseViewer
//
//  Created by Amit Sarker on 4/24/22.
//

import Foundation
import UIKit


class Networker {
    static let shared = Networker()
    
    private let session: URLSession
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    func makeRequest( path: String , completion: @escaping ( Data? , Bool ) -> (Void) ) {
        guard let url = URL(string: baseURL + path) else {
            Helper.showAlert(msg: Constants.invalidURLWarning )
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
                    Helper.showAlert(msg:Constants.badResponseWarning )
                    completion(nil, false)
                }
                return
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    Helper.showAlert(msg: Constants.badStatusWarnig + String(httpResponse.statusCode))
                    completion(nil, false)
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    Helper.showAlert(msg: Constants.badDataWarning)
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
    
    func getImage( url: URL? , completion: @escaping ( UIImage? , Bool ) -> (Void) ){
        guard let url = url else {
            Helper.showAlert(msg: Constants.invalidURLWarning)
            DispatchQueue.main.async {
                completion(nil, false)
            }
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { (image: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                DispatchQueue.main.async {
                    Helper.showAlert(msg: error.localizedDescription)
                    completion(nil, false)
                }
                return
            }
            guard let image = image else {
                DispatchQueue.main.async {
                    Helper.showAlert(msg: Constants.retriveImageWarning )
                    completion(nil, false)
                }
                return
            }
            if let image = UIImage(data: image ){
                DispatchQueue.main.async {
                    completion(image, true)
                }
            }
            else {
                DispatchQueue.main.async {
                    completion(nil, false)
                }
            }
        }
        task.resume()
    }
}
