#
# Be sure to run `pod lib lint TopTabBarView.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "TopTabBarView"
  s.version          = "0.1.0"
  s.summary          = "A simple top tab bar view"
  s.homepage         = "https://github.com/daisuke310vvv/TopTabBarView"
  s.screenshots     = "https://dl.dropboxusercontent.com/s/lzlrbrskn3423i8/topTabBarViewDemo.gif"
  s.license          = 'MIT'
  s.author           = { "Daisuke Sato" => "daisuke.sato1991@gmail.com" }
  s.source           = { :git => "https://github.com/daisuke310vvv/TopTabBarView.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/st_dsk'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'TopTabBarView' => ['Pod/Assets/*.png']
  }
end
