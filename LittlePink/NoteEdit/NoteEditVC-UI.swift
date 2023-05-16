//
//  NoteEditVC-UI.swift
//  LittlePink
//
//  Created by 马振洲 on 2023/4/13.
//


extension NoteEditVC{
    func setUI(){
        setDraftNoteEditUI()
    }
}


//编辑草稿笔记/笔记时的统一处理
extension NoteEditVC{
    private func setDraftNoteEditUI(){
        if let draftNote = draftNote{
            titleTextField.text = draftNote.title
            textView.text = draftNote.text
            channel = draftNote.channel!
            subChannel = draftNote.subChannel!
            poiName = draftNote.poiName!
            
            if !subChannel.isEmpty{ updateChannelUI() }
            if !poiName.isEmpty{ updatePOINameUI() }
        }
    }
    
    func updateChannelUI(){
        channelIcon.tintColor = blueColor
        channelLabel.text = subChannel
        channelLabel.textColor = blueColor
        channelPlaceholderLabel.isHidden = true
    }
    
    func updatePOINameUI(){
        if poiName == ""{
            poiNameIcon.tintColor = .label
            poiNameLabel.text = "添加地点"
            poiNameLabel.textColor = .label
        }else{
            poiNameIcon.tintColor = blueColor
            poiNameLabel.text = poiName
            poiNameLabel.textColor = blueColor
        }
    }
}
