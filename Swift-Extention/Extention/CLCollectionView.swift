//
//  CLHomeCollectionView.swift
//  TestDemo
//
//  Created by fuyongYU on 2018/5/22.
//  Copyright © 2018年 YeMaoZi. All rights reserved.
//

import UIKit
import MJRefresh

enum PRRefreshType :NSInteger {
    case PullDown = 0  //下拉
    case PullUp        //上拉
    case All           //上拉 && 下拉
}

enum CLEndRefreshType : NSInteger {
    case Defayle = 0    //默认
    case NoData         //无数据
}


class CLHomeCollectionView: UICollectionView {
    
    /// 下拉时候触发的闭包
    var pullDownRefreshBlock:(() -> ())? = nil
    
    /// 上拉时候触发的闭包
    var pullUpRefreshBlock: (() -> ())? = nil
    
    
    /// 正常模式刷新
    ///
    /// - Parameters:
    ///   - redreshType: 上拉、下拉、上下拉
    ///   - firstRefresh: 首次是否刷新
    ///   - timeLabHidden: 时间标签是否隐藏
    ///   - stateLabHidden: 状态标签是否隐藏
    ///   - pullDownBlock: 下拉回调
    ///   - pullUpBlock: 上拉回调
    func normalRefershType(redreshType:PRRefreshType,
                           firstRefresh:Bool,
                           timeLabHidden:Bool,
                           stateLabHidden:Bool,
                           pullDownBlock:(() -> ())?,
                           pullUpBlock:(() -> ())?) {
        
        
        if redreshType == .PullDown {
            //下拉
            pullDownRefreshBlock = pullDownBlock
            let header:MJRefreshNormalHeader = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(pullDownBlockAction))
            //是否隐藏上次更新的时间
            header.lastUpdatedTimeLabel.isHidden = timeLabHidden
            //是否隐藏刷新状态的label
            header.stateLabel.isHidden = stateLabHidden
            mj_header = header
            
            //首次进来是否需要刷新
            if firstRefresh {
                mj_header.beginRefreshing()
            }
            //渐变色渐变
            mj_header.isAutomaticallyChangeAlpha = true
            
        }else if (redreshType == .PullUp) {
            //上拉
            pullUpRefreshBlock = pullUpBlock
            
            mj_footer = MJRefreshAutoFooter.init(refreshingTarget: self, refreshingAction: #selector(pullUpBlockAction))
            
        }else if (redreshType == .All) {
            //下拉
            pullDownRefreshBlock = pullDownBlock
            let header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(pullDownBlockAction))
            //是否隐藏上次更新的时间
            header?.lastUpdatedTimeLabel.isHidden = timeLabHidden
            //是否隐藏刷新状态的label
            header?.stateLabel.isHidden = stateLabHidden
            
            mj_header = header
            //首次进来需要刷新
            if firstRefresh {
                mj_header.beginRefreshing()
            }
            //透明度渐变
            mj_header.isAutomaticallyChangeAlpha = true
            //上拉
            pullUpRefreshBlock = pullUpBlock
            mj_footer = MJRefreshAutoFooter.init(refreshingTarget: self, refreshingAction: #selector(pullUpBlockAction))
        }
        
    }
    
    
    func gifRefreshType(refreshType:PRRefreshType,
                        firstRefresh:Bool,
                        timeLabHidden:Bool,
                        stateLabHidden:Bool,
                        pullDownBlock:(() -> ())?,
                        pullUpBlock:(() -> ())?) {
        
        let idleImages:Any = [UIImage(named: "loading01"),UIImage(named: "loading02"),UIImage(named: "loading03"),UIImage(named: "loading04")] //闲置状态下的git（拖动的时候变化的gif）
        let pullingImages:Any = [UIImage(named: "loading01"),UIImage(named: "loading02"),UIImage(named: "loading03"),UIImage(named: "loading04")] //已经到达偏移量的gif
        let refreshingImages:Any = [UIImage(named: "loading01"),UIImage(named: "loading02"),UIImage(named: "loading03"),UIImage(named: "loading04")] //正在刷新的时候的gif
        if refreshType == .PullDown {
            //下拉
            pullDownRefreshBlock = pullDownBlock
            let header:MJRefreshGifHeader = MJRefreshGifHeader(refreshingTarget: self, refreshingAction: #selector(pullDownBlockAction))
            //git动画数组
            header.setImages(idleImages as! [Any] , for: .idle)
            header.setImages(pullingImages as! [Any], for: .pulling)
            header.setImages(refreshingImages as! [Any], for: .refreshing)
            //是否隐藏上次更新时间
            header.lastUpdatedTimeLabel.isHidden = timeLabHidden
            //是否隐藏刷新状态的label
            header.stateLabel.isHidden = stateLabHidden
            mj_header = header
            //首次进来是否需要刷新
            if firstRefresh {
                mj_header.beginRefreshing()
            }
            
        }else if refreshType == .PullUp {
            //上拉
            pullUpRefreshBlock = pullUpBlock
            mj_footer = MJRefreshAutoFooter(refreshingTarget: self, refreshingAction: #selector(pullUpBlockAction))
            
        }else if refreshType == .All {
            //下拉
            pullDownRefreshBlock = pullDownBlock
            let header:MJRefreshGifHeader = MJRefreshGifHeader(refreshingTarget: self, refreshingAction: #selector(pullDownBlockAction))
            //git动画数组
            header.setImages(idleImages as! [Any] , for: .idle)
            header.setImages(pullingImages as! [Any], for: .pulling)
            header.setImages(refreshingImages as! [Any], for: .refreshing)
            //是否隐藏上次更新时间
            header.lastUpdatedTimeLabel.isHidden = timeLabHidden
            //是否隐藏刷新状态的label
            header.stateLabel.isHidden = stateLabHidden
            mj_header = header
            //首次进来是否需要刷新
            if firstRefresh {
                mj_header.beginRefreshing()
            }
            //上拉
            pullUpRefreshBlock = pullUpBlock
            mj_footer = MJRefreshAutoFooter(refreshingTarget: self, refreshingAction: #selector(pullUpBlockAction))
        }
        
        /// 结束头部刷新
        func endHeaderRefresh() {
            if mj_header.isRefreshing {
                mj_header.endRefreshing()
                mj_footer.resetNoMoreData()
            }
            isUserInteractionEnabled = true
        }
        
        /// 结束尾部刷新
        ///
        /// - Parameter endRefreshType: 结束类型
        func endFooterRefresh(endRefreshType:CLEndRefreshType) {
            if !mj_footer.isRefreshing {
                
            }
            if endRefreshType == .NoData {
                mj_footer.endRefreshingWithNoMoreData()
                mj_footer.state = .noMoreData
            }else {
                mj_footer.endRefreshing()
                mj_footer.state = .idle
            }
            isUserInteractionEnabled = true
        }
        
        /// 结束刷新
        func endRefresh() {
            if mj_footer.isRefreshing {
                endFooterRefresh(endRefreshType: .Defayle)
            }
            if mj_header.isRefreshing {
                endHeaderRefresh()
            }
            isUserInteractionEnabled = true
        }
        
        /// block置空
        func deallocBlock() {
            pullUpRefreshBlock = nil
            pullDownRefreshBlock = nil
        }
        
        /// 头部开始刷新
        func headerBeginRefresh() {
            
            mj_header.beginRefreshing()
        }
    }
}


// MARK: - 点击事件
extension CLHomeCollectionView {
    
    /// 下拉时候触发
    @objc func pullDownBlockAction() {
        
        if (pullDownRefreshBlock != nil) {
            pullDownRefreshBlock!()
            isUserInteractionEnabled = false
        }
        
    }
    
    /// 上拉时候触发
    @objc func pullUpBlockAction() {
        if pullUpRefreshBlock != nil {
            pullUpRefreshBlock!()
            isUserInteractionEnabled = false
        }
        
    }
    
    
}





