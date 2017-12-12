//
//  Constant.swift
//  Getty
//
//  Created by Hyyy on 2017/12/12.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

import UIKit

struct Constant {

    // MARK: - 尺寸相关
    struct Size {
        
        // 屏幕bounds
        static let kScreenBounds = UIScreen.main.bounds
        
        // 屏幕宽度
        static let kScreenWidth = UIScreen.main.bounds.size.width
        
        // 屏幕高度
        static let kScreenHeight = UIScreen.main.bounds.size.height
        
        // 导航栏高度
        static let kNavHeight = 44
        
        // 状态栏高度
        static let kStatusBarHeight = UIApplication.shared.statusBarFrame.size.height
    }
    
    // MARK: - 颜色相关
    struct Color {
        
        // App主色调
        static let kMainColor = UIColor (red: 0.42, green: 0.63, blue: 0.97, alpha: 1.00)
        
        // 标题颜色
        static let kTitleColor = UIColor (red: 0.27, green: 0.27, blue: 0.27, alpha: 1.00)
        
        // 描述文字颜色
        static let kDescColor = UIColor (red: 0.71, green: 0.71, blue: 0.71, alpha: 1.00)
        
        // 分割线颜色
        static let kSeperatorColor = UIColor (red: 0.90, green: 0.90, blue: 0.90, alpha: 1.00)
        
        // TableView背景色
        static let kTableBackgroundColor = UIColor (red: 0.97, green: 0.98, blue: 0.98, alpha: 1.00)
    }
    
    // MARK: - 字体相关
    struct Font {
        
        // size = 10
        static let kFontMini = UIFont.systemFont(ofSize: 10)
        
        // size = 12
        static let kFontTiny = UIFont.systemFont(ofSize: 12)
        
        // size = 14
        static let kFontSmall = UIFont.systemFont(ofSize: 14)
        
        // size = 16
        static let kFontMedium = UIFont.systemFont(ofSize: 16)
        
        // size = 18
        static let kFontBig = UIFont.systemFont(ofSize: 18)
        
        // size = 20
        static let kFontLarge = UIFont.systemFont(ofSize: 20)
        
        // size = 36
        static let kFontHuge = UIFont.systemFont(ofSize: 36)
    }
}
