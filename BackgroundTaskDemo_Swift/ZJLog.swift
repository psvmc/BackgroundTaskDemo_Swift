//
//  ZJLog.swift
//  BackgroundTaskDemo_Swift
//
//  Created by 张剑 on 16/4/16.
//  Copyright © 2016年 张剑. All rights reserved.
//

import Foundation
class ZJLog{
    static var isDebug = true;
    static func  printLog<T>(message: T,file: String = #file,method: String = #function,line: Int = #line){
        if(isDebug){
            print("\((file as NSString).lastPathComponent):\(line) \(method): \(message)")
        }
    }
}