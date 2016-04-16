//
//  AppDelegate.swift
//  BackgroundTaskDemo_Swift
//
//  Created by 张剑 on 16/4/16.
//  Copyright © 2016年 张剑. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var timer:NSTimer?;
    var backgroundTask = UIBackgroundTaskInvalid;
    var audioPlayer:AVAudioPlayer?;

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(AppDelegate.backgroundTimeAction), userInfo: nil, repeats: true);
        //方式2
        playAudio();
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        ZJLog.printLog("程序挂起");
        
        //方式1
        //启动后台任务
        if(UIDevice.currentDevice().multitaskingSupported){
            ZJLog.printLog("启动后台任务");
            self.backgroundTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler({
                ZJLog.printLog("后台任务到期");
                UIApplication.sharedApplication().endBackgroundTask(self.backgroundTask);
                self.backgroundTask = UIBackgroundTaskInvalid;
            })
 
        }
    }
    
    func backgroundTimeAction(){
        let backgroundTimeRemaining = UIApplication.sharedApplication().backgroundTimeRemaining;
        if(backgroundTimeRemaining == DBL_MAX){
            ZJLog.printLog("backgroundTimeRemaining:Undetermined");
        }else{
            ZJLog.printLog("backgroundTimeRemaining:\(backgroundTimeRemaining)");
        }
        
    }
    
    
    func playAudio(){
        let audioSession = AVAudioSession.sharedInstance();
        do{
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
        }catch{
        
        }
        
        let mainBundle = NSBundle.mainBundle();
        let filePath = mainBundle.pathForResource("空音乐", ofType: "mp3");
        let fileData = NSData(contentsOfFile: filePath!);
        do{
            self.audioPlayer = try AVAudioPlayer(data: fileData!);
            self.audioPlayer?.numberOfLoops = -1;
            if(self.audioPlayer!.prepareToPlay() && self.audioPlayer!.play()){
                ZJLog.printLog("开始播放");
            }else{
                ZJLog.printLog("播放失败");
            }
        }catch{
        
        }
    }

    func applicationDidEnterBackground(application: UIApplication) {
        ZJLog.printLog("程序进入后台");
    }

    func applicationWillEnterForeground(application: UIApplication) {
        ZJLog.printLog("程序将要进入前台");
    }

    func applicationDidBecomeActive(application: UIApplication) {
        ZJLog.printLog("程序激活");
        
        //终止后台任务
        UIApplication.sharedApplication().endBackgroundTask(self.backgroundTask);
        self.backgroundTask = UIBackgroundTaskInvalid;
        ZJLog.printLog("终止后台任务");
    }

    func applicationWillTerminate(application: UIApplication) {
        ZJLog.printLog("程序终止")
    }


}

