//
//  NoteEditVC-DragDrop.swift
//  LittlePink
//
//  Created by 马振洲 on 2023/3/31.
//

import Foundation


// MARK: - UICollectionViewDragDelegate
extension NoteEditVC: UICollectionViewDragDelegate{
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider(object: photos[indexPath.item]))]
    }
}

// MARK: - UICollectionViewDropDelegate
extension NoteEditVC: UICollectionViewDropDelegate{
    
    // 拖着移动时-可选实现, 但一般都实现,频繁调用,代码尽可能快速简单执行
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if collectionView.hasActiveDrag{
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
         
    }
}
