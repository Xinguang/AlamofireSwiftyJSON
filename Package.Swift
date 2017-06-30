import PackageDescription
let package = Package(
  name: "AlamofireSwiftyJSON",
  dependencies: [
      .Package(url: "https://github.com/Alamofire/Alamofire.git", majorVersion: 4),
      .Package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", majorVersion: 3)
  ],
  exclude: ["Tests"]
)
