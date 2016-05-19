# AlamofireSwiftyJSON

Easy way to use both [Alamofire](https://github.com/Alamofire/Alamofire) and [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)

## Use [jazzy](https://github.com/realm/jazzy) to generate Swift documentation

```sh
if [ -d AlamofireSwiftyJSON ]; then
  git -C AlamofireSwiftyJSON pull origin master
else
  git clone --depth 1 --branch master https://github.com/starboychina/AlamofireSwiftyJSON.git AlamofireSwiftyJSON
fi

cd AlamofireSwiftyJSON

jazzy --theme ../jazzy-theme --output ../ --module-version "master"

```
