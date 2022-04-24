//
//  ExerciseCell.swift
//  ExerciseViewer
//
//  Created by Amit Sarker on 4/23/22.
//

import UIKit

class ExerciseCell: UICollectionViewCell {
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    
    
    func configure(viewModel: EVExerciseListVM, index: Int){
        imageView.image = UIImage(named: "ICPlaceholder")
        if let name = viewModel.exerciseList [ index ].name {
            self.nameLabel.text = name
        }
        if let image = viewModel.exerciseListImage [ index ] {
            imageView.image = image
        }
        else {
            viewModel.getExerciseListImage(index: index) { success in
                if success , let image = viewModel.exerciseListImage [ index ] {
                    self.imageView.image = image
                }
            }
        }
    }
}
