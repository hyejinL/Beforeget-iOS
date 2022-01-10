//
//  RespondingButton.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/09.
//

import UIKit

class RespondingButton: UIButton {
    
    // MARK: - Properties
    
    var myView: UIView? = UIView()
    var toolBarView: UIView? = UIView()
    var responder: Bool = false
    
    override var inputView: UIView? {
        get {
            myView
        }
        
        set {
            myView = newValue
            becomeFirstResponder()
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
        get {
            responder
        }
        set {
            responder = newValue
        }
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }  
}
