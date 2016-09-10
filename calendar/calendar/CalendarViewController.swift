//
//  CalendarViewController.swift
//  calendar
//
//  Created by Li Shi Wei on 9/3/16.
//  Copyright © 2016 lsw. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var cv: UICollectionView!
    @IBOutlet var cvHeader: UIView!
    @IBOutlet var lbSelectedDateTime: UILabel!
    
    @IBAction func lbSelectedDateTimeClick(sender:AnyObject)
    {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy年M月d日 HH:mm"
        let str = formatter.stringFromDate(NSDate())
        //lbSelectedDateTime.text = str + dayModel.day
        
    }
    
    //var dayModel = DayModel(day: "2")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cv.dataSource = self;
        cv.delegate = self;
        cv.backgroundColor = UIColor.whiteColor()
        
        let selectDateTimeTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CalendarViewController.lbSelectedDateTimeClick(_:)))
        lbSelectedDateTime.userInteractionEnabled = true
        lbSelectedDateTime.addGestureRecognizer(selectDateTimeTap)
        
        
        
        loadTitle()
        // Do any additional setup after loading the view.
    }
    
    func loadTitle()  {
        lbSelectedDateTime.text = currentMonthDate.toFormatString("yyyy年 M月 d日 HH:mm")
    }
    
    var currentMonthDate : NSDate = NSDate()
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
     
        source = getSource(currentMonthDate)
        
        let layout = MonthViewLayout()
        //layout.scrollDirection = .Vertical
        layout.scrollDirection = .Horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let size = UIScreen.mainScreen().bounds
        //在这给每一个item cell设置大小，因为在viewDidLoad方法时还得不到整体viewcollection的size，得到的是默认在stoarybord里的那个尺寸
        let itemWidth = (size.width-20) / CGFloat(7)
        layout.itemSize = CGSizeMake(itemWidth, cv.frame.size.height / CGFloat(6))
        
        cv.collectionViewLayout = layout
        cv.pagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        
        //初始化第几页
        //cv.contentOffset.y = cv.frame.size.height
         cv.contentOffset.x = cv.frame.size.width
        
//        NSLog("height=%f", cv.frame.size.height)
        
        let cvHeaderTitle :[String] = ["日","一","二","三","四","五","六"]
        var x = CGFloat(0);
        for i in 1...7 {
            let label = UILabel(frame: CGRectMake(x,0,itemWidth,cvHeader.frame.size.height))
            
            label.text = cvHeaderTitle[i-1]
            label.textColor = UIColor.whiteColor()
            label.textAlignment = NSTextAlignment.Center
            cvHeader.addSubview(label)
            cvHeader.backgroundColor = UIColor.redColor()
            x = itemWidth * CGFloat(i)
        }
        
       
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var source = Array<DayModel!>()
    
    func getSource(date: NSDate) -> Array<DayModel!>
    {
        let month = MonthSource(date:date)
        var s = Array<DayModel!>()
        let pre = month.buildOneMonthSource(date.plusMonths(-1))
        let current = month.buildOneMonthSource(date)
        let next = month.buildOneMonthSource(date.plusMonths(1))
        
        s.appendContentsOf(pre)
        s.appendContentsOf(current)
        s.appendContentsOf(next)
        
        return s
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }
    
    //定义展示的UICollectionViewCell的个数
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //NSLog("section=%d", section)
        return 42
    }

    //每个UICollectionView展示的内容  
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell: DayColletionViewCell  = collectionView.dequeueReusableCellWithReuseIdentifier("defaultCell", forIndexPath: indexPath) as! DayColletionViewCell
        
        let beginIndex = indexPath.section == 0 ? 0 : (42 * indexPath.section)
        
        if let model = source[indexPath.row  + beginIndex] {
            cell.lbDay.text = String(model.day)
            cell.lbSixtyDay.text = model.eraDay
            if model.isSolarTerm
            {
                cell.lbLunaryDay.text = model.solarTermText
            }
            else
            {
                cell.lbLunaryDay.text = model.lunarDay
            }
        }
        else
        {
            cell.lbDay.text = ""
            cell.lbSixtyDay.text = ""
            cell.lbLunaryDay.text = ""
        }
        
        
        //NSLog("section index path=%d", indexPath.section)
        
        cell.lbDay.textColor = UIColor.blackColor()
        cell.lbSixtyDay.textColor = UIColor.lightGrayColor()
        cell.lbLunaryDay.textColor = UIColor.grayColor()
        
//        cell.lbDay.backgroundColor = UIColor.redColor()
//        cell.lbSixtyDay.backgroundColor = UIColor.purpleColor()
//        cell.lbLunaryDay.backgroundColor = UIColor.purpleColor()
        
        return cell;
        
    }
    

    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.calculateDateBasedOnScrollViewPosition(scrollView)
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        self.calculateDateBasedOnScrollViewPosition(scrollView)
    }
    
    
    func calculateDateBasedOnScrollViewPosition(scrollView: UIScrollView) {
        
        let cvbounds = self.cv.bounds
        
        var page : Int = Int(floor(self.cv.contentOffset.x / cvbounds.size.width))
        
        page = page > 0 ? page : 0
        
        if page == 2 {
            currentMonthDate = currentMonthDate.plusMonths(1)
            source = getSource(currentMonthDate)
            cv.reloadData()
            loadTitle()
        }
        if page == 0 {
            currentMonthDate = currentMonthDate.plusMonths(-1)
            source = getSource(currentMonthDate)
            cv.reloadData()
            loadTitle()
        }
        //cv.contentOffset.y = cv.frame.size.height
        cv.contentOffset.x = cv.frame.size.width

    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //
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

class MonthViewLayout: UICollectionViewFlowLayout {
    
    
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        return super.layoutAttributesForElementsInRect(rect)?.map
            {
                attrs in
                let attrscp = attrs.copy() as! UICollectionViewLayoutAttributes
                self.applyLayoutAttributes(attrscp)
                return attrscp
        }
        
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
        if let attrs = super.layoutAttributesForItemAtIndexPath(indexPath)
        {
            let attrscp = attrs.copy() as! UICollectionViewLayoutAttributes
            self.applyLayoutAttributes(attrscp)
            return attrscp
        }
        return nil
        
    }
    
    
    func applyLayoutAttributes(attributes : UICollectionViewLayoutAttributes) {
        
        if attributes.representedElementKind != nil {
            return
        }
        
        if let collectionView = self.collectionView {
            
            let stride = (self.scrollDirection == .Horizontal) ? collectionView.frame.size.width : collectionView.frame.size.height
            
            let offset = CGFloat(attributes.indexPath.section) * stride
            
            var xCellOffset : CGFloat = CGFloat(attributes.indexPath.item % 7) * self.itemSize.width
            
            var yCellOffset : CGFloat = CGFloat(attributes.indexPath.item / 7) * self.itemSize.height
            
            if(self.scrollDirection == .Horizontal) {
                xCellOffset += offset;
            } else {
                yCellOffset += offset
            }
            
            attributes.frame = CGRectMake(xCellOffset, yCellOffset, self.itemSize.width, self.itemSize.height)
        }
        
    }
}
