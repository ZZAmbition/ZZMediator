#
# Be sure to run `pod lib lint ZZMediator.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZZMediator'
  s.version          = '0.1.1'
  s.summary          = 'ZZMediator Swift Components'

  s.description      = <<-DESC
  iOS Swift组件化 ZZMediator Swift Components
                       DESC
  s.swift_version = '5.0'
  s.homepage         = 'https://github.com/ZZAmbition/ZZMediator'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'meta' => 'j1zhouzhi@126.com' }
  s.source           = { :git => 'https://github.com/ZZAmbition/ZZMediator.git', :tag => s.version.to_s }
  s.source_files = ['ZZMediator/**/*','ZZMediator/*']
end
