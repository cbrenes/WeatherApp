platform :ios, '15.4'

plugin 'cocoapods-keys', {
    :project => "WeatherApp",
    :keys => [
        "OpenWeatherApiKey"
    ]
}

target 'WeatherApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'Alamofire', '~> 5.5'
  pod 'Mocker', '~> 2.5.4'
  pod 'SDWebImage', '~> 5.0'

  target 'WeatherAppTests' do
    inherit! :search_paths
    pod 'SDWebImageMockPlugin'
  end

end
