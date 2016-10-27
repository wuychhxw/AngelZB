//
//  PageContentViewController.swift
//  AngelZB
//
//  Created by youchen wu on 16/10/25.
//  Copyright © 2016年 wyc. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func PageContentViewInfo(contentView:PageContentView,progress:CGFloat, souceInde:Int, targetIndex:Int)
}

class PageContentView: UIView {
    
    var childVCS:[UIViewController]
    weak var parentVC:UIViewController?
    var startOffsetX : CGFloat = 0
    var isForbidScrollDelegate : Bool = false
    weak var delegate:PageContentViewDelegate?
    
    lazy var conllectionView : UICollectionView = {[weak self] in
        var layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let conllectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        conllectionView.showsHorizontalScrollIndicator = false
        conllectionView.isPagingEnabled = true
        conllectionView.bounces = false
        conllectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return conllectionView
    }()

    init(frame: CGRect, childVCS: [UIViewController], parentVC: UIViewController?) {
        self.childVCS = childVCS
        self.parentVC = parentVC
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PageContentView {
    func setupUI() {
        for childVC in childVCS {
            parentVC?.addChildViewController(childVC)
        }
        addSubview(conllectionView)
        conllectionView.frame = bounds
        conllectionView.dataSource = self
        conllectionView.delegate = self
    }
}

extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCS.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = conllectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVC = childVCS[indexPath.item]
        childVC.view.frame = cell.bounds
        cell.contentView.addSubview(childVC.view)
        return cell
    }
}

extension PageContentView : UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffsetX = scrollView.bounds.origin.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForbidScrollDelegate {return}
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        let currenX = scrollView.bounds.origin.x
        let collectionW = conllectionView.frame.width
        
        if currenX > startOffsetX {
            //右滑
            //1 计算滑动比例
            progress = (currenX/collectionW) - floor(currenX/collectionW)
            //2 计算当前view的index
            sourceIndex = Int(currenX/collectionW)
            //3 计算目标view的index
            targetIndex = sourceIndex + 1
            //4 如果滑动到最后一个view
            if targetIndex >= childVCS.count {
                targetIndex = childVCS.count - 1
            }
            //5 如果滑动全部完成
            if currenX - startOffsetX == collectionW {
                progress = 1
                targetIndex = sourceIndex
            }
        }else {
            //左滑
            progress = 1 - ((currenX/collectionW) - floor(currenX/collectionW))
            targetIndex = Int(currenX/collectionW)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVCS.count {
                sourceIndex = childVCS.count - 1
            }
            if startOffsetX - currenX == collectionW {
                progress = 1
                sourceIndex = targetIndex
            }
        }
        delegate?.PageContentViewInfo(contentView: self, progress: progress, souceInde: sourceIndex, targetIndex: targetIndex)
    }
}

extension PageContentView {
    func setCurrentIndex(index:Int) {
        isForbidScrollDelegate = true
        let offsetX = CGFloat(index) * conllectionView.frame.width
        conllectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated: false)
    }
}




