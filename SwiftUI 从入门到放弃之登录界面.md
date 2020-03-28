SwiftUI 从入门到放弃之登录界面

## 前言

`SwiftUI`出来也有段时间了，关于`SwiftUI`更多的信息请看[这里](https://developer.apple.com/xcode/swiftui/)，那么苹果为什么要推出`SwiftUI`呢？很多小伙伴会有疑问，有的公司可能还在用着`OC`进行的开发，还有些小伙伴可能连`Swift`都不是很了解，这怎么就又出来一个`SwiftUI`。

回想一下我们再使用`OC`或者`Swift`进行`UI`开发的时候，假设我们要显示一个`Label`到屏幕中，我们要进行哪些操作呢？下面代码用`Swift`举例：

```swift
...
void viewDidload() {
	super.viewDidload()
	
	let label = UILabel()
	label.text = "你好，Swift"
	view.addSubview(label)
}
...
```

emmmm，这一切看起来都没有问题，先声明`label`，然后为`label`设置文字，最后在把他添加到`View`中。但是时代在进步呐，看看隔壁的`Flutter`，人家要显示一行文本到屏幕上面是怎么操作的？

```dart
...
  @override
  Widget build(BuildContext context) {
	  return Text('Welcome to Flutter');
	}
...
```

去掉申明部分，被人一行代码就搞定了，明显比你优秀啊，而且人家的阅读性丝毫不比你弱，你怎么办~



> 这个时候苹果就在想了：“这个小伙子轻轻松松就可以把代码运行在多平台上，那开发者不是就更愿意用这个编写么？不行，老子要反击！！！”



所以`SwiftUI`就出来了，然后就实现了`声明式或者函数式`的方式来进行界面开发，由于是自家平台，要做到一份代码，多端通用自然也要提上日程，毕竟人是越来越懒了，能点头就搞定的，绝不开口说话。

我们看看`SwiftUI`如何实现显示文本:

```swift
...
var body: some View {
	Text("你好，Swift")
}
...
```

现在看起来和`Flutter`旗鼓相当了不是吗？`SwiftUI`充分利用了`Swift`的特性，可以省略分号，在某些情况下可以省略`return`，美滋滋~~



[本文Demo地址](https://github.com/codepgq/SwiftUI-Study)



## 必看

**本文默认你有`Swift`基础，如果没有请自行了解，至少熟悉基本语法，不然有些省略写法你看你会很晕**

如果你之前连官方的`Demo`都没有看过，又没有网页、`Flutter`、小程序等开发经验，那么你暂时可以记住一句话，**什么都是`View`**，你所看到的都是`View`组成。

`Xcode`版本：`11.4`

`macOS`系统版本：`10.15.3`（你可以不是`10.15`以上的，但是`SwiftUI`必须要`10.15`以上，最新版的`Xcode`也要`10.15.2`以上，所以升级吧！！！）





## 新建工程

![image-20200327205509861](/Users/panguoquan/Library/Application Support/typora-user-images/image-20200327205509861.png)



新建之后我们可以看到如下文件

![image-20200327210000791](/Users/panguoquan/Library/Application Support/typora-user-images/image-20200327210000791.png)



#### `AppDeleagte`

```swift
func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
```

可以看到这里和我们之前的工程不一样了，之前那个`Window`的属性字段不见了，取而代之的是直接返回了`UISceneConfiguration`，在参数中我们可以看到有一个`Default Configuration`的字符串，这个字符串在我们的`info.plist`中可以查看到

![info.plist](/Users/panguoquan/Library/Application Support/typora-user-images/image-20200327210535488.png)

这个是`iOS13`新加入的，通过`Scene`管理`App`的生命周期，所以`SceneDelegate`接管了他



#### `SceneDelegate`

```swift
var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let contentView = ContentView()

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
```

看到这个代码，大家应该都很熟悉了，这里和之前的创建方式基本类似了，这里我们看到，他的`rootviewController`是通过一个`UIHostingController`包装起来的，里面的rootView就是我们的`ContentView`，所以程序运行之后，我们看到的就是`ContentView`



#### `ContentView`

终于到今天的主角了~~~

```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

```

这里的代码就是新鲜热乎的（如果你没看过`SwiftUI`的话）

这里我们看到`ContentView`是用`Struct`修饰的，不在是`class`了，然后又一个关键字`some`，这个是在之前的语法中没有的，也是在`SwiftUI`中加入的，你应该还记得上面提到的，你看到的都是`View`

```swift
public protocol View : _View {
    associatedtype Body : View
    var body: Self.Body { get }
}
```

可以看到，`SwiftUI`中的`View`是一个协议，但是`View`使用了`associatedtype`来修饰，他不能直接作为类型使用，他只能约束类型。所以就有关键字`some`

没它之前我要显示Label，要这样子写

```swift
var body: Text {
	Text("test")
}
```

要显示图片要这样子写：

```swift
var body: Image {
	Image("abc.png")
}
```

要根据不同的类型指定，这是一个很痛苦的事情，本来就是声明式`UI`，你还要我每个都指定一下，岂不是很麻烦。有了`some`只有，就美滋滋了，不管你显示什么，只要你遵循了`View`协议就成

```swift
var body: some View {
	Image("abc.png")
}

var body: some View {
	Text("label")
}
```

`some`怎么实现的？？？？[答案在这里](https://github.com/apple/swift-evolution/blob/master/proposals/0244-opaque-result-types.md)



`OK`,到这里为止，我们看完了第一个结构体，但是下面还有一个`ContentView_Previews`，这个家伙又是来干什么的呢？？？？

可以看到自动生成的代码后面携带了`_Previews`，字面上的意思就是预览！！！，嗯他就是用来预览的，毕竟隔壁的`Flutter`早就实现了，你作为后面出来小伙子，不能比前辈还少功能吧



如何开启预览？？？

![image-20200327212332853](/Users/panguoquan/Library/Application Support/typora-user-images/image-20200327212332853.png)

然后点击`resume`（在右上角），等待一会儿就可以了，至于预览显示的速度（看你电脑设备，我反正是放弃了）。

![image-20200327212631982](/Users/panguoquan/Library/Application Support/typora-user-images/image-20200327212631982.png)

友情提示（按下`command`然后点击文字，有惊喜哦）

![image-20200327212753879](/Users/panguoquan/Library/Application Support/typora-user-images/image-20200327212753879.png)

这个就比隔壁的`Flutter`要强大了，但是要看你为苹果充值了多少



## 开始干活

看完本期内容你将会了解

- 如何跳转页面
- 如何处理输入事件
- `@ViewBuilder`
- 如何桥接`UIKit`
- 熟悉几个常用的`View`



### 1、新建两个文件

`LoginAccountView`和`LoginPhoneView`，新建的时候，记得要选择`SwiftUI`



### 2、修改ContentView

刚才我们建立了两个`View`，现在我们要通过一个列表显示两个选项，当我们点击的时候跳转过去

`NavigationView` 字面上上的意思，学过`iOS`开发的都知道，导航栏`View。

>
>
>你可以把`NavigationView`看做是有导航栏的`controller`



我们要用列表展示两中登录方式然后你想列表，列表不就是`List`么~~，对就是这么简单

> 
>
> `List`展示一组列表，你可以把他看成是`UITableView`



有了`List`，我们需要一些`Item`，同时我们点击他的时候，需要他跳转到二级页面，跳转到二级页面也可以裂解为连接到下一级页面，所以这个关键字就是`NavigationLink`

>
>
>`NavigationLink`拥有跳转到另外一个`View`的能力，之前提到过什么都是View组成，所以下一级页面也是一个`View`。
>
>他有三个参数：
>
>- 一个是`destination`：表示连接的`View`；
>- 第二个是：`isActive`，用于表示是否已经激活下一个`View`了（或者说下一个`View`是不是已经显示了）； 可忽略的参数
>- 最后一个是`label`：需要返回`View`的`closure`



最后我们在给这个导航栏设置一个标题

```swift
.navigationBarTitle(
	Text("登录Demo"), 
	displayMode: .large
)
```

在`SwiftUI`中，默认的`displayMode`是`large`效果，具体啥样子，参考设置主页

```
large 和手机设置效果一样
inline，传统样式
automatic 支持large就使用large，否则就使用inline 
```





最后我们的`ContentView`代码是这样子的

```swift
struct ContentView: View {
    @State private var loginAccountIsActive: Bool = false
    @State private var loginPhoneIsActive: Bool = false
    var body: some View {
        NavigationView {
            List {
                NavigationLink(
                    destination: LoginAccountView(),
                    isActive: $loginAccountIsActive) {
                        Text("使用账户密码登录")
                }
                NavigationLink(
                    destination: LoginPhoneView(),
                    isActive: $loginPhoneIsActive) {
                        Text("使用手机号验证码登录")
                }
            }
                
            .navigationBarTitle(Text("登录Demo"), displayMode: .large)
        }
    }
}
```

![loginDemo](/Users/panguoquan/Desktop/loginDemo.gif)



然后运行起来，你就可以看到一个有两个列表项的视图，点击某一项的时候，可以进行调整到对应的`View`中





### 3、开始编写账号密码登录页面

先把下面的代码替换原来的实现

```swift
    @State var account: String = ""
    @State var password: String = ""
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person")
                TextField("请输入账号", text: $account, onCommit: {
                    
                })
            }
            Divider()
            HStack {
                Image(systemName: "lock")
                TextField("请输入密码", text: $password, onCommit: {
                    
                })
            }
            Divider()
            Spacer()
        }
        .padding(.top, 100)
        .padding(.leading)
        .padding(.trailing)
    }
