Pod::Spec.new do |s|
  s.name             = 'wb_class_category'
  s.version          = '0.0.2'
  s.summary          = 'objc中的一些类别，更新了一些工具类和宏'
  s.description      = <<-DESC
                        里面包含了一些自己工作中用到过的类别，为了方便再各个项目中调用，制作了该pod库，持续更新...
                       DESC

  s.homepage         = 'https://github.com/wbinWang'
  
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wang bin' => '1462999792@qq.com' }
  s.source           = { :git => 'https://github.com/wbinWang/wb_categorys.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.source_files = 'wb_class_category/Classes/**/*'

  s.frameworks = 'UIKit'
end
