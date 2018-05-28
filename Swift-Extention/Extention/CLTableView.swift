//
//  CLPRTableView.swift
//  TestDemo
//
//  Created by fuyongYU on 2018/5/22.
//  Copyright © 2018年 YeMaoZi. All rights reserved.
//

import UIKit
import MJRefresh

enum RefreshType : NSInteger {
    case PullDown = 0
    case PullUp
    case ALL
}


class CLTableView: UITableView {
    
    var pullDownBack: (() -> ())? =  nil
    var pullUpBack: (() -> ())? =  nil
    
    func normalRefresh(refreshType:RefreshType,
                       firstRefresh:Bool = true,
                       timeLabHidden:Bool = false,
                       stateLabHidden:Bool = false,
                       pullDownBack:(() -> ())?,
                       pullUpBack:(() -> ())?) {
        if refreshType == .PullDown {
            self.pullDownBack = pullDownBack
            let header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(pullDownBackAction))
            self.mj_header = header
            if firstRefresh {self.mj_header.beginRefreshing()}
            self.mj_header.isAutomaticallyChangeAlpha = true //自动改变透明度
            header?.lastUpdatedTimeLabel.isHidden = timeLabHidden//头部的菊花是否隐藏
            header?.stateLabel.isHidden = stateLabHidden//状态文本是不是隐藏
        }else if refreshType == .PullUp{ //只允许上拉
            self.pullUpBack = pullUpBack
            self.mj_footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(pullUpBackAction))
        }else{
            self.pullDownBack = pullDownBack
            self.pullUpBack = pullUpBack
            let header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(pullDownBackAction))
            header?.lastUpdatedTimeLabel.isHidden = timeLabHidden
            header?.stateLabel.isHidden = stateLabHidden
            self.mj_header = header
            if firstRefresh {self.mj_header.beginRefreshing()}
            self.mj_header.isAutomaticallyChangeAlpha = true
            self.mj_footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(pullUpBackAction))
            
        }
    }
    
    
    
}


// MARK: - 点击事件
extension CLTableView {
    
    @objc func pullDownBackAction() {
        if self.pullDownBack != nil{self.pullDownBack!()}
        
    }
    
    @objc func pullUpBackAction() {
        if  self.pullUpBack != nil {self.pullUpBack!()}
    }
    
}


