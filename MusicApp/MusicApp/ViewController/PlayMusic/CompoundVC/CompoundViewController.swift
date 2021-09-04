//
//  CompoundViewController.swift
//  MusicApp
//
//  Created by Lauv Edward on 04/09/2021.
//

import UIKit

class CompoundViewController: UIViewController {

    @IBOutlet weak var dissmisButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func dissmisClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
