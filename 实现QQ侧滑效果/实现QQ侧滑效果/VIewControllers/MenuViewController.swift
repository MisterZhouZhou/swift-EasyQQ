//
//  MenuViewController.swift
//  实现QQ侧滑效果
//
//  Created by rayootech on 16/2/20.
//  Copyright © 2016年 rayootech. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    var menuLeftVC:MenuLefttViewController!
    var menuMainVC:MenuMainViewController!
    var menuRightVC:MenuRightViewController!
    
    //菜单缩放比例
    var scaleF:CGFloat!
    //手势滑动的速度
    var speedF:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scaleF=0
        self.speedF=0.5
        
        //添加手势
        let pan=UIPanGestureRecognizer(target: self, action: "handlePan:")
        self.menuMainVC.view.addGestureRecognizer(pan)
        
        //添加点击事件
        let tap=UITapGestureRecognizer(target: self, action: "handleTan:")
        //设置点击事件
        tap.numberOfTapsRequired=1;
        self.menuMainVC.view.addGestureRecognizer(tap)
        
        //绑定菜单视图
        self.view.addSubview(self.menuLeftVC.view)
        self.view.addSubview(self.menuRightVC.view)
        self.view.addSubview(self.menuMainVC.view)
        
        self.menuLeftVC.view.hidden=true
        self.menuRightVC.view.hidden=true
        self.menuMainVC.view.hidden=false
    }
    
    //实现手势拖动
    func handlePan(pan:UIPanGestureRecognizer){
     
        let translationPoint=pan.translationInView(self.view)
        //计算运动的轨迹
        self.scaleF=translationPoint.x*self.speedF+self.scaleF
        
        if(pan.view?.frame.origin.x>=0){
           //显示左边的菜单
           //改变视图的位置
            let x:CGFloat = (pan.view?.center.x)!+translationPoint.x*self.speedF
            //设置中心点
            pan.view?.center=CGPointMake(x, (pan.view?.center.y)!)
            //计算缩放
            let scaleX:CGFloat=1-scaleF/1000
            let scaleY:CGFloat=1-scaleF/1000
            //执行缩放
            pan.view?.transform=CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)
            
            //重置手势
            pan.setTranslation(CGPoint.zero, inView: self.view)
            
            //显示对应的菜单--显示左边的菜单
            menuLeftVC.view.hidden=false

            menuRightVC.view.hidden=true
        }else
        {
           //显示右边的菜单
            //改变视图的位置
            let x:CGFloat = (pan.view?.center.x)!+translationPoint.x*self.speedF
            //设置中心点
            pan.view?.center=CGPointMake(x, (pan.view?.center.y)!)
            //计算缩放
            let scaleX:CGFloat=1+scaleF/1000
            let scaleY:CGFloat=1+scaleF/1000
            //执行缩放
            pan.view?.transform=CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)
            
            //重置手势
            pan.setTranslation(CGPoint.zero, inView: self.view)
            
            //显示对应的菜单--显示左边的菜单
            menuLeftVC.view.hidden=true
            
            menuRightVC.view.hidden=false
        }
        
        //监听手势的结束
        if(pan.state==UIGestureRecognizerState.Ended){
          //还原菜单
          //判断手势偏移量
            let offsetX:CGFloat=self.speedF*160;
            if(self.scaleF>offsetX){
              //显示左边菜单
                self.showMenuLeft()
            }
            else if(self.scaleF < -offsetX)
            {
               //显示右边菜单
                self.showMenuRight()
            }else{
               //显示主菜单
                self.showMenuMain()
                self.scaleF=0
            }
        }
        
    }
    
    //点击住菜单回到主菜单界面
    func handleTan(tap:UITapGestureRecognizer){
        if(tap.state==UIGestureRecognizerState.Ended){
            self.showMenuMain()
            self.scaleF=0
        }
    }

    //显示主菜单
    func showMenuMain(){
      //核心动画
        UIView.beginAnimations(nil, context: nil)
        //执行动画
        self.menuMainVC.view.transform=CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0)
        //设置frame
        self.menuMainVC.view.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)
        UIView.commitAnimations()
    }
    
    func showMenuLeft(){
        //核心动画
        UIView.beginAnimations(nil, context: nil)
        //执行动画
        self.menuMainVC.view.transform=CGAffineTransformScale(CGAffineTransformIdentity, 0.75, 0.75)
        //设置frame
        self.menuMainVC.view.center=CGPointMake(360, self.view.frame.size.height/2)
        UIView.commitAnimations()
    }
    
    func showMenuRight(){
        //核心动画
        UIView.beginAnimations(nil, context: nil)
        //执行动画
        self.menuMainVC.view.transform=CGAffineTransformScale(CGAffineTransformIdentity, 0.75, 0.75)
        //设置frame
        self.menuMainVC.view.center=CGPointMake(0, self.view.frame.size.height/2)
        UIView.commitAnimations()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
