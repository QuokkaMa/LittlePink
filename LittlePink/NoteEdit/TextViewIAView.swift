//
//  TextViewIAView.swift
//  LittlePink
//
//  Created by 马振洲 on 2023/4/7.
//

import UIKit

class TextViewIAView: UIView {

    @IBOutlet weak var doneBtn: UIButton!

    @IBOutlet weak var textCountStackView: UIStackView!
    
    @IBOutlet weak var textCountLabel: UILabel!
    
    @IBOutlet weak var maxTextCountLabel: UILabel!
    
    var currentTextCount = 0{
        didSet{
            if currentTextCount <= kMaxNoteTextCount{
                doneBtn.isHidden = false
                textCountStackView.isHidden = true
            }else{
                doneBtn.isHidden = true
                textCountStackView.isHidden = false
                textCountLabel.text = "\(currentTextCount)"
            }
        }
    }

}
