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





### 开始编写账号密码登录页面

