//
//  WaterfallVC.swift
//  LittlePink
//
//  Created by 马振洲 on 2023/1/11.
//

import UIKit
import CHTCollectionViewWaterfallLayout
import XLPagerTabStrip

class WaterfallVC: UICollectionViewController {
    
    var channel = ""
    var draftNotes: [DraftNote] = []
    var isMyDraft = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        
        getDraftNotes()
        
    }


    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if isMyDraft{
            return draftNotes.count
        }else{
            return 13
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isMyDraft{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kDraftNoteWaterfallCellID, for: indexPath) as! DraftNoteWaterfallCell
            cell.draftNote = draftNotes[indexPath.item]
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kWaterfallCellID, for: indexPath) as! WaterfallCell
            cell.imageview.image = UIImage(named: "\(indexPath.item + 1)")
            return cell
        }
    }

}

// MARK: - CHTCollectionViewDelegateWaterfallLayout
extension WaterfallVC: CHTCollectionViewDelegateWaterfallLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        UIImage(named: "\(indexPath.item + 1)")!.size
    }
}

// MARK: - IndicatorInfoProvider
extension WaterfallVC: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        IndicatorInfo(title: channel)
    }
}
