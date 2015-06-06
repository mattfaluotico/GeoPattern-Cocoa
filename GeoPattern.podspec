Pod::Spec.new do |s|
  s.name             = "GeoPattern"
  s.version          = "0.1.0"
  s.summary          = "Generated beautiful patterns from a string."
  s.homepage         = "https://github.com/MattFaluotico/GeoPattern-Cocoa"
  s.license          = 'MIT'
  s.author           = { "mattfaluotico" => "matt.faluotico@gmail.com" }
  s.source           = { :git => "https://github.com/MattFaluotico/GeoPattern-Cocoa.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/MattFaluotico'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'GeoPattern/*.{h,m}'
  s.resource_bundles = {
    'GeoPattern' => ['Pod/Assets/*.png']
  }

  s.public_header_files = 'GeoPattern/GeoPatterns.h'
  s.frameworks = 'Security'
end
