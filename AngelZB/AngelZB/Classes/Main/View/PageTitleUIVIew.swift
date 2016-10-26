//
//  PageTitleUIVIew.swift
//  AngelZB
//
//  Created by youchen wu on 16/10/24.
//  Copyright © 2016年 wyc. All rights reserved.
//

import UIKit

protocol PageTitleUIVIewDelegat : class {
    func PageTitleUIVIewSet(view:PageTitleUIVIew,selectIndex index:Int)
}

// MARK:- 定义常量
private let kScrollLineH : CGFloat = 2
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

class PageTitleUIVIew: UIView {
    var titles:[String]
    var currentIndex:Int = 0
    weak var delegate:PageTitleUIVIewDelegat?
    lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces  = false
        return scrollView
    }()
    
    lazy var scrollLine:UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    lazy var titleLabels : [UILabel] = [UILabel]()
    
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PageTitleUIVIew {
    func setupUI() {
        addSubview(scrollView)
        scrollView.frame  = bounds
        setupTitleLabels()
        setupBottomLineAndScollLine()
    }
    
    private func setupTitleLabels() {
        // 0.确定label的一些frame的值
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for (index,title) in titles.enumerated() {
            let label = UILabel()
            
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: CGFloat(16.0))
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.labelClick(tap:)))
            label.addGestureRecognizer(tap)
        }
    }
    
    private func setupBottomLineAndScollLine() {
        //设置底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH:CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //设置scrollview底线
        guard let firstLab = titleLabels.first else {return}
        
        firstLab.textColor = UIColor.orange
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLab.frame.origin.x, y: frame.height - kScrollLineH, width: firstLab.frame.width, height: kScrollLineH)
    }
}

extension PageTitleUIVIew {
    @objc func labelClick(tap:UITapGestureRecognizer) {
        guard let currentLab = tap.view as? UILabel else {return}
        let oldLab = titleLabels[currentIndex]
        if currentLab.tag == currentIndex {return}
        currentLab.textColor = UIColor.orange
        oldLab.textColor = UIColor.darkGray
        
        currentIndex = currentLab.tag
        
        let scollLineX = CGFloat(currentIndex) * self.scrollLine.frame.width
        UIView.animate(withDuration: 0.15) { 
            self.scrollLine.frame.origin.x = scollLineX
        }
        
        delegate?.PageTitleUIVIewSet(view: self, selectIndex: currentIndex)
        
    }
}













