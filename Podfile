platform :ios, '12.0'
inhibit_all_warnings!

target 'The Hitchhiker Prophecy' do
  use_frameworks!

  # Pods for The Hitchhiker Prophecy
  pod 'Alamofire', '4.7.3'
  pod 'AlamofireImage', '3.4.1'
  
  post_install do |installer|
   installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
     config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
    end
   end
  end
end
