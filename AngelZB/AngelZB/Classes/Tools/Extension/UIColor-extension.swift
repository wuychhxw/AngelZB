//
//  UIColor-extension.swift
//  AngelZB
//
//  Created by youchen wu on 16/10/25.
//  Copyright © 2016年 wyc. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        self.init(red : r/255.0, green : g/255.0, blue : b/255.0, alpha : 1.0)
    }
}
