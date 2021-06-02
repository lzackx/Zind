#
# Be sure to run `pod lib lint Zind.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Zind'
  s.version          = '1.0.0'
  s.summary          = 'A framework for Flutter (>= 2.0.0)'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A framework for Flutter (>= 2.0.0)
                       DESC

  s.homepage         = 'https://github.com/lzackx/Zind'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lzackx' => 'lzackx@lzackx.com' }
  s.source           = { :git => 'https://github.com/lzackx/Zind.git', :tag => s.version.to_s }
  s.social_media_url = 'https://github.com/lzackx/Zind'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.ios.deployment_target = '9.0'
#  s.static_framework    = true
  s.frameworks = 'UIKit'
  s.source_files = [
  'Zind/Classes/*.{h,m}',
  'Zind/Classes/Engine/*.{h,m}',
  'Zind/Classes/Share/*.{h,m}',
  'Zind/Classes/PopUp/*.{h,m}',
  ]
  s.public_header_files = 'Zind/Classes/**/*.h'
  s.dependency 'Flutter'#, '~> 2.0.0'
  s.dependency 'YYModel'
  # s.resource_bundles = {
  #   'Zind' => ['Zind/Assets/*.png']
  # }
  
end