```



首先来了一个之前没见过的修饰符`@State`，对于没见过的内容，一律command+点击，进入内部文档查看一下他的意思:

```swift
@frozen @propertyWrapper public struct State<Value> : DynamicProperty {

    /// Initialize with the provided initial value.
    public init(wrappedValue value: Value)

    /// Initialize with the provided initial value.
    public init(initialValue value: Value)

    /// The current state value.
    public var wrappedValue: Value { get nonmutating set }

    /// Produces the binding referencing this state value
    public var projectedValue: Binding<Value> { get }
}
```

我们都知道，如果要在`Struct`中修改属性，就要添加`mutating`修饰，那你暂时可以理解为使用了@State修饰的属性，我们就可以控制的读写。

然后我们看到使用这个属性的时候是这样子的`$account`，这个在之前的`Swift`也是没有出现过的。其实这个就是配套`@State`使用的，如果对方需要的参数是`Binding<T>`，那么你就使用这个就好了。

`@State`和`$value`是一种缩写的方式，他们本来长这个样子

```swift
@State private var a: Int = 0
priavte var a = State(initialValue: 0)

$a
a.binding
```

关于更多的这方面信息，[请查看](https://forums.swift.org/t/se-0258-property-delegates/23139)



接下来就是`body`部分了，这部分全是新内容！！！！

下面挨个解释一下啥意思

- `VStack` 

  垂直方向的Stack，上面的代码**又是一种简写形式**，他的功能就是在垂直方向，可以让你放入**至多10个子View**，未简写方式如下

  ```swift
          VStack(alignment: .leading, spacing: 10) {
              Text("xxxx")
          }
  ```

  默认的`alignment`是`.center`

  默认的`spacing`是`nil`

- `HStack`

  和`VStack`类似，只不过一个是垂直方向，一个是水平方向

- `ZStack`

  > ps: 这个虽然没有用到，但是顺带一起提了

  上面的`VStack`和`HStack`都是沿着一个方向进行布局，如果我们想要进行叠加布局怎么办？？？`ZStack`就是干着活的。上面的三个`Stack`除了布局方式不一样，其他的都一样。

- `Image`

  这个用来显示一张图片，内部不多，具体可以自行点击进去查看，需要说明的是，系统为我们提供了一堆内置的图片，使用`Image(systemName: "xxx")`进行调用，如果不知道名字怎么办！！！！

  [福利地址](https://developer.apple.com/design/downloads/SF-Symbols.dmg) 下载完成之后就可以查看了

- `TextField`

  文本输入框，没啥好讲的，但是要吐槽一下，现在的TextField并不好用！！！！，能用的功能不多，要想做更多的事情，还是需要使用`UITextField`，这个也是后续会聊到的内容，如何桥接`UITextField`到`SwiftUI`

- `Divider`

  分割线

- `Spacer`

  空白填充，如果不使用这个，那么我们的`UI`会是居中对齐的，如果我们想要填充对齐到某一个方向，就可以使用他



然后就是用到View的几个属性的

- .padding

  边距，如果你没有指定方向，默认就是四周，指定了一个之后，其他的就会失效，意思就是你指定了`.top`,如果此时你不指定左右下三个方向，那么他们是一点间距都没有的



OK到这里，我们就把上面的View的部分全部讲完了，你先运行也会看到这样子的`UI`

![image-20200328100855116](/Users/panguoquan/Library/Application Support/typora-user-images/image-20200328100855116.png)



接下来我们在花一点时间，把他完善一下

- 密码的可见/隐藏
- 登录按钮的实现

### 

#### 密码的可见和隐藏

在Swift中我们使用的是一个属性就可以控制了，很抱歉，在SwiftUI中并没有这样子的属性可以给到我们，所以他提供了另外一个输入框，专门给我们使用

- `SecureField`

  这个`View`输入的内容是不可见的（也就是一堆小圆点）

一般来说，密码是否可见，我们会有一个按钮去显示控制

所以我们需要加入一个新的`View`， `Button`

`SwiftUI`为我们提供了好几种`Button`，目前我们只需要使用一种就好了，有兴趣的可以去官网自行查看。



在第二个`HStack`中我们新增一个`Button`,并新增一个属性，用来控制是否可以显示按钮

```swift
var showPwd = false

