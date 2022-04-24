//
//  EVExerciseVM.swift
//  ExerciseViewer
//
//  Created by Amit Sarker on 4/23/22.
//

import Foundation
import UIKit


class EVExerciseListVM {
    
    var exerciseList : [Results] = []
    var exerciseListImage : [ Int : UIImage? ] = [:]
    private let operationQueue = OperationQueue()
    
    //API call to get the list of exercise
    func getExerciseList(completion: @escaping( _ success: Bool )-> (Void) ){
        
        Networker.shared.makeRequest(path: Path.exerciseList.rawValue) { data, success in
            if let data = data, success {
                do {
                    let dataModel = try JSONDecoder().decode( EVexerciseList.self , from: data)
                    DispatchQueue.main.async {
                        for temp in dataModel.results {
                            self.exerciseList.append( temp )
                        }
                        completion(true)
                    }
                } catch {
                    DispatchQueue.main.async {
                        Helper.showAlert(msg: Constants.serializationWarning)
                        completion(false)
                    }
                }
            }
        }
    }
    
    //API call to get the image of particular exercise
    func getExerciseListImage( index: Int ,completion: @escaping( _ success: Bool )-> (Void)){
        guard exerciseList.count > index , let base = exerciseList [ index ].exercise_base else {return}
        let endPoint = String( base )
        
        let blockOperation = BlockOperation()
        
        blockOperation.addExecutionBlock {
            Networker.shared.makeRequest(path: Path.exerciseImageInfo.rawValue + endPoint) { data, success in
                if let data = data, success {
                    do {
                        let dataModel = try JSONDecoder().decode( EVexerciseList.self , from: data)
                            var imageUrl : String?
                            for temp in dataModel.results {
                                if let image = temp.image {
                                    imageUrl = image
                                    break
                                }
                            }
                            guard let imageUrl = imageUrl else {
                                self.exerciseListImage [ index ] = nil
                                return
                            }
                            Networker.shared.getImage(url: URL(string: imageUrl)) { image, success in
                                if success {
                                    DispatchQueue.main.async {
                                        self.exerciseListImage [ index ] = image
                                        completion(true)
                                    }
                                }
                            }
                    } catch {
                        DispatchQueue.main.async {
                            Helper.showAlert(msg: Constants.serializationWarning)
                            completion(false)
                        }
                    }
                }
            }
        }
        operationQueue.qualityOfService = .utility
        operationQueue.addOperation(blockOperation)
    }
}
