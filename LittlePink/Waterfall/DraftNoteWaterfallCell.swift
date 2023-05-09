//
//  DraftNoteWaterfallCell.swift
//  LittlePink
//
//  Created by 马振洲 on 2023/4/19.
//

import UIKit

class DraftNoteWaterfallCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var deleteBth: UIButton!
    @IBOutlet weak var isVideoImageView: UIImageView!
    
    var draftNote: DraftNote?{
        didSet{
            guard let draftNote = draftNote else { return }
            
            imageView.image = UIImage(draftNote.coverPhoto) ?? imagePH
            
            let title = draftNote.title!
            titleLabel.text = title.isEmpty ? "无题" : title
            dateLabel.text = draftNote.updatedAt?.formattedDate
            isVideoImageView.isHidden = !draftNote.isVideo
        }
    }
    
}