...HStack
Button(action: {
    self.showPwd.toggle()
}) {
    Image(systemName: self.showPwd ?
"eye" : "eye.slash")
}
```



然后就给你报错了，这是因为你没给`showPwd`这个属性添加 `@State`，加上之后就没事了。



现在按钮是可以点击了，图片也在切换了，但是密码还是公开的，接下来我们就把这部分实现

把TextField的代码修改为如下代码

```swift
Image(systemName: "lock")
if showPwd {
    TextField("请输入密码", text: $password, onCommit: {
        
    })
} else {
    SecureField("请输入密码", text: $password, onCommit: {
        
    })
}
```



再次运行之后，就可以愉快的切换了



####  登录按钮的实现

在`Devider`和`Spacer`之间插入一个`Button`，同时添加一个属性`isCanLogin`

```swift
var isCanLogin: Bool {
    account.count > 0 &&
    password.count > 0
}


Button(action: {
    print("login action")
}) {
    Text("Login")
        .foregroundColor(.white)
}
.frame(width: 100, height: 45, alignment: .center)
.background(isCanLogin ? Color.blue: Color.gray)
.cornerRadius(10)
.disabled(!isCanLogin)
```



这里我们使用了几个View的属性

- `frame`

  设置大小和对齐方式

- `background`

  背景，这里使用的是协议进行的约束，也就是你只要遵从了该协议就行，`Color`就遵循了

- `cornerRadius`

  圆角

- `disabled`

  是否是非激活状态



### 4、编写手机号登录界面

再开始之前，指出我们上面的登录界面的一些体验不友好的地方

- 键盘无法自动消失
- 没有限制TextField的最大输入长度

接下来的代码中，我们就要优化这个问题



##### 桥接`UITextField`到`SwiftUI`

新建一个文件`PQTextField`继承协议`UIViewRepresentable`，这个协议就是用来桥接的，其他的暂时不管。

你只要记得三个重要的方法

- `makeUIView`

  创建桥接的UIKit

- `updateUIView`

  更新他

- `makeCoordinator`

  UIKit代理的实现者

  

然后我们参考上面的`TextView`，我们要做一个体验和`TextField`基本一致的`View`出来

```swift
struct PQTextField: UIViewRepresentable {
    typealias PQTextFieldClosure = (UITextField) -> Void
    /// placeholder
    var placeholder: String? = nil
    /// max can input length
    var maxLength: Int? = nil
    /// default text
    var text: String? = nil
    /// onEditing
    var onEditing: PQTextFieldClosure?
    /// onCommit
    var onCommit: PQTextFieldClosure?
    /// 配置时使用
    var onConfig: PQTextFieldClosure?
    
