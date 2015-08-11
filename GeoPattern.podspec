Pod::Spec.new do |s|
  s.name             = "GeoPattern"
  s.version          = "1.0.3"
  s.summary          = "Generated awesome patterns from simply a string."
  s.homepage         = "https://github.com/mattfxyz/GeoPattern-Cocoa"
  s.license          = 'MIT'
  s.author           = { "mattfaluotico" => "matt.faluotico@gmail.com" }
  s.source           = { :git => "https://github.com/mattfxyz/GeoPattern-Cocoa.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/mattfxyz'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'GeoPattern/*.{h,m}'
  s.resource_bundles = {
    'GeoPattern' => ['Pod/Assets/*.png']
  }

  s.frameworks = 'Security'
end
