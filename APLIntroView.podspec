Pod::Spec.new do |s|

  s.name         = "APLIntroView"
  s.version      = "0.1.0"
  s.summary      = "..."

  s.description  = <<-DESC
  					..........
                   DESC

  s.homepage     = "https://github.com/apploft/APLIntroView"

  s.license      = { :type => "MIT", :file => "LICENSE" }


  s.author             = { "Philip Krück" => "philip.krueck@apploft.de" }

  s.platform     = :ios, "10.0"

  s.source       = { :git => "https://github.com/apploft/APLIntroView.git", :tag => '0.1.0' }

  s.source_files  = "Classes", "Classes/**/*.{swift}"
  s.exclude_files = "Classes/Exclude"

  s.framework  = "UIKit"
  s.requires_arc = true

  s.dependency "APLVideoPlayerView", "~> 0.0.6"

end
