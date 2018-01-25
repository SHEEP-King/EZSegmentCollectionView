#
#  Be sure to run `pod spec lint EZSegmentCollectionView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "EZSegmentCollectionView"
  s.version      = "1.0.0"
  s.summary      = "EZSegmentCollectionView"

  s.description  = “简单的segement view 支持横向和竖向滚动”

  s.homepage     = "https://github.com/SHEEP-King/EZSegmentCollectionView"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  #s.license      = "MIT"
   s.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  s.author             = { "ElonZhang" => "elonzhang@163.com" }

  s.platform     = :ios, "8.0"


  s.source       = {:git => "https://github.com/SHEEP-King/EZSegmentCollectionView.git", :tag => #{s.version}}

  s.source_files  = "EZSegmentCollectionView/*"

   s.frameworks = "Foundation", "UIKit"

   s.requires_arc = true

end
