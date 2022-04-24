//
//  EVExerciseVM.swift
//  ExerciseViewer
//
//  Created by Amit Sarker on 4/23/22.
//

import Foundation


class EVExerciseListVM {
    
    var exerciseList : [Results] = []
    func getExerciseList(completion: @escaping( _ success: Bool )-> (Void) ){
        
        Networker.shared.makeRequest(path: Path.exerciseList) { data, success in
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
                        Helper.showAlert(msg: "Serialization Error")
                        completion(false)
                    }
                }
            }
        }
    }
}
