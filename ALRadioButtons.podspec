Pod::Spec.new do |spec|
spec.name         = "ALRadioButtons"
spec.version      = "1.2.0"
spec.summary      = "RadioButtons for iOS. Inherited from UIControl, support 2 native styles, fully customizable."

spec.homepage     = "https://github.com/alxrguz/ALRadioButtons"
spec.source       = { :git => "https://github.com/alxrguz/ALRadioButtons.git", :tag => "#{spec.version}" }
spec.license      = { :type => "MIT", :file => "LICENSE" }

spec.author       = { "Alexandr Guzenko" => "alxrguz@icloud.com" }

spec.platform     = :ios
spec.ios.framework = 'UIKit'
spec.swift_version = ['4.2', '5.0']
spec.ios.deployment_target = "10.0"

spec.source_files  = "Sources/ALRadioButtons/**/*.swift"

end