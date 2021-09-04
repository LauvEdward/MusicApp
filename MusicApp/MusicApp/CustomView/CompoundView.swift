//
//  CompoundView.swift
//  MusicApp
//
//  Created by Lauv Edward on 04/09/2021.
//

import UIKit
class CompoundView: UIView {
    
    @IBOutlet var contentView: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        Bundle.main.loadNibNamed(self.className, owner: self, options: nil)
        self.addSubview(contentView)
        contentView.layer.cornerRadius = 5
        contentView.applyGradient(colours: [UIColor(hexFromString: "#7451FF"), UIColor(hexFromString: "#FF007A")])
        contentView.frame = self.bounds
        contentView.clipsToBounds = true
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
