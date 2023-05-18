//
//  NoteEditVC-DraftNote.swift
//  LittlePink
//
//  Created by 马振洲 on 2023/5/16.
//

extension NoteEditVC{
    // MARK: 创建草稿
    func createDraftNote(){
        
        // 开启后台 并发队列
        backgroundContext.perform {
            let draftNote = DraftNote(context: backgroundContext)
            
            //视频
            if self.isVideo{
                draftNote.video = try? Data(contentsOf: self.videoURL!)
            }
            //图片
            self.handlePhotos(draftNote)
            
            draftNote.isVideo = self.isVideo
            self.handleOthers(draftNote)
            
            DispatchQueue.main.async {
                self.showTextHUD("保存草稿成功",false)
            }
        }
        dismiss(animated: true)
        
    }
    // MARK: 更新草稿
    func updateDraftNote(_ draftNote: DraftNote){
        backgroundContext.perform {
            if !self.isVideo{
                self.handlePhotos(draftNote)
            }
            self.handleOthers(draftNote)
            
            DispatchQueue.main.async {
                self.updateDraftNoteFinished?()
            }
        }
        // 返回上个页面
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - 上面分离出来的函数
extension NoteEditVC{
    
    private func handlePhotos(_ draftNote: DraftNote){
        //封面图片
        draftNote.coverPhoto = photos[0].jpeg(.high)
        //所有图片
        var photos: [Data] = []
        for photo in self.photos{
            if let pngData = photo.pngData(){
                photos.append(pngData)
            }
        }
        draftNote.photos = try? JSONEncoder().encode(photos)
    }
    
    private func handleOthers(_ draftNote: DraftNote){
        
        DispatchQueue.main.async {
            draftNote.title = self.titleTextField.exactText
            draftNote.text = self.textView.exactText
        }
        draftNote.channel = channel
        draftNote.subChannel = subChannel
        draftNote.poiName = poiName
        draftNote.updatedAt = Date()
        
        appDelegate.saveBackgroundContext()
    }
}
