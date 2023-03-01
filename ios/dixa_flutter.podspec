#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint dixa_flutter.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'dixa_flutter'
  s.version          = '0.0.1'
  s.summary          = 'Flutter plugin for Dixa Messenger.'
  s.description      = <<-DESC
Flutter plugin for Dixa Messenger.
                       DESC
  s.homepage         = 'http://gabdsg.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Gabriel Castiglioni' => 'gabriel@talkingpts.org' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  s.preserve_paths = 'Assets/Dixa/DixaMessenger.xcframework/**/*'
  s.xcconfig = { 'OTHER_LDFLAGS' => '-framework Assets/Dixa/DixaMessenger' }
  s.vendored_frameworks = 'Assets/Dixa/DixaMessenger.xcframework'
end
