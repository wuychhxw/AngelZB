//
//  MainViewController.swift
//  AngelZB
//
//  Created by youchen wu on 16/10/24.
//  Copyright © 2016年 wyc. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVC(storyname: "Home")
        addChildVC(storyname: "Live")
        addChildVC(storyname: "Follow")
        addChildVC(storyname: "Profile")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    

    private func addChildVC(storyname : String) {
        let childVc = UIStoryboard(name: storyname, bundle: nil).instantiateInitialViewController()
        
        addChildViewController(childVc!)
    }

}
