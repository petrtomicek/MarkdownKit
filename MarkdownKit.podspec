Pod::Spec.new do |s|
  s.name             = 'MarkdownKit'
  s.version          = '3.0.0'
  s.summary          = 'MarkdownKit is a customizable and extensible Markdown parser for iOS.'
  s.description      = <<-DESC
MarkdownKit is a customizable and extensible Markdown parser for iOS.
It supports many of the standard Markdown elements through the use of Regular
Expressions. It also allows customization of font and color attributes for
all the Markdown elements.
                       DESC

  s.homepage         = 'https://github.com/tomaskraina/MarkdownKit'
  s.screenshots      = 'https://raw.githubusercontent.com/ivanbruel/MarkdownKit/master/Resources/MarkdownKitExample.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ivan Bruel' => 'ivan.bruel@gmail.com', 'Tom Kraina' => 'tomas.kraina@gmail.com' }
  s.source           = { :git => 'https://github.com/ivanbruel/MarkdownKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ivanbruel'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MarkdownKit/Classes/**/*'
  s.frameworks = 'UIKit'
end
