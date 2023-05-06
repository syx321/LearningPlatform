# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'LearningPlatform' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for LearningPlatform
  pod 'Swinject'
  pod 'SnapKit'
  pod 'Alamofire'
  pod 'MobileVLCKit'
  pod 'SDWebImage'
  pod 'YYModel'
  pod 'YYText'
  pod 'YYImage'
  pod 'MJRefresh'
  pod 'IJKPlayer' , :path => 'ijkplayer/'

end

post_install do |installer|
  installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
             end
        end
 end
end