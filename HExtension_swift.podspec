#
#  Be sure to run `pod spec lint HExtension_swift.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
s.name     = 'HExtension_swift'
s.version  = '0.0.1'
s.license  = "MIT"  //开源协议
s.summary  = '字典转模型' //简单的描述
s.homepage = 'https://github.com/HLoveMe/HExtension-swift.git' //主页
s.author   = { 'zhuZiHao' => '2436422656@qq.com' } //作者
s.source   = { :git => 'https://github.com/HLoveMe/HExtension-swift.git', :tag => "1.2" } //git路径、指定tag号
s.platform = :ios
s.source_files = 'HExtension/HExtension/HExtension/*'  //库的源代码文件
s.framework = 'UIKit'  //依赖的framework
s.requires_arc = trueend
