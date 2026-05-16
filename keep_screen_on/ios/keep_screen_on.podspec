#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
#
Pod::Spec.new do |s|
  s.name             = 'keep_screen_on'
  s.version          = '6.0.0'
  s.summary          = 'Keep screen on.'
  s.description      = <<-DESC
This plugin disables automatic screen off and prevents the screen from turning off.
                       DESC
  s.homepage         = 'https://github.com/craftsoft-dev/flutter_keep_screen_on'
  s.license          = { :type => 'MIT', :file => '../LICENSE' }
  s.author           = { 'Craftsoft LLC' => 'inquiry@craftsoft.jp' }
  s.source           = { :git => 'https://github.com/craftsoft-dev/flutter_keep_screen_on.git', :tag => 'v6.0.0' }
  s.documentation_url = 'https://pub.dev/packages/keep_screen_on'
  s.source_files = 'keep_screen_on/Sources/keep_screen_on/**/*.swift'
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
