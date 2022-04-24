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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let color = UIColor(named: Colors.cellBorder) {
            self.layer.borderColor = color.cgColor
            self.layer.borderWidth = 1
        }
        self.layer.cornerRadius = 5
    }
    
    func configure(viewModel: EVExerciseListVM, index: Int){
        imageView.image = UIImage(named: ImageNames.placeholderIC)
        
        if let name = viewModel.exerciseList [ index ].name {
            self.nameLabel.text = name
        }
        if let image = viewModel.exerciseListImage [ index ] {
            imageView.image = image
        }
        else if !viewModel.exerciseListImage.keys.contains(index) {
            viewModel.getExerciseListImage(index: index) { success in
                if success , let image = viewModel.exerciseListImage [ index ] {
                    self.imageView.image = image
                }
            }
        }
    }
}
