# Uncomment the next line to define a global platform for your project

platform :ios, '11.0'

source 'https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git'

target 'Rising' do
	# Comment the next line if you don't want to use dynamic frameworks
	use_frameworks!

	# Pods for Rising
	pod 'AFNetworking'
	pod 'Masonry'
	pod 'YYKit',:inhibit_warnings => true
	pod 'MJRefresh'
	pod 'MJExtension'
	pod 'WCDB'
	pod 'IGListKit'
	pod 'FluentDarkModeKit'
	pod 'JWT'
	pod 'SDWebImage'
	pod 'BeeHive'
	pod 'CTMediator'

end

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
    	config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
    	config.build_settings['VALID_ARCHS'] = 'arm64 arm64e armv7 armv7s x86_64 i386'
    	config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
    end
end