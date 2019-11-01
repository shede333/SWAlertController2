#
# Be sure to run `pod lib lint SWAlertController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SWAlertController'
  s.version          = '0.1.0'
  s.summary          = 'UIAlertController的自定义实现'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
UIAlertController的自定义实现，支持更丰富的UI定制，支持更多的UI控件；
                       DESC

  s.homepage         = 'https://github.com/shede333/SWAlertController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'shede333' => '333wshw@163.com' }
  s.source           = { :git => 'https://github.com/shede333/SWAlertController.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform = :ios
  s.ios.deployment_target = '8.0'

  s.source_files = 'SWAlertController/Classes/**/*'
  s.prefix_header_file = 'SWAlertController/Classes/SWAlertControllerPrefix.pch'
  
  # s.resource_bundles = {
  #   'SWAlertController' => ['SWAlertController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  
  s.dependency 'Masonry', '~> 1.1.0'
  s.dependency 'YYKit', '~> 1.0.9'
  
end
