//
//  CalendarViewController.swift
//  calendar
//
//  Created by Li Shi Wei on 9/3/16.
//  Copyright © 2016 lsw. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    
    let dateFormat = "yyyy年 M月 d日 HH:mm"
    let dateFormatFromCell = "yyyy-M-d HH:mm"
    
    @IBOutlet var cv: UICollectionView!
    @IBOutlet var cvHeader: UIView!
    @IBOutlet var lbSelectedDateTime: UILabel!
    
    @IBAction func lbSelectedDateTimeClick(sender:AnyObject)
    {
        let strDate = lbSelectedDateTime.text
        let formatter = NSDateFormatter()
        formatter.dateFormat = dateFormat
        let date = formatter.dateFromString(strDate!)
        
        //        self.performSegueWithIdentifier("toDateSelectController", sender: self)
        let dateSelectController = self.storyboard!.instantiateViewControllerWithIdentifier("DateSelectController") as! DateSelectController
        
        dateSelectController.selectedDate = date
        dateSelectController.dateSelectedAction = { date in
            self.currentMonthDate = date
            self.source = self.getSource(self.currentMonthDate)
            self.cv.reloadData()
            self.loadTitle()
        }
        self.navigationController?.pushViewController(dateSelectController, animated: true)
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
        lbSelectedDateTime.layer.borderColor = UIColor.lightGrayColor().CGColor
        lbSelectedDateTime.layer.borderWidth = 1
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.navigationController?.navigationBarHidden = true
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBarHidden = false
    }
    
    func loadTitle()  {
        lbSelectedDateTime.text = currentMonthDate.toFormatString(dateFormat)
    }
    
    var currentMonthDate : NSDate = NSDate()
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        source = getSource(currentMonthDate)
        
        let layout = MonthViewLayout()
        layout.scrollDirection = .Vertical
        //layout.scrollDirection = .Horizontal
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
        cv.contentOffset.y = cv.frame.size.height
        // cv.contentOffset.x = cv.frame.size.width
        
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
        
        let borderHeight = cv.frame.size.height;
        let border1 = createLayerBottomBorder(1)
        cv.layer.addSublayer(border1)
        let border2 = createLayerBottomBorder(borderHeight-1)
        cv.layer.addSublayer(border2)
        let border3 = createLayerBottomBorder(borderHeight+1)
        cv.layer.addSublayer(border3)
        let border4 = createLayerBottomBorder(borderHeight*2-1)
        cv.layer.addSublayer(border4)
        let border5 = createLayerBottomBorder(borderHeight*2+1)
        cv.layer.addSublayer(border5)
        let border6 = createLayerBottomBorder(borderHeight*3-1)
        cv.layer.addSublayer(border6)
    }
    
    func createLayerBottomBorder(height:CGFloat) -> CALayer {
        let layer2 = CALayer()
        let widthLayer2 = cv.frame.size.width
        layer2.frame = CGRectMake(CGFloat(0), height, widthLayer2, CGFloat(1))
        layer2.backgroundColor = UIColor.orangeColor().CGColor
        
        return layer2
    }
    func createLayerRightBorder(width:CGFloat) -> CALayer {
        let layer2 = CALayer()
        let height = cv.frame.size.height
        layer2.frame = CGRectMake(width,CGFloat(1),CGFloat(1), height)
        layer2.backgroundColor = UIColor.orangeColor().CGColor
        
        return layer2
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var source = Array<DayModel!>()
    
    func getSource(date: NSDate) -> Array<DayModel!>
    {
        let month = MonthSource()
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
    
    //选中某一天
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell: DayColletionViewCell  = collectionView.cellForItemAtIndexPath(indexPath) as! DayColletionViewCell
       
        if cell != currentSelectedDayCell {
            
            if let beforeSelectedCell = currentSelectedDayCell {
                beforeSelectedCell.lbDay.backgroundColor = UIColor.whiteColor()
                beforeSelectedCell.lbDay.textColor = UIColor.blackColor()
            }
            
            let beginIndex = indexPath.section == 0 ? 0 : (42 * indexPath.section)
            
            let selected = source[indexPath.row + beginIndex]
            
            if cell != currentTodayCell {
                
                //当前月的日期选中
                cell.lbDay.textColor = UIColor.whiteColor()
                cell.lbDay.backgroundColor = UIColor.lightGrayColor()
                
                currentSelectedDayCell = cell
            }
            else
            {
                currentSelectedDayCell = nil
            }
            
            let formatter = NSDateFormatter()
            formatter.dateFormat = dateFormatFromCell
            let currentTime = currentMonthDate.toFormatString(" HH:mm")
            
            let date = formatter.dateFromString(selected.formatDate + " " + currentTime)
            
            currentMonthDate = date!
            
            loadTitle()
        }
    }
    
    var currentSelectedDayCell: DayColletionViewCell! = nil
    var currentTodayCell: DayColletionViewCell! = nil
    //每个UICollectionView展示的内容
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell: DayColletionViewCell  = collectionView.dequeueReusableCellWithReuseIdentifier("defaultCell", forIndexPath: indexPath) as! DayColletionViewCell
        
        let beginIndex = indexPath.section == 0 ? 0 : (42 * indexPath.section)
//        
//        let currentRow = indexPath.item/7
//        if currentRow < 5 {
//            cell.layer.addSublayer(createLayerBottomBorder(cell.frame.size.height-1))
//
        
        cell.lbDay.backgroundColor = UIColor.whiteColor()
        let selectedDay = currentMonthDate.day
        
        if let model = source[indexPath.row  + beginIndex] {
            cell.lbDay.text = String(model.day)
            cell.lbSixtyDay.attributedText = ColorText.getColorEraText(model.eraDay.c, terrestial: model.eraDay.t);        if model.isSolarTerm
            {
                cell.lbLunaryDay.text = model.solarTermText
                //cell.lbLunaryDay.backgroundColor = UIColor.orangeColor()
                cell.lbLunaryDay.textColor = UIColor.orangeColor()
            }
            else
            {
                cell.lbLunaryDay.text = model.lunarDay
                cell.lbLunaryDay.textColor = UIColor.grayColor()
            }
            
            if(model.isToday)
            {
                //因为我一次绑定三页，如果section等于第1页的时候有currentToday就把第二页的格给设定值了
                //所以先要判断只有第二页的时候才能够出现today
                if indexPath.section == 1 {
                    currentTodayCell = cell
                }
                
                cell.lbDay.textColor = UIColor.whiteColor()
                cell.lbDay.backgroundColor = UIColor.orangeColor()
                 print(cell.lbDay.text)
            }
            else if(model.isSelected && !model.isToday && selectedDay == model.day)
            {
                currentSelectedDayCell = cell
                cell.lbDay.textColor = UIColor.whiteColor()
                cell.lbDay.backgroundColor = UIColor.lightGrayColor()
                //print(cell.lbDay.text)
            }
            else
            {
                cell.lbDay.backgroundColor = UIColor.whiteColor()
                cell.lbDay.textColor = UIColor.blackColor()
            }
            
        }
        else
        {
            cell.lbDay.text = ""
            cell.lbSixtyDay.text = ""
            cell.lbLunaryDay.text = ""
        }
        //NSLog("section index path=%d", indexPath.section)
        
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
        
        //var page : Int = Int(floor(self.cv.contentOffset.x / cvbounds.size.width))
        var page : Int = Int(floor(self.cv.contentOffset.y / cvbounds.size.height))
        
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
        cv.contentOffset.y = cv.frame.size.height
        //cv.contentOffset.x = cv.frame.size.width
        
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
