//
//  IBtest2.swift
//  HelloSwiftProject
//
//  Created by 정성희 on 2024/01/29.
//

import UIKit

class IBtest2: UIView {

    @IBInspectable var borderWIdth: CGFloat{
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth=newValue
        }
    }

}
