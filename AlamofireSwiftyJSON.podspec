Pod::Spec.new do |s|
  s.name             = "AlamofireSwiftyJSON"
  s.version          = "1.0.2"
  s.summary          = "Alamofire extension for serialize Data to SwiftyJSON "
  s.homepage         = "https://github.com/Xinguang/AlamofireSwiftyJSON"
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Xinguang" => "AlamofireSwiftyJSON.github.com@kansea.com" }
  s.source           = { :git => "https://github.com/Xinguang/AlamofireSwiftyJSON.git", :tag => s.version.to_s }
  s.documentation_url = 'http://Xinguang.github.io/AlamofireSwiftyJSON/index.html'
  #s.platform     = :ios, '8.0'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.11'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '3.0'

  s.requires_arc = true
  s.source_files = 'Source/*.swift'
  s.dependency 'Alamofire', '~> 4.0'
  s.dependency 'SwiftyJSON', '~> 4.0'
  s.frameworks = 'CFNetwork'
end
