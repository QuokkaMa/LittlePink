source 'https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git'

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
        end
    end
  end
end


# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

target 'LittlePink' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for LittlePink
  pod 'XLPagerTabStrip', '~> 9.0'
  pod 'CHTCollectionViewWaterfallLayout/Swift'
  # 图片处理
  pod 'YPImagePicker'
  # 提示框
  pod 'MBProgressHUD', '~> 1.2.0'
  # 图片放大
  pod 'SKPhotoBrowser'
  pod 'KMPlaceholderTextView', '~> 1.4.0'
  pod 'AMapLocation'
  
end



