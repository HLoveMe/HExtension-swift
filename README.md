

swift 版本的   字典转模型

说明：
1：constantBox.swift   对字典的扩展
2：KeyValueModel.swift 需要解析类的基类  继承即可
    注解：不需要任何构造器  已经实现序列化和反序列化
3：messageInfo.swift    是对类的每个属性的封装（内部使用）

使用：具体看Dome
 1:重写
  需要解析的类 重写该方法 告诉解析器 模型和字典 属性和字典不同的配对
  例：模型 为ID  字典为  id    则返回["ID":"id"]
  func propertyNameInDictionary()->[String:String]?
2:对模型的要求
   var ID:Int = 0      基本数据类型不能为可选型 （如果为可选型 这里不会处理）  并给定初始值
   var title:String?    
   var mediatype:Int = 0
   var type:String?
   var urls:[String]?  
   var photos:[photo]?    指定数组里面的类型   解析器就会自动解析为 指定类型
   
   
3：主要使用方法
      字典数组 转 模型数组
  1： class func modelsWithArray(modelArray:[[String:AnyObject]]) ->[KeyValueModel]  
     字典转模型
  2： class func modelWithDictionary( var  diction:[String:AnyObject]) ->Self
      内部实现网络请求
  3： class func GETModelsWithUrl(urlString:String,option:([String:AnyObject])->AnyObject,complement:([KeyValueModel]?)->())
  4： class func POSTModelsWithUrl(urlString:String,argumentDic:[String:String],option:([String:AnyObject])->AnyObject,complement:(([KeyValueModel]?)->()))
   
   
4：OC版本
    （Thanks）
  https://github.com/HLoveMe/ZZH
   
   
