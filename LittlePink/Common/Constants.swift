//
//  Constants.swift
//  LittlePink
//
//  Created by 马振洲 on 2023/1/9.
//

import UIKit


// MARK: StoryboardID
// Main storyboard -> show the identity inspector
let kNearByVCID = "NearByVCID"
let kFollowVCID = "FollowVCID"
let kDiscoveryVCID = "DiscoveryVCID"
let kWaterfallVCID = "WaterfallVCID"
let kNoteEditVCID = "NoteEditVCID"


// MARK: Cell相关ID
// Main storyboard ->Waterfall -> Collection View
let kWaterfallCellID = "WaterfallCellID"
// Main storyboard ->NoteEditVC -> PhotoCell
let kPhotoCellID = "PhotoCellID"
// Main storyboard ->NoteEditVC -> PhotoFooter
let kPhotoFooterID = "PhotoFooterID"


// MARK: 布局尺寸
let kWaterfallPadding: CGFloat = 4

// MARK: - 业务逻辑相关
let kChannels = ["推荐","旅行","娱乐","才艺","美妆","白富美","美食","萌宠"]

// MARK: -
let kMaxCameraZoomFactor: CGFloat = 5
let kMaxPhotoCount = 9 //picker选择照片时允许用户最多选几张
let kSpacingBetweenItems: CGFloat = 2

// 笔记
let KMaxNoteTitleCount = 20
