//
//  ViewController.swift
//  TopTabBarViewExample
//
//  Created by SatoDaisuke on 7/21/15.
//  Copyright (c) 2015 com.daisukeSato. All rights reserved.
//

import UIKit
import TopTabBarView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        let item1 = TopTabBarItem(title: "Hot", color: UIColor(red: 2/255, green: 174/255, blue: 220/255, alpha: 1))
        let item2 = TopTabBarItem(title: "Social", color: UIColor(red: 255/255, green: 212/255, blue: 100/255, alpha: 1))
        let item3 = TopTabBarItem(title: "Politics", color: UIColor(red: 18/255, green: 83/255, blue: 164/255, alpha: 1))
        let item4 = TopTabBarItem(title: "Business", color: UIColor(red: 47/255, green: 205/255, blue: 180/255, alpha: 1))
        let item5 = TopTabBarItem(title: "Entertaiment", color: UIColor(red: 251/255, green: 168/255, blue: 72/255, alpha: 1))
        let item6 = TopTabBarItem(title: "Tech", color: UIColor(red: 12/255, green: 85/255, blue: 93/255, alpha: 1))
        let item7 = TopTabBarItem(title: "Media", color: UIColor(red: 2/255, green: 150/255, blue: 200/255, alpha: 1))
        let item8 = TopTabBarItem(title: "Comedy", color: UIColor(red: 255/255, green: 83/255, blue: 200/255, alpha: 1))
        
        let topTabBarView = TopTabBarView(
            frame: CGRectMake(
                0,
                UIApplication.sharedApplication().statusBarFrame.height,
                self.view.frame.width,
                44
            ),
            items: [item1,item2,item3,item4,item5,item6,item7,item8]
        )
        
        topTabBarView.delegate = self
        self.view.addSubview(topTabBarView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

