//
//  OtherExtensions.swift
//  HiChongSwift
//
//  Created by eagle on 14/12/15.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

import Foundation

private let hostURLPrefix = "http://123.57.7.88/admin/"

extension UIImageView {
    func roundCorner() {
        let radius = min(self.bounds.width, self.bounds.height) / 2.0
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }
}

extension UITableView {
    func hideExtraSeprator() {
        let emptyView = UIView(frame: CGRectZero)
        self.tableFooterView = emptyView
    }
}

extension String {
    /**
    图片相对路径转换为绝对路径
    
    :returns: 绝对路径
    */
    func toAbsolutePath() -> String {
        return hostURLPrefix + self
    }
    
    func toAge() -> String {
        switch self {
        case "0":
            return "小于1岁"
        case "11":
            return "大于10岁"
        default:
            return "\(self)岁"
        }
    }
}