    func makeUIView(context: Context) -> UITextField {
        
    }
    
    func updateUIView(_ tf: UITextField, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        
    }
}
```

然后我们依次把空白的地方补全

首先是`makeUIView`，这里需要我们返回一个`UIKit`的视图

```swift
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        return textField
    }
```

然后分析我们要实现的功能，监听UITextField输入情况，这里要设置他的代理；设置的他的初始值，比如`placeholder`，

###### 创建代理类

```swift
  class Coordinator: NSObject, UITextFieldDelegate {
        let textField: PQTextField
        var onEditing: PQTextFieldClosure?
        var onCommit: PQTextFieldClosure?
        
        init(_ tf: PQTextField, onEditing: PQTextFieldClosure?, onCommit: PQTextFieldClosure?) {
            self.textField = tf
            self.onEditing = onEditing
            self.onCommit = onCommit
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            onEditing?(textField)
            var length = range.location + 1
            if string == "", textField.text?.count ?? 0 == range.location + range.length { // 表示是删除
                length -= 1
            }
            if length >= self.textField.maxLength ?? -1 {
                onCommit?(textField)
            }
            
            if let maxLength = self.textField.maxLength, string != "" {
                let value = (textField.text?.count ?? 0) < maxLength
                return value
            }
            
            return true
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            onCommit?(textField)
            onCommit = nil
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            onCommit?(textField)
            onCommit = nil
            return true
        }
        
        @objc
        func textChange(textField: UITextField) {
            onEditing?(textField)
        }
    }
