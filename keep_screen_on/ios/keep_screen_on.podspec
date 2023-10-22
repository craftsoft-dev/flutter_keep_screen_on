#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
#
Pod::Spec.new do |s|
  s.name             = 'keep_screen_on'
  s.version          = '3.0.0'
  s.summary          = 'Keep screen on.'
  s.description      = <<-DESC
This plugin disables automatic screen off and prevents the screen from turning off.
                       DESC
  s.homepage         = 'https://github.com/craftsoft-dev/flutter_keep_screen_on'
  s.license          = { :type => 'MIT', :file => '../LICENSE' }
  s.author           = { 'Craftsoft LLC' => 'inquiry@craftsoft.jp' }
  s.source           = { :path => '.' }
  s.documentation_url = 'https://pub.dev/packages/keep_screen_on'
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
