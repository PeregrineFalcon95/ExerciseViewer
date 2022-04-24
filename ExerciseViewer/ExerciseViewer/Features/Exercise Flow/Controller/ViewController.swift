//
//  ViewController.swift
//  ExerciseViewer
//
//  Created by Amit Sarker on 4/23/22.
//

import UIKit

class ViewController: UIViewController {
    //MARK: IBOutlets
    @IBOutlet weak private var navBar: CustomNavBar!
    @IBOutlet weak private var collectionView: UICollectionView!
    
    //MARK: Variables
    private let viewModel = EVExerciseListVM()
    
    //MARK: Views life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setStyle()
        collectionViewSetUp()
        getData()
    }
}

//MARK: UI Functionalities
extension ViewController {
    private func setStyle(){
        navBar.hideBackButton()
    }
}

//MARK: Navigation Functionalities
extension ViewController {
    
}

//MARK: Helper
extension ViewController {
    private func getData(){
        viewModel.getExerciseList { success in
            if success {
                self.collectionView.reloadData()
            }
        }
    }
}

//MARK: CollectionView Functionalities
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    private func collectionViewSetUp(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.exerciseList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.exerciseListID, for: indexPath) as? ExerciseCell else {
            fatalError("The dequeued cell is not an instance of ExerciseCell.")
        }
        cell.configure(viewModel: viewModel, index: indexPath.row)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 100
        let height = 100
        return CGSize(width: width , height: height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
