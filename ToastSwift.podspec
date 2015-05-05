Pod::Spec.new do |s|
  s.name         = "ToastSwift"
  s.version      = "0.1.3"
  s.summary      = "Toast view using swift."
  s.homepage     = "https://github.com/Rannie/Toast-Swift"
  s.license      = "MIT"
  s.author    	 = "Hanran Liu"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Rannie/Toast-Swift.git", :tag => s.version }
  s.source_files = "Toast-Swift", "Toast/*.swift"
  s.framework    = "UIKit"
  s.requires_arc = true
end
