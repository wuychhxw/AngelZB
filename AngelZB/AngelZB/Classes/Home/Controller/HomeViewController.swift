//
//  HomeViewController.swift
//  AngelZB
//
//  Created by youchen wu on 16/10/14.
//  Copyright © 2016年 wyc. All rights reserved.
//

import UIKit
private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    
    lazy var pageTitleView:PageTitleUIVIew = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH+kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTitleUIVIew(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    lazy var pageContentView:PageContentView = {[weak self] in
        var childVcs = [UIViewController]()
        childVcs.append(ReCommendViewController())
        for _ in 0..<3 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let contenH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabbarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contenH)
        let contentView = PageContentView(frame: contentFrame, childVCS: childVcs, parentVC: self)
        contentView.delegate = self
        return contentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension HomeViewController {
    func setupUI() {
        automaticallyAdjustsScrollViewInsets = false
        setNavigationBar()
        
        view.addSubview(pageTitleView)
        
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
    }
    
    //设置顶部导航栏
    private func setNavigationBar() {
        //设置左边logo
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        //设置右边按钮
        //浏览历史按钮
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", hightLightImageName: "Image_my_history_click", size: size)
        
        //搜索按钮
        let serarchItem = UIBarButtonItem(imageName: "btn_search", hightLightImageName: "btn_search_clicked", size: size)
        
        //二维码按钮
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", hightLightImageName: "Image_scan_click", size: size)
        
        
        navigationItem.rightBarButtonItems = [historyItem,serarchItem,qrcodeItem]
    }
}

extension HomeViewController : PageTitleUIVIewDelegat {
    func PageTitleUIVIewSet(view: PageTitleUIVIew, selectIndex index: Int) {
        self.pageContentView.setCurrentIndex(index: index)
    }
}

extension HomeViewController : PageContentViewDelegate {
    func PageContentViewInfo(contentView: PageContentView, progress: CGFloat, souceInde: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progess: progress, sourceIndex: souceInde, targetIndex: targetIndex)
    }
}



