#
# Be sure to run `pod lib lint LinkerLabel.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LinkerLabel'
  s.version          = '0.1.2'
  s.swift_versions   = '5.0'
  
  s.summary          = 'The linkable text label.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/WallabyStuff/LinkerLabel'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Wallaby' => 'avocado34.131@gmail.com' }
  s.source           = { :git => 'https://github.com/WallabyStuff/LinkerLabel.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  
  s.source_files = 'Sources/**/*'
end
