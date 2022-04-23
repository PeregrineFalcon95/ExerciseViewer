//
//  ViewController.swift
//  ExerciseViewer
//
//  Created by Amit Sarker on 4/23/22.
//

import UIKit

class CustomNavBar: UIView {

    @IBOutlet var containerView: UIView!
    @IBOutlet weak private var backBtn: UIButton!
    @IBOutlet weak private var titleLbl: UILabel!
    
    var logoutAction: (() -> Void)?
    
    var contentView : UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        xibSetup()
    }

    private func xibSetup() {
        contentView = loadViewFromNib()
        contentView!.frame = bounds
        contentView!.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(contentView!)
        
        titleLbl.text = ""
        containerView.backgroundColor = .white
    }
    
    private func loadViewFromNib() -> UIView! {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return view
    }
    
    func setTitle(title: String){
        titleLbl.text = title
    }
    func hideBackButton(){
        backBtn.isHidden = true
    }

    @IBAction private func backAction(_ sender: UIButton) {
        guard let vc = self.window?.visibleViewController() else {return}
        vc.navigationController?.popViewController(animated: true)
    }
}
