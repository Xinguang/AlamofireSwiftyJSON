Pod::Spec.new do |s|
  s.name             = "AlamofireSwiftyJSON"
  s.version          = "0.1.0"
  s.summary          = "Alamofire extension for serialize NSData to SwiftyJSON "
  s.homepage         = "https://github.com/starboychina/AlamofireSwiftyJSON"
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "starboychina" => "AlamofireSwiftyJSON.github.com@kansea.com" }
  s.source           = { :git => "https://github.com/starboychina/AlamofireSwiftyJSON.git", :tag => s.version.to_s }
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.source_files = 'Source/*.swift'
  s.dependency 'Alamofire', '~> 3.1'
  s.dependency 'SwiftyJSON', '~> 2.3'
end
