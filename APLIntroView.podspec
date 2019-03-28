Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '10.0'
s.name = "APLIntroView"
s.summary = "APLIntroView lets a user easily extend a launch image with various options including playing video."
s.requires_arc = true

s.version = "0.1.0"

s.license = { :type => "MIT", :file => "LICENSE" }

s.author = { "Philip Krück" => "philip.krueck@apploft.de" }

s.homepage = "https://github.com/apploft/APLIntroView"

s.source = { :git => "https://github.com/apploft/APLIntroView.git",
:tag => "#{s.version}" }

s.framework = "UIKit"
s.dependency 'APLIntroView', '~> 0.0.6'

s.source_files = "APLIntroView/**/*.{swift}"

s.resources = "APLIntroView/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"

s.swift_version = "4.2"

end
