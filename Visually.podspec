#
#  Be sure to run `pod spec lint Visually.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "Visually"
  s.version      = "0.0.10"
  s.summary      = "Swift library, that utilizes custom operators to enable creating autolayout constraints in typesafe and expressive manner."
  s.description  = <<-DESC
  Swift library, that utilizes custom operators to enable creating autolayout constraints in typesafe and expressive manner.
  It works similarly to visual format available in UIKit, however it doesn't rely on strings and doesn't require creating either
  views or metrics dictionaries.
                   DESC
  s.homepage     = "https://github.com/lukkas/Visually"
  s.license      = "MIT"
  s.author             = { "Lukasz Kasperek" => "luk.kasperek@gmail.com" }
  s.social_media_url   = "http://twitter.com/LukaszKasperek"

  s.swift_version = "4.1"
  s.ios.deployment_target = "9.0"
  s.osx.deployment_target = "10.11"
  s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/lukkas/Visually.git", :tag => "#{s.version}" }
  s.source_files  = "Visually"

  s.ios.framework = "UIKit"
  s.osx.framework = "AppKit"
  s.tvos.framework = "UIKit"
end
