
### 围栏代码无代码类型1

brainfuck

```
    ,----------[----------------------.,----------]
```

### 围栏代码无代码类型2

c

```
    #include <stdio.h>
    
    int main()
    {
    int a = 21;
    int b = 10;
    int c ;
    
    c = a + b;
    printf("Line 1 - c 的值是 %d\\n", c );
    c = a - b;
    printf("Line 2 - c 的值是 %d\\n", c );
    c = a * b;
    printf("Line 3 - c 的值是 %d\\n", c );
    c = a / b;
    printf("Line 4 - c 的值是 %d\\n", c );
    c = a % b;
    printf("Line 5 - c 的值是 %d\\n", c );
    c = a++;  // 赋值后再加 1 ，c 为 21，a 为 22
    printf("Line 6 - c 的值是 %d\\n", c );
    c = a--;  // 赋值后再减 1 ，c 为 22 ，a 为 21
    printf("Line 7 - c 的值是 %d\\n", c );
    
    }

```

### 围栏代码无代码类型3

clike

```
    #include <stdio.h>

    int main() {
    printf("Hello, world!");
    return 0;
    }

```

### 围栏代码无代码类型4

clojure


```

    (ns clojure.examples.hello
    (:gen-class))

    (defn hello-world [username]
    (println (format "Hello, %s" username)))

    (hello-world "world")


```

### 围栏代码无代码类型5

cpp、c++


```

    #include <iostream>
    using namespace std;
    int main()
    {
        cout << "Hello, world!" << "\\n";
        return 0;
    }


```

### 围栏代码无代码类型6

csharp、dotnet、c#


```

    using System;
    namespace HelloWorldApplication
    {
        /* 类名为 HelloWorld */
        class HelloWorld
        {
            /* main函数 */
            static void Main(string[] args)
            {
                /* 我的第一个 C# 程序 */
                Console.WriteLine("Hello World!");
                Console.ReadKey();
            }
        }
    }


```

### 围栏代码无代码类型7

css_extras


```

    /*这是个注释*/
    p
    {
        text-align:center;
        /*这是另一个注释*/
        color:black;
        font-family:arial;
    }


```

### 围栏代码无代码类型8

css


```

    /* 导航条 */
    .topnav {
    overflow: hidden;
    background-color: #333;
    }
    
    /* 导航链接 */
    .topnav a {
    float: left;
    display: block;
    color: #f2f2f2;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
    }
    
    /* 链接 - 修改颜色 */
    .topnav a:hover {
    background-color: #ddd;
    color: black;
    }


```

### 围栏代码无代码类型9

dart


```

    class Box {
    /// The value this wraps.
    Object? _value;

    /// True if this box contains a value.
    bool get hasValue => _value != null;
    }


```

### 围栏代码无代码类型10

git


```

    $ ls
    README
    $ echo 'runoob.com' > test.txt
    $ git add .
    $ git commit -m 'add test.txt'
    [master 3e92c19] add test.txt
    1 file changed, 1 insertion(+)
    create mode 100644 test.txt
    $ ls
    README        test.txt
    $ git checkout testing
    Switched to branch 'testing'
    $ ls
    README


```

### 围栏代码无代码类型11

go、golang


```

    package main
    import "fmt"
    func main() {
        var a string = "Runoob"
        fmt.Println(a)

        var b, c int = 1, 2
        fmt.Println(b, c)
    }


```

### 围栏代码无代码类型12

groovy


```

    class Example {
    static void main(String[] args) {
        // Using a simple println statement to print output to the console
        println('Hello World');
    }
    }


```

### 围栏代码无代码类型13

java


```

    public class HelloWorld {
        /* 第一个Java程序
        * 它将输出字符串 Hello World
        */
        public static void main(String[] args) {
            System.out.println("Hello World"); // 输出 Hello World
        }
    }


```

### 围栏代码无代码类型14

javascript、js、typescript、ts


```

    <script>
    function changeImage()
    {
        element=document.getElementById('myimage')
        if (element.src.match("bulbon"))
        {
            element.src="/images/pic_bulboff.gif";
        }
        else
        {
            element.src="/images/pic_bulbon.gif";
        }
    }
    </script>
    <img id="myimage" onclick="changeImage()" src="/images/pic_bulboff.gif" width="100" height="180">


```

