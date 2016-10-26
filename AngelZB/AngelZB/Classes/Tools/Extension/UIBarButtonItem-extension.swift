//
//  UIBarButtonItem-extension.swift
//  AngelZB
//
//  Created by youchen wu on 16/10/24.
//  Copyright © 2016年 wyc. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
/*    class func createItem(imageName: String, hightLightImageName: String, size:CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: hightLightImageName), for: .highlighted)
        btn.frame = CGRect(origin: .zero, size: size)
        return UIBarButtonItem(customView: btn)
    } */
    //便利构造函数 1.必须加convenience前缀 2.必须明确调用一个设计的构造函数，用self调用，如：self.init(customView: btn)
    convenience init(imageName: String, hightLightImageName: String = "", size:CGSize = .zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if hightLightImageName != "" {
            btn.setImage(UIImage(named: hightLightImageName), for: .highlighted)
        }
        if size == .zero {
            btn.sizeToFit()
        }else {
            btn.frame = CGRect(origin: .zero, size: size)
        }
        self.init(customView: btn)
    }
}
