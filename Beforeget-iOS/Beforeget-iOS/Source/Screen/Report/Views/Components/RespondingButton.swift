//
//  RespondingButton.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/09.
//

import UIKit

class RespondingButton: UIButton {
    
    // MARK: - Properties
    
    private var myView: UIView? = UIView()
    private var toolBarView: UIView? = UIView()
    
    override var inputView: UIView? {
        get {
            myView
        }
        
        set {
            myView = newValue
        }
    }
    
    override var inputAccessoryView: UIView? {
        get {
            toolBarView
        }
        set {
            toolBarView = newValue
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }  
}