```

代理类里面的代码就是`Swift`的部分，和`SwiftUI`半毛钱关系都没有，具体做的事情就是监听代理，然后通过`closure`回调出去



###### 实现`makeCoordinator`方法

```swift
    func makeCoordinator() -> Coordinator {
        Coordinator(self, onEditing: onEditing, onCommit: onCommit)
    }
```





###### 然后在`makeUIView`中补全代码

```swift
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.placeholder = placeholder
        textField.addTarget(context.coordinator, action: #selector(context.coordinator.textChange(textField:)), for: .editingChanged)
        textField.text = text
        onConfig?(textField)
        return textField
    }
```



###### 实现`updateUIView`

```swift
    func updateUIView(_ tf: UITextField, context: Context) {
        tf.placeholder = placeholder
        tf.text = text
    }
```



最后完整的代码如下

```swift

struct PQTextField: UIViewRepresentable {
    typealias PQTextFieldClosure = (UITextField) -> Void
    /// placeholder
    var placeholder: String? = nil
    /// max can input length
    var maxLength: Int? = nil
    /// default text
    var text: String? = nil
    /// onEditing
    var onEditing: PQTextFieldClosure?
    /// onCommit
    var onCommit: PQTextFieldClosure?
    /// 配置时使用
    var onConfig: PQTextFieldClosure?
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.placeholder = placeholder
        textField.addTarget(context.coordinator, action: #selector(context.coordinator.textChange(textField:)), for: .editingChanged)
        textField.text = text
        onConfig?(textField)
        return textField
    }
    
    func updateUIView(_ tf: UITextField, context: Context) {
        tf.placeholder = placeholder
        tf.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, onEditing: onEditing, onCommit: onCommit)
    }
    
    
    class Coordinator: NSObject, UITextFieldDelegate {
        let textField: PQTextField
        var onEditing: PQTextFieldClosure?
        var onCommit: PQTextFieldClosure?
        
        init(_ tf: PQTextField, onEditing: PQTextFieldClosure?, onCommit: PQTextFieldClosure?) {
            self.textField = tf
            self.onEditing = onEditing
            self.onCommit = onCommit
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            onEditing?(textField)
            var length = range.location + 1
            if string == "", textField.text?.count ?? 0 == range.location + range.length { // 表示是删除
                length -= 1
            }
            if length >= self.textField.maxLength ?? -1 {
                onCommit?(textField)
            }
            
            if let maxLength = self.textField.maxLength, string != "" {
                let value = (textField.text?.count ?? 0) < maxLength
                return value
            }
            
            return true
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            onCommit?(textField)
            onCommit = nil
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            onCommit?(textField)
            onCommit = nil
            return true
        }
        
        @objc
        func textChange(textField: UITextField) {
            onEditing?(textField)
        }
    }
}
```





有了上面的基础，`View`搭建这块我们就手到擒来了

```swift

