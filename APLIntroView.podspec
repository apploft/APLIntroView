Pod::Spec.new do |s|

  s.name         = 'APLIntroView'
  s.version      = '0.1.0'
  s.summary      = 'APLIntroView lets a user easily extend a launch image with various options including playing video.'

  s.homepage     = 'https://github.com/apploft/APLIntroView'

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author       = { 'Philip Krück' => 'philip.krueck@apploft.de' }

  s.platform     = :ios, '10.0'
  
  s.source       = { :git => 'https://github.com/apploft/APLIntroView.git', :tag => s.version.to_s }

  s.source_files  = 'APLIntroView/**/*.{swift}'
  
  s.framework = 'UIKit'
  s.dependency 'APLVideoPlayerView', '~> 0.0.6'

  s.requires_arc = true

end
