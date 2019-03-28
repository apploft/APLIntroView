Pod::Spec.new do |s|

  s.name         = "APLIntroView"
  s.version      = "0.1.0"
  s.summary      = "This piece of information is pretty invalid"

  s.description  = <<-DESC
                   * blafasel
                   * gibbelgibbel
                   * bla
                   DESC

  s.homepage     = "https://github.com/apploft/APLIntroView"
  
  s.swift_version = "4.2"

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
