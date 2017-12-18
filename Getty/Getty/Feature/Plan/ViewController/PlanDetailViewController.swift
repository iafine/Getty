//
//  PlanDetailViewController.swift
//  Getty
//
//  Created by Hyyy on 2017/12/17.
//  Copyright © 2017年 Getty. All rights reserved.
//

import UIKit
import JTAppleCalendar

class PlanDetailViewController: UIViewController {

    let calendarView: JTAppleCalendarView = {
        
        let calendarView = JTAppleCalendarView()
        calendarView.scrollDirection = .horizontal
        calendarView.showsVerticalScrollIndicator = false
        calendarView.showsHorizontalScrollIndicator = false
        calendarView.isPagingEnabled = true
        calendarView.backgroundColor = UIColor.white
        
        calendarView.register(PlanCalendarItemCell.self, forCellWithReuseIdentifier: NSStringFromClass(PlanCalendarItemCell.self))
        calendarView.register(JTAppleCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: NSStringFromClass(JTAppleCollectionReusableView.self))
        
        return calendarView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        navigationItem.title = "详细"
        
        calendarView.calendarDataSource = self
        calendarView.calendarDelegate = self
        
        view.addSubview(calendarView)
        
        subviewsLayout()
    }
    
    func subviewsLayout() {
        calendarView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(64)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.height.equalTo(300)
        }
    }
}

extension PlanDetailViewController: JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let startDate = dateFormatter.date(from: "2017-11-01")
        let endDate = dateFormatter.date(from: "2017-12-31")

        let configuration = ConfigurationParameters(startDate: startDate!, endDate: endDate!)
        
        return configuration
    }
}

extension PlanDetailViewController: JTAppleCalendarViewDelegate {
    func calendarSizeForMonths(_ calendar: JTAppleCalendarView?) -> MonthSize? {
        return MonthSize(defaultSize: 50)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTAppleCollectionReusableView {
        
        let reusableView = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: NSStringFromClass(JTAppleCollectionReusableView.self), for: indexPath)
        reusableView.backgroundColor = UIColor.red
        
        return reusableView
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell: PlanCalendarItemCell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: NSStringFromClass(PlanCalendarItemCell.self), for: indexPath) as! PlanCalendarItemCell
        cell.titleLabel.text = cellState.text
        
        return cell
    }
}
