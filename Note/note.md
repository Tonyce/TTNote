    

### 关于Note： 
Note是一款简单的文字书写及记录软件，他采用markdown语法来标记文字，使得编辑好的文本更好的适用于现代网络的传输和分发。
### 什么是markdown？
Markdown是一种可以使用普通文本编辑器编写的标记语言，通过简单的标记语法，它可以使普通文本内容具有一定的格式。Markdown的语法简洁明了、学习容易，而且功能比纯文本更强。    

** 使用 Markdown 的优点 **    

* 专注你的文字内容而不是排版样式。
* 轻松的导出 HTML、PDF 和本身的 .md 文件。
* 纯文本内容，兼容所有的文本编辑器与字处理软件。
* 可读，直观。适合所有人的写作语言。   

## Markdown语法 ##

### 标题 ###

----------

在行首插入1~6个 `#` 号，分别对应 1 至 6 级标题 :

# 一级标题  #

## 二级标题 ##

### 三级标题 ###

#### 四级标题 ####

##### 五级标题 #####

###### 六级标题 ######                

### 强调 ###

----------

加粗：

**加粗** 

斜体（部分字体没有倾斜效果）：

*倾斜*


### 链接 ###

----------

[链接说明](http://example.com/)


### 图片 ###

----------

![图片说明](http://example.com/image.png)

### 列表 ###

----------

有序列表:

1.  第一列
1.  第二列
1.  第三列

无序列表:

-   某列
-   某列
-   某列

可以混合使用有序列表和无序列表:

-   一级项
- 二级项
-   一级项
1.  二级项1
2.  二级项2
- 三级项
3.  二级项3
-   一级项


### 语句引用 ###

----------

> 乔布斯说过：
> Stay hungry, stay foolish.

> > 你也可以嵌套使用.

> #### 标题 也可出现在引用中
>
> - 当然列表也可以.
> - 是吧.


### 代码 ###

----------

单行代码：`<code>` .

也可以有多行代码：
```
line1
line2
```

### 缩进代码块 ###

----------

4个空格或者一个 tab 后面的文本都会被当做代码.

这是一个普通段落.

这是一段
代码.

### 表格 ###

----------

一个简单的表格:

Heading | Heading | Heading
------- | ------- | -------
Cell   |  Cell   |  Cell
Cell   |  Cell   |  Cell


如果你喜欢，也可以给表格加上外边界（效果和上面一样）:

| Heading | Heading | Heading |
| ------- | ------- | ------- |
|   Cell  |   Cell  |   Cell  |
|   Cell  |   Cell  |   Cell  |

你可以控制表格里面元素的对其方式:

Heading | Heading | Heading
:----- | :----: | ------:
Left   | Center | Right
Left   | Center | Right

### 删除线 ###

----------

~~Strikethrough~~

### 分割线 ###

----------

三种分割线:

---

* * *

- - - -


** Markdown 指南：**  

**标题**   
标题能显示出文章的结构。行首插入1-6个 # ，每增加一个 # 表示更深入层次的内容，对应到标题的深度由 1-6 阶。    
![](http://cdn.sspai.com/attachment/thumbnail/2014/04/15/620e64aa6522f5eaeb788a8b5f1faa5c10f74_mw_800_wm_1_wmp_3.jpg)
 
**列表:**    

![](http://cdn.sspai.com/attachment/thumbnail/2014/04/15/a72338b96cf4bfc1dacd610756786ae310f75_mw_800_wm_1_wmp_3.jpg)

**引用:**
如果你需要引用一小段别处的句子，那么就要用引用的格式。

\\> 例如这样   
> 例如这样

只需要在文本前加入 > 这种尖括号（大于号）即可
![](http://cdn.sspai.com/attachment/thumbnail/2014/04/15/07bd8bf6fd38ea7d3bffdc3cae04f6f210f76_mw_800_wm_1_wmp_3.jpg)

**图片与链接**   
插入链接与插入图片的语法很像，区别在一个 !号   
![](http://cdn.sspai.com/attachment/thumbnail/2014/04/15/f96c892fc63933ab186235f7c910753b10f77_mw_800_wm_1_wmp_3.jpg)
**粗体与斜体**   
Markdown 的粗体和斜体也非常简单，用两个 \* 包含一段文本就是粗体的语法, 用一个 \* 包含一段文本就是斜体的语法

**删除线:**  
~~text~~

**换行:**   
一行结束时输入三个及以上空格    

分割线
分割线的语法只需要另起一行，连续输入三个星号 \*\*\* 即可   
***   


**代码**   
使用三个回勾号（```code）   

\```
<header>
<h1>{{title}}</h1>
</header>
\```

```
<header>
    <h1>{{title}}</h1>
</header>
```


## Markdown简介

> Markdown 是一种轻量级标记语言，它允许人们使用易读易写的纯文本格式编写文档，然后转换成格式丰富的HTML页面。    —— [维基百科](https://zh.wikipedia.org/wiki/Markdown)

正如您在阅读的这份文档，它使用简单的符号标识不同的标题，将某些文字标记为**粗体**或者*斜体*，创建一个[链接](http://www.example.com)或一个脚注[^demo]。下面列举了几个高级功能，更多语法请按`Ctrl + /`查看帮助。 

### 代码块
``` python
@requires_authorization
def somefunc(param1='', param2=0):
'''A docstring'''
if param1 > param2: # interesting
print 'Greater'
return (param2 - param1 + 1) or None
class SomeClass:
pass
>>> message = '''interpreter
... prompt'''
```
### LaTeX 公式

可以创建行内公式，例如 $\Gamma(n) = (n-1)!\quad\forall n\in\mathbb N$。或者块级公式：

$$	x = \dfrac{-b \pm \sqrt{b^2 - 4ac}}{2a} $$

### 表格
| Item      |    Value | Qty  |
| :-------- | --------:| :--: |
| Computer  | 1600 USD |  5   |
| Phone     |   12 USD |  12  |
| Pipe      |    1 USD | 234  |

### 流程图
```flow
st=>start: Start
e=>end
op=>operation: My Operation
cond=>condition: Yes or No?

st->op->cond
cond(yes)->e
cond(no)->op
```

以及时序图:

```sequence
Alice->Bob: Hello Bob, how are you?
Note right of Bob: Bob thinks
Bob-->Alice: I am good thanks!
```

> **提示：**想了解更多，请查看**流程图**[语法][3]以及**时序图**[语法][4]。

### 复选框

使用 `- [ ]` 和 `- [x]` 语法可以创建复选框，实现 todo-list 等功能。例如：

- [x] 已完成事项
- [ ] 待办事项1
- [ ] 待办事项2

> **注意：**目前支持尚不完全，在印象笔记中勾选复选框是无效、不能同步的，所以必须在**马克飞象**中修改 Markdown 原文才可生效。下个版本将会全面支持。



   




