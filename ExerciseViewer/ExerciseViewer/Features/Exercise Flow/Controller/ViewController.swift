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
        navBar.setTitle(title: Constants.appTitle)
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
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private func collectionViewSetUp(){
        collectionView.delegate = self
        collectionView.dataSource = self
        
        var space : CGFloat = 8
        if UIDevice.current.userInterfaceIdiom != .phone {
            space = 16
        }
        
        collectionView.contentInset = UIEdgeInsets(top: space, left: space, bottom: space, right: space)
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
        var width  : CGFloat = 0
        var height : CGFloat = 0
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            width = ( UIScreen.main.bounds.width - 24 ) / 2
        }
        else {
            width = ( UIScreen.main.bounds.width - 80 ) / 4
        }
        height = width * 1.5
        return CGSize(width: width , height: height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
