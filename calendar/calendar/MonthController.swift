//
//  MonthController.swift
//  calendar
//
//  Created by Li Shi Wei on 8/31/16.
//  Copyright © 2016 lsw. All rights reserved.
//

import UIKit

class MonthController: UIViewController , UIScrollViewDelegate{

    var _lView: UIView!
    var _mView: UIView!
    var _rView: UIView!
    
    enum ScrollState : Int{
        case Current = 0
        case ToLeft = 1
        case ToRight = 2
    }

    let VELOCITY_STANDAD : CGFloat = 0.6
    var scrollState = ScrollState.Current
    var scrollBeginOffset : CGFloat = 0
  
    
    @IBOutlet var _scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
      reloadView()
        
        _scrollView.delegate = self
        
        
        
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.scrollBeginOffset = scrollView.contentOffset.x
        self.scrollState = .Current
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        var point = targetContentOffset.memory
        
        if(velocity.x > VELOCITY_STANDAD)
        {
            self.scrollState = .ToRight
        }
        
        if(velocity.x < -VELOCITY_STANDAD){
            self.scrollState = .ToLeft
        }
        
        let scrollDistance = self.scrollBeginOffset - scrollView.contentOffset.x
        let standardDistance = _scrollView.frame.size.width/3
        
        if scrollDistance < -standardDistance {
            self.scrollState = .ToRight
        }
        
        if scrollDistance > standardDistance
        {
            self.scrollState = .ToLeft
        }
        
        if(self.scrollState == .ToLeft)
        {
            _scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
            
            point.x = 0
        }
        
        if(self.scrollState == .ToRight)
        {
            _scrollView.setContentOffset(CGPointMake(scrollView.frame.size.width * 2, 0), animated: true)
            
            point.x = scrollView.frame.size.width * 2
        }
        
        targetContentOffset.memory = point
    }
    
    
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        _scrollView.userInteractionEnabled = false
//    }
//    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if(scrollView.contentOffset.x == 0)
        {
            _scrollView.contentOffset = CGPointMake(scrollView.frame.size.width, 0)
        }
        else if(scrollView.contentOffset.x == scrollView.frame.size.width)
        {
        
        }
        else if(scrollView.contentOffset.x == scrollView.frame.size.width * 2)
        {
            _scrollView.contentOffset = CGPointMake(scrollView.frame.size.width, 0)
        }
        
        //scrollView.userInteractionEnabled = true;
    }
//
    func reloadView() {
        
        let width = _scrollView.frame.size.width
        let height = _scrollView.frame.size.height

        
        _scrollView.contentSize = CGSizeMake(3 * width, 0)
        _scrollView.contentOffset = CGPointMake(width, 0)
        
        
        _lView = UIView.init(frame: CGRectMake(0, 0, width, height))
        _lView.backgroundColor = UIColor.redColor()
        _scrollView.addSubview(_lView)
        
        _mView = UIView.init(frame: CGRectMake(width, 0, width, height))
        _mView.backgroundColor = UIColor.yellowColor()
        _scrollView.addSubview(_mView)
        
        _rView = UIView.init(frame: CGRectMake(width*2, 0, width, height))
        _rView.backgroundColor = UIColor.blueColor()
        _scrollView.addSubview(_rView)
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
