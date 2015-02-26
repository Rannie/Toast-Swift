Toast-Swift
===========

Toast view using swift.

### Install

CocoaPods:

```
pod 'ToastSwift'
```

Or download this repo.


### Usage

1. Single toast view

          self.view.makeToast(message: msg)
          
2. Toast with title

          self.view.makeToast(message: msg, duration: duration, position: pos, title: subject)
          
3. Toast with image, title...

          self.view.makeToast(message: msg, duration: duration, position: pos, title: subject, image: image)

4. Show and hide activity

          self.view.makeToastActivity()
          self.view.hideToastActivity()

5. Show activity with message

        self.view.makeToastActivityWithMessage(message: msg)
          
          
### Screenshots

Type: single and title
<br />
![First Screenshot](https://raw.github.com/Rannie/Toast-Swift/master/Screenshots/single.png)
![Second Screenshot](https://raw.github.com/Rannie/Toast-Swift/master/Screenshots/title.png)
<br />
Type: image and activity
<br />
![Third Screenshot](https://raw.github.com/Rannie/Toast-Swift/master/Screenshots/image.png)
![Fourth Screenshot](https://raw.github.com/Rannie/Toast-Swift/master/Screenshots/activity.png)
<br />
Type: activity with message
<br />
![Fifth Screenshot](https://raw.githubusercontent.com/ilkerdagli/Toast-Swift/master/Screenshots/activityWithMessage.png)

### LICENSE

Toast-Swift is available under the MIT license. See the LICENSE file for more info.
