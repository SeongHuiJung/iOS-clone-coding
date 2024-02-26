//
//  IBtest3.swift
//  HelloSwiftProject
//
//  Created by 정성희 on 2024/01/29.
//

import Foundation
import UIKit

class IBtest3: UIView {

    @IBInspectable var borderWIdth: CGFloat{
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth=newValue
        }
    }

}
