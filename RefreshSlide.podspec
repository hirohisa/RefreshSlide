Pod::Spec.new do |s|

  s.name         = "RefreshSlide"
  s.version      = "0.0.1"
  s.summary      = "Reload with slide animation before/after refreshing for iOS written in Swift."
  s.description  = <<-DESC
  Reload with slide animation before/after refreshing for iOS written in Swift. Using UITableViewController.
                   DESC

  s.homepage     = "https://github.com/hirohisa/RefreshSlide"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "Hirohisa Kawasaki" => "hirohisa.kawasaki@gmail.com" }

  s.source       = { :git => "https://github.com/hirohisa/RefreshSlide.git", :branch => "master" }

  s.source_files = "RefreshSlide/*.swift"
  s.requires_arc = true
  s.ios.deployment_target = '8.0'

end
