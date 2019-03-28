Pod::Spec.new do |s|

  s.name         = "APLIntroView"
  s.version      = "0.1.0"
  s.summary      = "APLIntroView is designed to help you easily extend the launch image of an app with an image or video in a customizable way"

  s.description  = <<-DESC
  					APLIntroView uses a single ViewController to manage the extending of the launchscreen. You can extend the launch 
  					simply with an image and/or a video. There are options for customizing the View Controller's behavior.
                   DESC

  s.homepage     = "https://github.com/apploft/APLIntroView"

  s.license      = { :type => "MIT", :file => "LICENSE" }


  s.author             = { "Philip Krück" => "philip.krueck@apploft.de" }

  s.platform     = :ios, "10.0"

  s.source       = { :git => "https://github.com/apploft/APLIntroView.git", :tag => "#{s.version}" }

  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

  s.framework  = "UIKit"
  s.requires_arc = true

  s.dependency "APLVideoPlayerView", "~> 0.0.6"

end
