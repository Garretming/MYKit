
Pod::Spec.new do |s|

  s.name         = "MYKit"
  s.version      = "1.1.2"
  s.summary      = "效率工具类"

  s.description  = <<-DESC
                   效率工具类；
		   DESC

  s.homepage     = "https://github.com/iOS-Strikers/MYKit"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  # s.license      = "MIT (example)"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "sunjinshuai" => "s_mike@163.com" }
  # Or just: s.author    = "sunjinshuai"
  # s.authors            = { "sunjinshuai" => "s_mike@163.com" }
  # s.social_media_url   = "http://twitter.com/sunjinshuai"

  s.ios.deployment_target = "8.0"
  s.platform     = :ios
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/iOS-Strikers/MYKit.git", :tag => s.version.to_s 
  }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.source_files  = 'MYKit/**'
  # s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  s.frameworks = 'UIKit','Foundation'
  s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/CommonCrypto" }
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  s.subspec 'UIKit' do |ss|
    ss.source_files = 'MYKit/UIKit/**/*'
    ss.dependency 'MYKit/Foundation'
  end

  s.subspec 'Foundation' do |ss|
    ss.source_files = 'MYKit/Foundation/**/*'
  end

  s.subspec 'SafeKit' do |ss|
    ss.source_files = 'MYKit/SafeKit/*.h'
    ss.dependency 'MYKit/Foundation'
  end
end
