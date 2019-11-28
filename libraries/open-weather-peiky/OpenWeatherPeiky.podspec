#
# Be sure to run `pod lib lint OpenweathermapPeiky.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'OpenWeatherPeiky'
  s.version          = '0.0.1'
  s.summary          = 'OpenWeatherPeiky iOS.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Module to Test in Peiky!
                       DESC

  s.homepage         = 'https://github.com/IbraMorelo/PeikyTest.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ibra.morelo' => 'ibramorelo@gmail.com' }
  s.source           = { :git => 'https://github.com/IbraMorelo/PeikyTest.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '11.0'
  s.default_subspec = 'Core'
    s.swift_version         = '5.0'
    s.pod_target_xcconfig   = { 'SWIFT_VERSION' => '5.0' }
    s.default_subspec = 'Core'
    s.subspec "Core" do |ss|
        ss.source_files = 'OpenWeatherPeiky/Source/**/*'
        ss.dependency 'Alamofire'
    end

    s.resource_bundles      = { 
	  	'OpenWeatherPeikyResources' => [
	    	'OpenWeatherPeiky/Assets/LocalizedStrings/*.lproj/*.strings',
	    	'OpenWeatherPeiky/Assets/LocalizedStrings/*.lproj/*.stringsdict',
	    	'OpenWeatherPeiky/Assets/Images.xcassets',
	    	'OpenWeatherPeiky/Assets/**/*.{storyboard,xib,json}'
	  	]
    } 
end
