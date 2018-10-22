Pod::Spec.new do |s|
  s.name          = "LSCategories"
  s.version       = "1.2.7"
  s.summary       = "This is a collection of useful Foundation and UIKit categories."
  s.homepage      = "https://github.com/leszek-s/LSCategories"
  s.license       = "MIT"
  s.author        = "Leszek S"
  s.source        = { :git => "https://github.com/leszek-s/LSCategories.git", :tag =>  "1.2.7" }
  s.ios.deployment_target = "7.0"
  s.tvos.deployment_target = "9.0"
  s.source_files  = "LSCategories"
  s.requires_arc  = true
end