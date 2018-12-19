//
//  ViewController.swift
//  Set
//
//  Created by Татьяна Пятыхина on 08/12/2018.
//  Copyright © 2018 Татьяна Пятыхина. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var Cards: [BorderButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateButtonsFromModel()
    }

    private func updateButtonsFromModel() {}
}
