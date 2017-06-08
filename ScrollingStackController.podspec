Pod::Spec.new do |spec|
  spec.name = 'ScrollingStackController'
  spec.version = '0.5.0'
  spec.summary = 'Efficient Scrolling Stack Container'
  spec.homepage = 'https://github.com/malcommac/ScrollingStackController'
  spec.license = { :type => 'MIT', :file => 'LICENSE' }
  spec.author = { 'Daniele Margutti' => 'me@danielemargutti.com' }
  spec.social_media_url = 'http://twitter.com/danielemargutti'
  spec.source = { :git => 'https://github.com/malcommac/ScrollingStackController.git', :tag => "#{spec.version}" }
  spec.source_files = 'Sources/**/*.swift'
  spec.ios.deployment_target = '8.0'
  spec.watchos.deployment_target = '2.0'
  spec.osx.deployment_target = '10.10'
  spec.tvos.deployment_target = '9.0'
  spec.requires_arc = true
  spec.module_name = 'ScrollingStackController'
end