struct LoginPhoneView: View {
     @State private var phoneNumber: String = ""
     @State private var code: String = ""
     @State private var phoneNumIsEdit = false
     @State private var codeIsEdit = false
     @State private var timer: Timer?
     @State private var countDown = 60
     var isPhoneNum: Bool {
         if accountIsEdit {
             return phoneNumber.count == 11
         }
         return true
     }
     var isCode: Bool {
         if codeIsEdit {
             return code.count == 4
         }
         return true
     }
     var isCanLogin: Bool {
         isPhoneNum && isCode
     }
     var body: some View {
         VStack {
             VStack {
                 HStack {
                     Image(systemName: "phone.down.circle")
                         .rotationEffect(Angle(degrees: 90))
                     
                     PQTextField(placeholder: "请输入号码", maxLength: 11,text: phoneNumber, onEditing: { tf in
                     }, onCommit:  { tf in
                     })
                         .frame(height: 40)
                 }
                 if !isPhoneNum {
                     Text("手机号码应该是11位数字")
                         .font(.caption)
                         .foregroundColor(.red)
                 }
                 Divider()
             }
             
             VStack {
                 HStack {
                     PQTextField(placeholder: "请输入验证码", maxLength: 4, text: code, onEditing: { tf in
                     }, onCommit: { tf in
                     })
                         .frame(height: 40)
                     Button(action: {
                         // get code
                     }, label: {
                         Text((countDown == 60) ? "获取验证码" : "请\(countDown)s之后重试")
                     }).disabled(countDown != 60 || phoneNumber.count != 11)
                 }
                 if !isCode {
                     Text("请输入正确的验证码(4位数字)")
                         .font(.caption)
                         .foregroundColor(.red)
                         .frame(alignment: .top)
                 }
                 
                 Divider()
             }
             
             Button(action: {
                 print("login action", self.phoneNumber, self.code)
             }) {
                 Text("Login")
                     .foregroundColor(.white)
             }.frame(width: 100, height: 45, alignment: .center)
                 .background(isCanLogin ? Color.blue: Color.gray)
                 .cornerRadius(10)
                 .disabled(!isCanLogin)
             
             Spacer()
         }
         .onAppear {
             self.createTimer()
         }
         .onDisappear {
             self.invalidate()
         }
         .padding()
         
     }
     
     private func createTimer() {
        
     }
     
     private func invalidate() {
        
     }
}
```

>
>
>首先我们创建了几个属性
>
>- phoneNumber 保存手机使用
>- code 验证码
>- phoneNumIsEdit 是否开始输入手机号了
>- codeIsEdit 是否开始输入验证码了
>- timer 倒计时的时候使用
>- countDown 倒计时的时间
>- isPhoneNum 判断是不是手机号，这里只做了非常简单的判断
>- isCode 判断是不是验证码，这里也是非常简单的判断
>- isCanLogin 是否可以登录了（控制按钮是否可以点击）
>
>接下来的视图部分和之前大体相同，这部分的代码带过



最后我们看到我们又使用了两个新的方法

- onAppear 

  这个会在视图加载的时候调用

- onDisappear

  这个会在视图消失的时候调用

那么在这里做啥子呢？，没错，就是用来场景定时器的



我们去实现两个定时器方法

创建定时器

```swift
    private func createTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (t) in
                if self.countDown < 0 {
                    self.countDown = 0
                    t.invalidate()
                }
                self.countDown -= 1
            })
            // 先不触发定时器
            timer?.fireDate = .distantFuture
        }
    }
```

创建定时器，这里一定要注意的是，一定要做好判断，**不能重复创建定时器**，否则会有多少个定时器同时在跑，尤其是当前界面进入下级页面的时候

销毁定时器

```swift
    private func invalidate() {
        timer?.invalidate()
    }
```

为什么创建的时候做了判断，但是销毁的时候却没有处理呢？？？

如果你足够细心，那你一定看到了`countDown`是用@`State`修饰的



最后我们补全在`PQTextField`的`Closure`的代码之后，完整的代码如下

```swift
struct LoginPhoneView: View {
     @State private var phoneNumber: String = ""
     @State private var code: String = ""
     @State private var phoneNumIsEdit = false
     @State private var codeIsEdit = false
     @State private var timer: Timer?
     @State private var countDown = 60
     var isPhoneNum: Bool {
         if phoneNumIsEdit {
             return phoneNumber.count == 11
         }
         return true
     }
     var isCode: Bool {
         if codeIsEdit {
             return code.count == 4
         }
         return true
     }
     var isCanLogin: Bool {
         isPhoneNum && isCode
     }
     var body: some View {
         VStack {
             VStack {
                 HStack {
                     Image(systemName: "phone.down.circle")
                         .rotationEffect(Angle(degrees: 90))
                     
                     PQTextField(placeholder: "请输入号码", maxLength: 11,text: phoneNumber, onEditing: { tf in
                        self.phoneNumIsEdit = true
                        self.phoneNumber = tf.text ?? ""
                     }, onCommit:  { tf in
                        self.phoneNumIsEdit = false
                        self.phoneNumber = tf.text ?? ""
                     })
                    .frame(height: 40)
                 }
                 if !isPhoneNum {
                     Text("手机号码应该是11位数字")
                         .font(.caption)
                         .foregroundColor(.red)
                 }
                 Divider()
             }
             
             VStack {
                 HStack {
                     PQTextField(placeholder: "请输入验证码", maxLength: 4, text: code, onEditing: { tf in
                        self.codeIsEdit = true
                        self.code = tf.text ?? ""
                     }, onCommit: { tf in
                        self.codeIsEdit = false
                        self.code = tf.text ?? ""
                     })
                         .frame(height: 40)
                     Button(action: {
                         // get code
                     }, label: {
                         Text((countDown == 60) ? "获取验证码" : "请\(countDown)s之后重试")
                     }).disabled(countDown != 60 || phoneNumber.count != 11)
                 }
                 if !isCode {
                     Text("请输入正确的验证码(4位数字)")
                         .font(.caption)
                         .foregroundColor(.red)
                         .frame(alignment: .top)
                 }
                 
                 Divider()
             }
             
             Button(action: {
                 print("login action", self.phoneNumber, self.code)
             }) {
                 Text("Login")
                     .foregroundColor(.white)
             }.frame(width: 100, height: 45, alignment: .center)
                 .background(isCanLogin ? Color.blue: Color.gray)
                 .cornerRadius(10)
                 .disabled(!isCanLogin)
             
             Spacer()
         }
         .onAppear {
             self.createTimer()
         }
         .onDisappear {
             self.invalidate()
         }
         .padding()
         
     }
     
