//
//  CLRegisterCell+Extension.swift
//  TestDemo
//
//  Created by fuyongYU on 2018/5/28.
//  Copyright © 2018年 YeMaoZi. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(_ cellType: T.Type) {
        if Bundle.main.path(forResource: cellType.className, ofType: "nib") != nil {
            self.register(UINib(nibName: cellType.className, bundle: Bundle.main),
                          forCellReuseIdentifier: cellType.className)
        } else {
            self.register(cellType, forCellReuseIdentifier: cellType.className)
        }
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ cellType: T.Type, for indexPath: IndexPath) -> T {
        if let cell = self.dequeueReusableCell(withIdentifier: cellType.className, for: indexPath) as? T {
            return cell
        } else {
            fatalError("Dequeue cell failed at (row: \(indexPath.item), section: \(indexPath.section))")
        }
    }
    
    func register<T: UITableViewHeaderFooterView>(_ viewType: T.Type) {
        if Bundle.main.path(forResource: viewType.className, ofType: "nib") != nil {
            self.register(UINib(nibName: viewType.className, bundle: Bundle.main),
                          forHeaderFooterViewReuseIdentifier: viewType.className)
        } else {
            self.register(viewType, forHeaderFooterViewReuseIdentifier: viewType.className)
        }
    }
    
    func dequeueReusableView<T: UITableViewHeaderFooterView>(_ viewType: T.Type) -> T? {
        return self.dequeueReusableHeaderFooterView(withIdentifier: viewType.className) as? T
    }
    
}

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_ cellType: T.Type) {
        if Bundle.main.path(forResource: cellType.className, ofType: "nib") != nil {
            self.register(UINib(nibName: cellType.className, bundle: Bundle.main),
                          forCellWithReuseIdentifier: cellType.className)
        } else {
            self.register(cellType, forCellWithReuseIdentifier: cellType.className)
        }
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ cellType: T.Type, for indexPath: IndexPath) -> T {
        if let cell = self.dequeueReusableCell(withReuseIdentifier: cellType.className, for: indexPath) as? T {
            return cell
        } else {
            fatalError("Dequeue cell failed at (item: \(indexPath.item), section: \(indexPath.section))")
        }
    }
    
}



