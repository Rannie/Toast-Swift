Toast-Swift
===========

Toast view using swift.

![New Screenshot 1](https://raw.githubusercontent.com/Rannie/Toast-Swift/master/Screenshots/new_1.PNG)
![New Screenshot 2](https://raw.githubusercontent.com/Rannie/Toast-Swift/master/Screenshots/new_2.PNG)
![New Screenshot 3](https://raw.githubusercontent.com/Rannie/Toast-Swift/master/Screenshots/new_3.PNG)


### New Toast-Swift has been updated!
---------

New Toast-Swift can compile with Swift 3.0.
<br />
And u can set the theme color of the toast view.

### Install
---------

download this repo and import "UIView+HRToast".

### Usage
---------

1. Set theme color (defalut is UIColor.blackColor())

	```
	view.hr_setToastThemeColor(color: #ThemeColor)
	```

2. Single toast view

	![First Screenshot](https://raw.githubusercontent.com/Rannie/Toast-Swift/master/Screenshots/single.png)

	```
	view.makeToast(message: msg)
	```

3. Toast with title

	![Second Screenshot](https://raw.githubusercontent.com/Rannie/Toast-Swift/master/Screenshots/title.png)

	```
	view.makeToast(message: msg, duration: duration, position: pos, title: subject)
	```

4. Toast with image, title...

	![Third Screenshot](https://raw.githubusercontent.com/Rannie/Toast-Swift/master/Screenshots/image.png)

	```
	view.makeToast(message: msg, duration: duration, position: pos, title: subject, image: image)
	```

5. Show and hide activity

	![Fourth Screenshot](https://raw.githubusercontent.com/Rannie/Toast-Swift/master/Screenshots/activity.png)

	```
	view.makeToastActivity()
	view.hideToastActivity()
	```

6. Show activity with message

	![Fifth Screenshot](https://raw.githubusercontent.com/Rannie/Toast-Swift/master/Screenshots/activity_message.PNG)

	```
	view.makeToastActivityWithMessage(message: msg)
	```


### LICENSE
---------

The MIT License (MIT)

Copyright (c) 2017 Hanran Liu

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


