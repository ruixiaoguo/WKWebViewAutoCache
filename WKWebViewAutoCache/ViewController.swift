//
//  ViewController.swift
//  WKWebViewAutoCache
//
//  Created by grx on 2018/10/11.
//  Copyright © 2018年 grx. All rights reserved.
//

import UIKit

class ViewController: BaseHtmlController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = YCColorWhite
        self.startLoadWithTitle(title: "新浪", url: "http://www.sina.com")
    }


}

