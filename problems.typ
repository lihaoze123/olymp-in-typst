#let problems = (
  (
    problem: (
      display-name: "Hello, World!",
      samples: (
        (input: "World", output: "Hello, World!"),
        (input: "Typst", output: "Hello, Typst!"),
      )
    ),
    statement: (
      description: [给定一个字符串 $S$，输出 "Hello, $S$!"],
      input: [输入一个字符串 $S$。],
      output: [输出答案。],
      notes: [字符串长度不超过 100。]
    )
  ),
  (
    problem: (
      display-name: "A + B",
      samples: (
        (input: "1 2", output: "3"),
        (input: "10 20", output: "30"),
      )
    ),
    statement: (
      description: [计算 $A + B$ 的值。],
      input: [输入两个整数 $A$ 和 $B$。],
      output: [输出 $A + B$ 的值。],
      notes: [$-10^9 <= A, B <= 10^9$。]
    )
  ),
  (
    problem: (
      display-name: "回文串判断",
      samples: (
        (input: "racecar", output: "Yes"),
        (input: "hello", output: "No"),
        (input: "a", output: "Yes"),
      )
    ),
    statement: (
      description: [给定一个字符串，判断它是否为回文串（正读和反读都一样的字符串）。],
      input: [输入一个字符串 $S$。],
      output: [如果是回文串输出 "Yes"，否则输出 "No"。],
      notes: [字符串长度不超过 $10^5$。]
    )
  ),
  (
    problem: (
      display-name: "数组排序",
      samples: (
        (input: "5\n3 1 4 2 5", output: "1 2 3 4 5"),
        (input: "3\n5 5 5", output: "5 5 5"),
      )
    ),
    statement: (
      description: [给定一个数组，将其排序后输出。],
      input: [
        第一行输入一个整数 $n$（$1 <= n <= 1000$），表示数组长度。

        第二行输入 $n$ 个整数，表示数组元素。
      ],
      output: [输出排序后的数组，元素之间用空格分隔。],
      notes: [数组元素范围在 $-10^6$ 到 $10^6$ 之间。]
    )
  )
)