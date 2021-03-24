# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'GHSApp' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for GHSApp
 
    pod 'lottie-ios'
    pod 'TwitterKit'
    pod 'TwitterCore'
    pod 'SwiftyJSON', '~> 4.0'
    pod 'NWPusher', '~> 0.7.0'
    pod 'Firebase'
    pod 'Firebase/Messaging'
    pod 'GoogleAPIClientForREST/Calendar'
    pod 'GoogleSignIn'
    pod 'Alamofire'
    pod 'SearchTextField'
    pod 'Fabric', '~> 1.7.11'
    pod 'Crashlytics', '~> 3.10.7'
    pod 'TextFieldEffects'
    pod 'Firebase/Core'
    pod 'Firebase/Auth'
    pod 'Firebase/Database'
    pod 'Firebase/Storage'


    post_install do |installer|
        installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
        end
    end
    
  end

