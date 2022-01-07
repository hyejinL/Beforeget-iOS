//
//  ViewController.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/07.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .white
        
        let label = UILabel()
        label.font = BDSFont.title1
    }
    
    private func setupLayout() {
        
    }
    
    // MARK: - Custom Method
    
    
}

