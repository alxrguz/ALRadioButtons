# ALRadioButtons



<img align="left" src="https://github.com/alxrguz/ALRadioButtons/blob/main/Assets/about.png"/>

  

## Navigation

- [Requirements](#requirements)
- [Installation](#installation)
  - [Swift Package Manager](#Swift-Package-Manager)
  - [CocoaPods](#CocoaPods)
  - [Manually](#Manually)
- [Usage](#usage)
  - [Quick Start](#Quick-Start)
  - [Customization](#Customization)
    - [Colors](#colors)
    - [Fonts](#Fonts)
    - [Layout](#Layout)
- [License](https://github.com/SnapKit/SnapKit#license)

## 

## Requirements

- iOS 10.0 + 
- Swift 4.2 +



## Installation

#### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

To integrate **ALRadioButtons** click `File -> Swift Package -> Add Package Dependency` and insert:

```ogdl
https://github.com/alxrguz/ALRadioButtons
```

#### CocoaPods

**ALRadioButtons** is available through [CocoaPods](https://cocoapods.org/pods/ALRadioButtons). To install it, simply add the following line to your Podfile:

```ruby
pod 'ALRadioButtons'
```

#### Manually

If you prefer not to use either of the aforementioned dependency managers, you can integrate ALRadioButtons into your project manually. Put `Source/ALRadioButtons` folder in your Xcode project. 



## Usage

#### Quick Start

```swift
import ALRadioButtons

class MyViewController: UIViewController {

    lazy var radioGroup = ALRadioGroup(items: [
        .init(title: "title1", subtitle: "subtitle1"),
        .init(title: "title2", subtitle: "subtitle2", detail: "Detail"),
        .init(title: "title3"),
    ], style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(radioGroup)
        // ... Setup layout
        
        radioGroup.selectedIndex = 0
      	radioGroup.addTarget(self, action: #selector(radioGroupSelected(_:)), for: .valueChanged)
      
      	// If the checkbox selection can be canceled, then set this property to true 
      	radioGroup.allowDeselection = true
    }
    
    @objc private func radioGroupSelected(_ sender: ALRadioGroup) {
        print(sender.selectedIndex)
    }
}
```



#### Customization

#### Colors

You can customize the buttons, headers and indicators colors depending on their state.

```swift
radioGroup.selectedTitleColor = .systemBlue 
radioGroup.unselectedTitleColor = .black 
radioGroup.selectedDetailColor = .systemBlue
radioGroup.unselectedDetailColor = .black
radioGroup.selectedIndicatorColor = .systemBlue 
radioGroup.unselectedIndicatorColor = .systemBlue 
radioGroup.subtitleColor = .lightGray 
radioGroup.buttonBackgroundColor = .white 
radioGroup.separatorColor = .lightGray 
```



#### Font

```swift
radioGroup.titleFont = .systemFont(ofSize: 16, weight: .medium)
radioGroup.detailFont = .systemFont(ofSize: 16, weight: .regular)
radioGroup.subtitleFont = .systemFont(ofSize: 13, weight: .regular)
```



#### Layout

```swift
radioGroup.cornerRadius = 14 // Button corner radius, actual for .grouped style
radioGroup.buttonHeight = 50 
radioGroup.subtitleTopOffset = 8 // Subtitle offset from title bottom anchor
radioGroup.separatorTopOffset = 8 // Separator offset from title or subtitle (if added) bottom anchor
radioGroup.indicatorRingWidth = 2 // Outer ring width of indicator
radioGroup.indicatorRingSize = 22 // Indicator outer ring size
radioGroup.indicatorCircleInset = 5 // Indentation of the circle from the outer ring
```



## License

**ALRadioButtons** is under MIT license. See the [LICENSE](https://github.com/alxrguz/ALRadioButtons/blob/master/LICENSE) file for more info.