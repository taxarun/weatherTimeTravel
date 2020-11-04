//
//  ImmediatePickView.swift
//  WeatherTimeTravel
//
//  Created by Nikolay Ermakov on 01.11.2020.
//

import UIKit
import RxSwift

class ImmediatePickView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Private
    var kvoFrameToken: NSKeyValueObservation?
    
    var selectionView: UIView?
    
    var tableView : UITableView? {
        didSet {
            if let localTable = tableView {
                self.addSubview(localTable)
                localTable.dataSource = self
                localTable.delegate = self
                localTable.separatorStyle = .none
                localTable.showsVerticalScrollIndicator = false
                localTable.allowsSelection = false
                localTable.translatesAutoresizingMaskIntoConstraints = false
                localTable.register(ImmediatePickViewCell.self, forCellReuseIdentifier: ImmediatePickViewCell.reuseIdentifier())
                
                kvoFrameToken?.invalidate()
                kvoFrameToken = localTable.observe(\.bounds, options: [.new, .old]) { (table, change) in
                    
                    let newValue = change.newValue
                    let oldValue = change.oldValue
                    if newValue != nil && oldValue != nil {
                        if newValue!.size != oldValue!.size {
//                            table.beginUpdates()
                            var oldRowHeight = table.rowHeight
                            if oldRowHeight < 0.0 {
                                oldRowHeight = 0.0
                            }
                            table.rowHeight = newValue!.height / 3
                            table.contentInset = UIEdgeInsets(top: table.rowHeight, left: 0.0, bottom: table.rowHeight, right: 0.0)
                            if table.contentOffset.y == -oldRowHeight {
                                table.contentOffset = CGPoint(x: 0.0, y: -table.rowHeight)
                            }
                            self.p_scrollToSelection()
//                            table.endUpdates()
                        }
                    }
                }
                
                NSLayoutConstraint.activate([
                    localTable.topAnchor.constraint(equalTo: self.topAnchor),
                    localTable.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                    localTable.rightAnchor.constraint(equalTo: self.rightAnchor),
                    localTable.leftAnchor.constraint(equalTo: self.leftAnchor),
                ])
                
                selectionView?.removeFromSuperview()
                selectionView = UIView()
                selectionView!.isUserInteractionEnabled = false
                selectionView!.backgroundColor = UIColor(white: 0.75, alpha: 0.5)
                selectionView!.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview(selectionView!)
                
                NSLayoutConstraint.activate([
                    selectionView!.heightAnchor.constraint(equalTo: localTable.heightAnchor, multiplier: 0.333),
                    selectionView!.centerYAnchor.constraint(equalTo: localTable.centerYAnchor),
                    selectionView!.rightAnchor.constraint(equalTo: localTable.rightAnchor),
                    selectionView!.leftAnchor.constraint(equalTo: localTable.leftAnchor),
                ])
            }
        }
    }
    
    deinit {
        kvoFrameToken?.invalidate()
    }
    
    var titleProvider : (Int) -> String = { _ in "Set name provider" }
    
    var elementsCount : Int = 0
    
    func p_findSelectedCell() -> UITableViewCell? {
        let tableCenter = tableView!.contentOffset.y + tableView!.bounds.height * 0.5
        var closestCell : UITableViewCell?
        var lowestDiff = CGFloat.greatestFiniteMagnitude
        for cell in tableView!.visibleCells {
            var diff : CGFloat = 0.0
            if cell.center.y > tableCenter {
                diff = cell.center.y - tableCenter
            } else {
                diff = tableCenter - cell.center.y
            }
            
            if diff < lowestDiff {
                lowestDiff = diff
                closestCell = cell
            }
        }
        
        return closestCell
    }
    
    func p_scrollToSelection() {
        let closestCell = self.p_findSelectedCell()
        if closestCell != nil {
            let newPoint = CGPoint(x: 0.0, y: closestCell!.frame.origin.y - closestCell!.frame.height)
            tableView?.setContentOffset(newPoint, animated: true)
        }
    }
    
    var _currentElement : UInt = 0
    
    // MARK: Public
    public private(set) var currentElement : BehaviorSubject<UInt> = BehaviorSubject(value: 0)
    
    public func specifyCurrentElement(currentElement: UInt) {
        _currentElement = currentElement
        self.currentElement.onNext(currentElement)
        if tableView != nil {
            let newOffset = tableView!.rowHeight * CGFloat(currentElement) - tableView!.contentInset.top
            tableView?.setContentOffset(CGPoint(x: 0.0, y: newOffset), animated: true)
        }
    }
    
    public func refresh(elementsNum: UInt, nameProvider: @escaping (Int) -> String) {
        elementsCount = Int(elementsNum);
        titleProvider = nameProvider
        
        if tableView == nil {
            tableView = UITableView()
        }
        
        tableView?.reloadData()
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elementsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImmediatePickViewCell.reuseIdentifier(), for: indexPath)
        if let rightCell = cell as? ImmediatePickViewCell {
            rightCell.configureWithTitle(title: self.titleProvider(indexPath.row))
        }
        return cell
    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView === scrollView {
            let closestCell = self.p_findSelectedCell()
            
            if closestCell != nil {
                let newCurrent = UInt(closestCell!.frame.origin.y / tableView!.rowHeight)
                if _currentElement != newCurrent {
                    _currentElement = newCurrent
                    currentElement.onNext(newCurrent)
                }
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if tableView === scrollView {
            self.p_scrollToSelection()
        }
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if tableView === scrollView {
            self.p_scrollToSelection()
        }
    }
}
