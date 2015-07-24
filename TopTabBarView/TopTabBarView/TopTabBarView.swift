//
//  TopTabBarView.swift
//  TopTabBarView
//
//  Created by SatoDaisuke on 7/21/15.
//  Copyright (c) 2015 com.daisukeSato. All rights reserved.
//

import UIKit

protocol TopTabBarViewDelegate: class {
    
    
    // Called after the tab changes, be highlight and moves.
    func topTabBarViewDidHighlight(topTabBarView: TopTabBarView, index: Int)
    
}

public class TopTabBarView: UIView, UIScrollViewDelegate {
    
    weak var delegate: TopTabBarViewDelegate?
    
    // MARK: Private properties
    private var scrollView: UIScrollView!
    private var underLine: UIView!
    private var topTabBarItems: [UIButton]!
    private var scrollViewCustomizedContentWidth: CGFloat!
    
    // MARK: Initializer
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(frame: CGRect, items: [TopTabBarItem]) {
        super.init(frame: frame)
        
        setupItems(items)
        setupScrollView()
        addItems()
        setupUnderLine()
        
        highlight(index: 0)
        
    }
    
    // MARK: Setup methods
    private func setupItems(items: [TopTabBarItem]) {
        
        self.topTabBarItems = [UIButton]()
        self.scrollViewCustomizedContentWidth = 0
        
        for idx: Int in 0..<items.count {
            
            let item = items[idx]
            
            let button = UIButton()
            
            button.tag = idx
            button.titleLabel?.font = UIFont(name: "HiraKakuProN-W6", size: 14)
            button.setTitle(item.title, forState: .Normal)
            button.setTitleColor(item.color, forState: .Normal)
            button.setTitleColor(UIColor.whiteColor(), forState: .Selected)
            button.backgroundColor = UIColor.whiteColor()
            button.clipsToBounds = true
            button.layer.cornerRadius = 5.0
            button.sizeToFit()
            
            button.frame.size = CGSizeMake(
                button.frame.width + (12 * 2),
                self.frame.height
            )
            
            button.frame.origin = CGPointMake(
                self.scrollViewCustomizedContentWidth,
                0.0
            )
            
            button.addTarget(self, action: "didTouchUpInside:", forControlEvents: .TouchUpInside)
            
            self.topTabBarItems.append(button)
            
            self.scrollViewCustomizedContentWidth! += button.frame.width
            
        }
        
        
        // fix scrollView.ContentSize.width if shoter than dispaly's width
        if self.scrollViewCustomizedContentWidth < self.frame.width {
            
            fixContentWidth()
            
        }
        
    }
    
    private func setupScrollView() {
        
        scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.frame = CGRectMake(
            0,
            0,
            self.frame.width,
            self.frame.height
        )
        scrollView.contentSize = CGSizeMake(
            scrollViewCustomizedContentWidth,
            self.frame.height
        )
        scrollView.scrollEnabled = true
        scrollView.pagingEnabled = false
        scrollView.alwaysBounceHorizontal = false
        scrollView.alwaysBounceVertical = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        self.addSubview(scrollView)
        
    }
    
    private func addItems() {
        
        for idx: Int in 0..<self.topTabBarItems.count {
            
            let button = self.topTabBarItems[idx]
            
            self.scrollView.addSubview(button)
            
        }
        
        
    }
    
    private func setupUnderLine() {
        
        let lineHeight: CGFloat = 5.0
        
        self.underLine = UIView()
        self.underLine.frame = CGRectMake(
            0,
            self.frame.height - lineHeight,
            self.scrollViewCustomizedContentWidth,
            lineHeight
        )
        
        self.addSubview(self.underLine)
    }
    
    
    @objc private func didTouchUpInside(sender: UIButton) {
        
        highlight(index: sender.tag)
        
    }
    
    func highlight(#index: Int) {
        
        for idx: Int in 0..<self.topTabBarItems.count {
            
            let button = self.topTabBarItems[idx]
            
            if idx == index {
                
                let highlightColor = button.titleColorForState(.Normal)
                
                button.selected = true
                button.backgroundColor = highlightColor
                
                self.underLine.backgroundColor = highlightColor
                
            } else {
                
                button.selected = false
                button.backgroundColor = button.titleColorForState(.Selected)
                
            }
            
        }
        
        move(index: index)
        
    }
    
    private func move(#index: Int) {
        
        let button = self.topTabBarItems[index]
        
        let distance = self.scrollView.contentSize.width - self.scrollView.contentOffset.x
        let distanceRight = self.scrollView.contentSize.width - button.center.x
        
        var newContentOffsetX: CGFloat = 0.0
        
        if button.center.x - (self.frame.width / 2) > 0 && distanceRight > self.frame.width / 2 {
            
            newContentOffsetX = button.center.x - (self.frame.width / 2)
            
        } else if button.center.x - (self.frame.width / 2) <= 0 {
            
            newContentOffsetX = 0.0
            
        } else {
            
            newContentOffsetX = self.scrollView.contentSize.width - self.frame.width
            
        }
        
        
        self.scrollView.setContentOffset(CGPointMake(
            newContentOffsetX,
            0.0
            ),
            animated: true
        )
        
        
        self.delegate?.topTabBarViewDidHighlight(self, index: index)
        
    }
    
    private func fixContentWidth() {
        
        let remainingSpace = self.frame.width - self.scrollViewCustomizedContentWidth
        let dividedSpace = remainingSpace / CGFloat(self.topTabBarItems.count)
        let newSpace = dividedSpace / 2
        
        self.scrollViewCustomizedContentWidth = 0
        
        for idx: Int in 0..<self.topTabBarItems.count {
            
            let button = self.topTabBarItems[idx]
            button.frame.size = CGSizeMake(
                button.frame.width + (newSpace * 2),
                self.frame.height
            )
            button.frame.origin = CGPointMake(
                self.scrollViewCustomizedContentWidth,
                0.0
            )
            
            self.scrollViewCustomizedContentWidth! += button.frame.width
            
        }
        
        
    }
    
    
}

public class TopTabBarItem {
    
    var title: String!
    var color: UIColor!
    var indexPath: NSIndexPath!
    
    public init(title: String, color: UIColor) {
        self.title = title
        self.color = color
        self.indexPath = NSIndexPath(index: 0)
    }
    
}