     private func createTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (t) in
                if self.countDown < 0 {
                    self.countDown = 0
                    t.invalidate()
                }
                self.countDown -= 1
            })
            // 先不触发定时器
            timer?.fireDate = .distantFuture
        }
     }
     
     private func invalidate() {
        timer?.invalidate()
     }
}
```





最终我们的两个小`Demo`就完成了。

第二个`Demo`基于第一个，如果你第二个没懂，你看你需要再去看看第一个`Demo`



##### 实现点击空白处隐藏键盘

新建文件`DismissKeyboard.swift`

首先分析一下功能，点击空白处，空白处的`View`是`Spacer`，`Spacer`又遵循`View`协议，那我们可以为`View`扩展一个隐藏键盘的方法

```swift
import SwiftUI

extension View {
    func endEditing() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
```

这里**不建议**使用`keywindow`的方法去做了

然后为了方便其他的`View`使用，自定义了一个`struct`遵从`ViewModifier`协议

```swift
struct DismissKeyboard: ViewModifier {
    func body(content: Content) -> some View {
        content.onTapGesture {
            content.endEditing()
        }
    }
}
```

如何使用呢？？？

```swift
Text("xxxx")
.modifier(DismissKeyboard())
```

其实`ViewModifier`的妙用有很多，这里只是举了一个例子，比如我们要为某一个视图设置独特的样式，`我们就可以新建一个文件`，然后编写样式，之后只要需要用到这个样式的，就可以用类似上面的调用方法。



题外话： 那出了使用`ViewModifier`之外呢，我们还可以使用`@ViewBuilder`去做

```swift
struct DismissKeyboardBuilder<Content: View>: View {
    let content: Content
    init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content.onTapGesture {
            self.content.endEditing()
        }
    }
}
```



他们两个的区别，我个人认为一个像继承，一个像协议。扯远了~~~





最后我们新建一个自己的`Spacer`

```swift
public struct DismissKeyboardSpacer: View {
    public private(set) var minLength: CGFloat? = nil
    
    public init(minLength: CGFloat? = nil) {
        self.minLength = minLength
    }
    
    public var body: some View {
        ZStack {
            Color.black.opacity(0.001)
                .modifier(DismissKeyboard())
            Spacer(minLength: minLength)
        }
        .frame(height: minLength)
    }
    
}
```





然后把`LoginPhoneView`里面的`Spacer`替换成为我们自己创建的`DismissKeyboardSpacer`，再去运行一下看下效果



到这里我们的放弃教程只登陆界面就完了！！！

回顾一下我们学到了哪些东西！！！

首先视图方面

>
>
>HStack、VStack、ZStack、List、Button、Text、TextFiled、Divider、Spacer、NavigationView、NavigationLink

然后方法方面

>
>
>frame、padding、rotationEffect、font、foregroundColor、background、disabled、cornerRadius、onAppear、onDisappear

还了解了定时器的创建，UIKit的桥接、@ViewBuilder、ViewModifier、@State、Binding



希望对你有所收获