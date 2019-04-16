Pod::Spec.new do |s|

  s.name         = "APLIntroView"
  s.version      = "0.3.0"
  s.summary      = "This piece of information is pretty invalid"

  s.description  = <<-DESC
                   * APLIntroView uses a single ViewController to extend the launch screen by displaying the launch image 
                   * or showing a video with configurable options.
                   DESC

  s.homepage     = "https://github.com/apploft/APLIntroView"
  
  s.swift_version = '5.0'

  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  
  s.author       = "Philip Krück"
  
  s.platform     = :ios, "10.0"

  s.source       = { :git => "https://github.com/apploft/APLIntroView.git", :tag => s.version.to_s }

  s.source_files  = "APLIntroView", "APLIntroView/**/*.{swift,h}"
  s.exclude_files = "APLIntroView/Exclude"
  
  s.framework  = "UIKit"
  s.requires_arc = true
  s.dependency "APLVideoPlayerView", "~> 0.0.6"
  
end
