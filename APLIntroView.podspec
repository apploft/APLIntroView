Pod::Spec.new do |s|

  s.name         = "APLIntroView"
  s.version      = "0.1.0"
  s.summary      = ""

  s.description  = <<-DESC
                   DESC

  s.homepage     = "https://github.com/apploft/APLIntroView"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  s.author             = { "Philip Krück" => "philip.krueck@apploft.de" }

  s.platform     = :ios, "10.0"

  s.source       = { :git => "https://github.com/apploft/APLIntroView.git", :tag => "#{s.version}" }

  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

  s.framework  = "UIKit"
  s.requires_arc = true

  s.dependency "APLVideoPlayerView", "~> 0.0.6"

end
