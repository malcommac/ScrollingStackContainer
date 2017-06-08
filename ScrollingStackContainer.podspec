Pod::Spec.new do |spec|
  spec.name = 'ScrollingStackContainer'
  spec.version = '0.5.0'
  spec.summary = 'Efficient Scrolling Stack Container'
  spec.homepage = 'https://github.com/malcommac/ScrollingStackContainer'
  spec.license = { :type => 'MIT', :file => 'LICENSE' }
  spec.author = { 'Daniele Margutti' => 'me@danielemargutti.com' }
  spec.social_media_url = 'http://twitter.com/danielemargutti'
  spec.source = { :git => 'https://github.com/malcommac/ScrollingStackContainer.git', :tag => "#{spec.version}" }
  spec.source_files = 'Sources/**/*.swift'
  spec.ios.deployment_target = '8.0'
  spec.requires_arc = true
  spec.module_name = 'ScrollingStackContainer'
end
