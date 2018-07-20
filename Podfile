# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'TravelWithFavors' do
  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
   use_frameworks!
   inhibit_all_warnings!
  # Pods for TravelWithFavors
  pod 'YYModel'
  pod 'YYCache'
  pod 'MJRefresh'
  pod 'SDWebImage'
  pod 'MBProgressHUD'
  pod 'SDCycleScrollView'
  pod 'IQKeyboardManager'
  pod 'AFNetworking'
  pod 'WMPageController'
  pod 'mob_sharesdk'
  # UI模块(非必须，需要用到ShareSDK提供的分享菜单栏和分享编辑页面需要以下1行)
  pod 'mob_sharesdk/ShareSDKUI'
  # 平台SDK模块(对照一下平台，需要的加上。如果只需要QQ、微信、新浪微博，只需要以下3行)
  pod 'mob_sharesdk/ShareSDKPlatforms/QQ'
  pod 'mob_sharesdk/ShareSDKPlatforms/SinaWeibo'
  pod 'mob_sharesdk/ShareSDKPlatforms/WeChatFull' #//（微信sdk带支付的命令，和上面不带支付的不能共存，只能选择一个）
  # pod 'mob_sharesdk/ShareSDKPlatforms/WeChat'  //（微信sdk不带支付的命令）
  # 使用配置文件分享模块（非必需）
  pod 'mob_sharesdk/ShareSDKConfigurationFile'
  # 扩展模块（在调用可以弹出我们UI分享方法的时候是必需的）
  pod 'mob_sharesdk/ShareSDKExtension'
  #极光推送
  pod 'JPush'
  target 'TravelWithFavorsTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'TravelWithFavorsUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