### 围栏代码无代码类型15

json、jsonp


```

    {
        "sites": [
            { "name":"1" , "url":"1" }, 
            { "name":"2" , "url":"2" }, 
            { "name":"3" , "url":"3" }
        ]
    }


```

### 围栏代码无代码类型16

kotlin


```

    class Greeter(val name: String) {
    fun greet() { 
        println("Hello, $name")
    }
    }
    
    fun main(args: Array<String>) {
    Greeter("World!").greet()          // 创建一个对象不用 new 关键字
    }


```

### 围栏代码无代码类型17

latex


```

    \\documentclass[a4paper, 12pt]{article}

    \\begin{document}
    A sentence of text.
    \\end{document}


```

### 围栏代码无代码类型18

makefile


```

    SRC = $(wildcard *.c)
    OBJ = $(patsubst %.c, %.o, $(SRC))
    
    ALL: hello.out
    
    hello.out: $(OBJ)
            gcc $< -o $@
    
    $(OBJ): $(SRC)
            gcc -c $< -o $@


```

### 围栏代码无代码类型19

markdown、md


```

    ### 表格1

    | 题号 | 标题 | 难易度 |
    | :--- | ---:| :---: |
    | 1 | 两数之和 | 简单 |
    | 15 | 三数之和 | 中等 |
    | 262 | 行程和用户 | 困难 |

    ### 块引用1(普通内容,段落)

    > 块引用1-1
    >
    > 块引用1-2
    >
    > 块引用1-3
    >
    > 块引用1-4
    >
    > 块引用1-5
    >
    > 块引用1-6


```

### 围栏代码无代码类型20

markup、svg


```

    <svg
    width="200"     <!-- 指定SVG画布的宽度 -->
    height="200"    <!-- 指定SVG画布的高度 -->
    xmlns="http://www.w3.org/2000/svg">   <!-- 指定SVG命名空间 -->
    <!-- SVG图形内容 -->
    </svg>


```

### 围栏代码无代码类型21

python、python3、py、py3、Python ML、pythonml、pandas、pythondata


```

    #!/usr/bin/python
    # -*- coding: UTF-8 -*-
    
    str = 'Hello World!'
    
    print str           # 输出完整字符串
    print str[0]        # 输出字符串中的第一个字符
    print str[2:5]      # 输出字符串中第三个至第六个之间的字符串
    print str[2:]       # 输出从第三个字符开始的字符串
    print str * 2       # 输出字符串两次
    print str + "TEST"  # 输出连接的字符串


```

### 围栏代码无代码类型22

scala


```

    object HelloWorld {
    /* 这是我的第一个 Scala 程序
        * 以下程序将输出'Hello World!'
        */
    def main(args: Array[String]) = {
        println("Hello, world!") // 输出 Hello World
    }
    }


```

### 围栏代码无代码类型23

sql、mysql、oracle、oraclesql、sqlserver、MS SQL Server、mssql、postgresql、pgsql


```

    SELECT * FROM table_name;


```

### 围栏代码无代码类型24

swift


```

    import Cocoa

    /* 我的第一个 Swift 程序 */
    var myString = "Hello, World!"

    print(myString)


```

### 围栏代码无代码类型25

yaml


```

    key: 
        child-key: value
        child-key2: value2


```

### 围栏代码无代码类型26

cangjie、cj


```

    /**
    * 扩展Option，实现Option类型直接使用==和!=
    */
    extend Option<T> where T <: Equatable<T> {
        operator func ==(other: T): Bool {
            match (this) {
                case Some(v) => v == other
                case _ => false
            }
        }

        operator func !=(other: T): Bool {
            match (this) {
                case Some(v) => v != other
                case _ => true
            }
        }
    }


```

### 围栏代码无代码类型27

rust


```

    fn main() {
        let x = 5;
        let x = x + 1;
        let x = x * 2;
        println!("The value of x is: {}", x);
    }

```
