#
# Be sure to run `pod lib lint MoreMe2SDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MoreMe2SDK'
  s.version          = '0.1.0'
  s.summary          = 'A short description of MoreMe2SDK.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/304635659@qq.com/MoreMe2SDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '304635659@qq.com' => '304635659@qq.com' }
  s.source           = { :git => 'https://github.com/hamewang/MoreMe2SDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  # s.source_files = 'MoreMe2SDK/Classes/**/*'
  
  s.vendored_frameworks = 'MoreMe2SDK/Classes/*.framework'

  s.resources = 'MoreMe2SDK/Classes/*.bundle'
  
  s.dependency 'AFNetworking','3.2.1'
  s.dependency 'AliyunOSSiOS','2.10.7'
  s.dependency 'OpenCV','4.1.0'
  s.dependency 'GPUImage','0.1.7'
  s.dependency 'SVProgressHUD','2.2.5'
  s.dependency 'CocoaSecurity','1.2.4'
  s.dependency 'SDWebImage','4.4.7'
  s.static_framework  =  true
  
end
