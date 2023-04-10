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
let kChannelTableVCID = "ChannelTableVCID"

let kLoginNaviID = "LoginNaviID"
let kLoginVCID = "LoginVCID"
let kMeVCID = "MeVCID"
let kDraftNotesNaviID = "DraftNotesNaviID"
let kNoteDetailVCID = "NoteDetailVCID"
let kIntroVCID = "IntroVCID"
let kEditProfileNaviID = "EditProfileNaviID"
let kSettingTableVCID = "SettingTableVCID"

// MARK: Cell相关ID
// Main storyboard ->Waterfall -> Collection View
let kWaterfallCellID = "WaterfallCellID"
// Main storyboard ->NoteEditVC -> PhotoCell
let kPhotoCellID = "PhotoCellID"
// Main storyboard ->NoteEditVC -> PhotoFooter
let kPhotoFooterID = "PhotoFooterID"

let kSubChannelCellID = "SubChannelCellID"
let kPOICellID = "POICellID"
let kDraftNoteWaterfallCellID = "DraftNoteWaterfallCellID"
let kMyDraftNoteWaterfallCellID = "MyDraftNoteWaterfallCellID"
let kCommentViewID = "CommentViewID"
let kReplyCellID = "ReplyCellID"
let kCommentSectionFooterViewID = "CommentSectionFooterViewID"

// MARK: - 资源文件相关
let mainColor = UIColor(named: "mainColor")!
let mainLightColor = UIColor(named: "main-light")!
let blueColor = UIColor(named: "blue")!
let imagePH = UIImage(named: "imagePH")!

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
let kMaxNoteTextCount = 1000


//话题
let kAllSubChannels = [
    ["穿神马是神马", "就快瘦到50斤啦", "花5个小时修的靓图", "网红店入坑记"],
    ["魔都名媛会会长", "爬行西藏", "无边泳池只要9块9"],
    ["小鲜肉的魔幻剧", "国产动画雄起"],
    ["练舞20年", "还在玩小提琴吗,我已经尤克里里了哦", "巴西柔术", "听说拳击能减肥", "乖乖交智商税吧"],
    ["粉底没有最厚,只有更厚", "最近很火的法属xx岛的面霜"],
    ["我是白富美你是吗", "康一康瞧一瞧啦"],
    ["装x西餐厅", "网红店打卡"],
    ["我的猫儿子", "我的猫女儿", "我的兔兔"]
]
