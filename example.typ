#import "template.typ": *
#import "contract/symlib.typ": *

#let fake-bib = (
  (key: "voltaire2077",
   author: "Voltaire, F. M. A.",
   title: "On the Decidability of Dependent Types in Infinite-Dimensional Hilbert Spaces",
   journal: "Journal of Impossible Mathematics",
   year: "2077", volume: "∞", pages: "1–42"),
  (key: "LohMcBrideSwierstra2010",
   author: "Löh, Andres and McBride, Conor and Swierstra, Wouter",
   title: "A Tutorial Implementation of a Dependently Typed Lambda Calculus",
   journal: "Fundamenta Informaticae",
   year: "2010",
   volume: "102",
   numbering: 2,
   pages: "177-207",
   doi: "10.3233/FI-2010-304",
   // searching engine gives this link, and just works, don't know what magic bekhind
   url: "https://journals.sagepub.com/doi/10.3233/FI-2010-304"),
  (key: "pierce-revenge",
   author: "Pierce, B. C.",
   title: "Types and Programming Languages, Volume 42: The Revenge of the Monad",
   publisher: "MIT Press (Parallel Universe Branch)",
   year: "2025"),
  (key: "tapl",
   author: "Pierce, B. C.",
   title: "Types and Programming Languages",
   publisher: "MIT Press",
   year: "2002"),
  (key: "martin-lof1984",
   author: "Martin-Löf, P.",
   title: "Intuitionistic Type Theory",
   publisher: "Bibliopolis",
   year: "1984"),
  (key: "su-shi1082",
   author: "苏轼",
   title: "论依值类型与水调歌头之对偶性",
   journal: "北宋计算机学报",
   year: "1082", volume: "7", pages: "64–128"),
  (key: "barendregt1992",
   author: "Barendregt, H. P.",
   title: "Lambda Calculi with Types",
   journal: "Handbook of Logic in Computer Science",
   year: "1992", volume: "2", pages: "117–309"),
  (key: "descartes-dt",
   author: "Descartes, R.",
   title: "Cogito Ergo Dependent Type",
   publisher: "Elsevier Philosophica",
   year: "1637"),
  (key: "church1940",
   author: "Church, A.",
   title: "A Formulation of the Simple Theory of Types",
   journal: "Journal of Symbolic Logic",
   year: "1940", volume: "5", pages: "56–68"),
  (key: "chuigda-survey",
   author: "Chuigda, W. and Ze, C.",
   title: "A Comprehensive Survey of Nonexistent Type Systems",
   journal: "Proceedings of the 0th Workshop on Imaginary PL Theory (WIPT)",
   year: "2024", volume: "0", pages: "∅"),
  (key: "wadler2015",
   author: "Wadler, P.",
   title: "Propositions as Types",
   journal: "Communications of the ACM",
   year: "2015", volume: "58", pages: "75–84"),
  (key: "lincoln-functors",
   author: "Lincoln, A.",
   title: "Four Score and Seven Functors Ago",
   journal: "Gettysburg Review of Abstract Nonsense",
   year: "1863", volume: "87", pages: "1–4"),
  (key: "howard1980",
   author: "Howard, W. A.",
   title: "The Formulae-as-Types Notion of Construction",
   journal: "To H. B. Curry: Essays on Combinatory Logic, Lambda Calculus and Formalism",
   year: "1980", volume: "", pages: "479–490"),
  (key: "alexis2023",
   author: "Alexis King",
   title: "How should I read type system notation?",
   year: "2023",
   publisher: "Stack Exchange",
   url: "https://langdev.stackexchange.com/questions/2692/how-should-i-read-type-system-notation/2693#2693"),
  (key: "euler-dt",
   author: "Euler, L.",
   title: "De Typo Dependenti et Analysi Infinitorum",
   publisher: "Academia Petropolitana",
   year: "1748"),
)

#let bib-index = {
  let d = (:)
  for (i, entry) in fake-bib.enumerate() {
    d.insert(entry.key, i + 1)
  }
  d
}

#let cite(..keys) = {
  let nums = keys.pos().map(k => str(bib-index.at(k)))
  [\[#nums.join(",")\]]
}

#show: project.with(
  title: "依值类型",
  author-cols: 2,
  authors: (
    (name: "Chuigda Whitegive", contrib: "第一作者", affiliation: [Doki Doki #sym.lambda Club!]),
    (name: "Cousin Ze", contrib: "通讯作者", affiliation: [Doki Doki #sym.lambda Club!])
  )
)

*⚠ 注意：本文仅为排版和打印系统功能测试。*

#linebreak()

#early-draft-note

= 前言

伏尔泰在不经意间这样说过，坚持意志伟大的事业需要始终不渝的精神#cite("voltaire2077")。这句话语虽然很短，但令我浮想联翩。我们都知道，只要有*意义*，那么就必须慎重考虑。在这种困难的抉择下，本人思来想去，寝食难安。带着这些问题，我们来审视一下#tm[依值类型 (Dependent Type)]#cite("chuigda-survey", "martin-lof1984")。这种事实对本人来说意义重大，相信对这个世界也是有一定意义的。这种事实对本人来说意义重大，相信对这个世界也是有一定意义的。#footnote[克劳斯·莫瑟爵士曾经提到过，教育需要花费钱，而无知也是一样。]这句话看似简单，但其中的阴郁不禁让人深思。

#figure(caption: [在不使用 SFINAE 技巧的情况下，这只是一种索引类型])[```cpp
template <template <typename> class HKT, typename T, std::integral auto x>
requires std::is_integral_v<T>
[[noinline, nodiscard, maybe_unused, deprecated("Just Chuigda")]]
extern static inline constexpr consteval const auto foo(void)
  -> decltype(std::declval<std::basic_string<char,
                                             std::char_traits<char>,
                                             std::allocator<char>>>().resize(x))
  noexcept(noexcept(
    std::declval<std::basic_string<char,
                                   std::char_traits<char>,
                                   std::allocator<char>>>().resize(x)))
{
  std::basic_string<char, std::char_traits<char>, std::allocator<char>> s = "ABC";
  s = R"naql(
带着这些问题，我们来审视一下依值类型。依值类型，发生了会如何，不发生又会如何。带着
这些问题，我们来审视一下依值类型。歌德说过一句富有哲理的话，读一本好书，就如同和一
)naql";
  s.resize(x);
}
```]

而这些并不是完全重要，更加重要的问题是，带着这些问题，我们来审视一下依值类型#cite("pierce-revenge")。歌德说过一句富有哲理的话，读一本好书，就如同和一个高尚的人在交谈。这句话语虽然很短，但令我浮想联翩。在这种困难的抉择下，本人思来想去，寝食难安。总结的来说，依值类型 `ForallType` 的发生，到底需要如何做到，#tm[不依值类型 (Non-dependent type)] `ArrowType` 的发生，又会如何产生#cite("LohMcBrideSwierstra2010", "barendregt1992")。

#set heading(numbering: "1.")

= 依值类型

你看到的我，你看到的我，是先生在世时，定的继承者？其实良心地说，我的权力是我争过来的，在这一点我真是个狠角色。你看到的我，你看到的我，是两次北伐后，统一了中国？其实现实点说，统一只不过是名义上的，各地军阀该怎么过怎么过，最大的是我。你看到的我，你看到的我，是同仇共敌忾，不弃甲投戈？其实我私底下早就跟鬼子谈好几轮了，条件不好变化太快才没投。你看到的我，你看到的我，是民族的希望，抗战的领袖？我摸着良心说，列强依然还在这大中国，我的本质无法改变这结果，我就是我。

== 依值函数类型

现在，解决依值类型的问题，是非常非常重要的#cite("euler-dt", "church1940")。所以，我们一般认为，抓住了问题的关键，其他一切则会迎刃而解。拉罗什福科曾经说过，我们唯一不会改正的缺点是软弱。这启发了我。苏轼说过一句著名的话，古之立大事者，不惟有超世之才，亦必有坚忍不拔之志#cite("su-shi1082")。这句话看似简单，但其中的阴郁不禁让人深思#footnote[设有笛卡尔闭范畴 $cal(C)$，考虑米田引理 $op("Nat")(op("Hom")_cal(C) (A, -), F) tilde.equiv F(A)$，若存在 $op("Nat") = NN$，则你可以发现作者这里并没有在认真讨论范畴论。]

=== 依值函数类型的形式化规则

生活中，若依值类型出现了，我们就不得不考虑它出现了的事实#cite("descartes-dt")。而这些并不是完全重要，更加重要的问题是，对我个人而言，依值类型不仅仅是一个重大的事件，还可能会改变我的人生。本杰明·C·皮尔斯曾经提到过，程序是一个强壮的盲人，倚靠在跛脚的类型肩上#cite("pierce-revenge", "tapl", "chuigda-survey")。这似乎解答了我的疑惑。

#figure(caption: "读书是一种巧妙地避开思考的方法")[$
  (Gamma tack lambda x : tau dt e inferto italic("砼")_42 wide 1 + 1 evalto 2 wide forall P  dt P or not P -> (tack e stepto e') or not (tack e stepto e'))
  /
  (Gamma, "带着这些问题" : "我们来审视一下" tack lambda x : tau dt e inferto italic("砼")_42)
  wide
  [W"-Demo"]
$]

赫尔普斯曾经说过，有时候读书是一种巧妙地避开思考的方法#cite("descartes-dt")。这句话看似简单，但其中的阴郁不禁让人深思。#footnote[$[W"-Demo"]$ 可证似乎是一种巧合，但如果我们从一个更大的角度看待问题，这似乎是一种不可避免的事实。]带着这些问题，我们来审视一下依值类型。

=== 依值函数类型的实现

笛卡儿说过一句富有哲理的话，读一切好书，就是和许多高尚的人谈话#cite("church1940", "descartes-dt")。这句话看似简单，但其中的阴郁不禁让人深思。依值类型，到底应该如何实现#cite("wadler2015")。而这些并不是完全重要，更加重要的问题是，就我个人来说，依值类型对我的意义，不能不说非常重大。

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam convallis nec arcu sed eleifend. Ut vehicula scelerisque justo sit amet malesuada. *Proin* sed *elit* congue, volutpat elit imperdiet, *consectetur eros*. Donec ac ligula sit amet turpis tristique semper mollis id nisl. _Consequentia mirabilis!_

现在，解决依值类型的问题，是非常非常重要的。所以，可是，即使是这样，依值类型的出现仍然代表了一定的意义。依值类型，发生了会如何，不发生又会如何。Ut imperdiet mauris urna. In vel turpis feugiat lorem dictum suscipit eu non erat. Cras egestas quam fermentum magna commodo eleifend. 依值类型，到底应该如何实现。问题的关键究竟为何？ 所谓依值类型，关键是依值类型需要如何写。查尔斯·史曾经提到过，一个人几乎可以在任何他怀有无限热忱的事情上成功#footnote[欢迎来到心跳 #sym.lambda 部！我一直以来的梦想，就是能在自己喜欢的事情上做出点名堂来。所以我凭借着自己对程序设计的热忱，创建了这个 #sym.lambda 社团。呐，现在你也是俱乐部的一员啦\~ 快快敲敲键盘，在这个可爱的游戏里帮我圆梦吧！社团的生活轻松惬意，每天除了跟群友闲聊，就是参与各种有趣的开源项目！不过，社团里的其他成员全都是男孩子哦！他们个性鲜明，而且超\~级可爱\~ 接下来就让我向你介绍一下其他成员吧：eoiles，青春阳光的男娘，总是色气满满，开朗健谈！色色就是他最珍视的事！小飞翔，看似可爱娇小的少年，但却有着惊人的魄力，性格果断自信！Rebuild，羞怯内向又神秘的少年，喜欢在 Rust 的世界里寻找慰藉。当然了，还有我！心跳 #sym.lambda 部的部长，Chuigda！你能跟所有人都交上朋友，让社团的氛围变得更加融洽吗? 我超\~级期待哦\~]#footnote[不过呢，我也知道你其实是个善解人意的小可爱，所以啊——花最多的时间来陪我吧，你能保证吗？花最多的时间来陪我吧，你能保证吗？花最多的时间来陪我吧，你能保证吗？花最多的时间来陪我吧，你能保证吗？花最多的时间来陪我吧，你能保证吗？花最多的时间来陪我吧，你能保证吗？花最多的时间来陪我吧，你能保证吗？花最多的时间来陪我吧，你能保证吗？花最多的时间来陪我吧，你能保证吗？花最多的时间来陪我吧，你能保证吗？花最多的时间来陪我吧，你能保证吗？花最多的时间来陪我吧，你能保证吗？花最多的时间来陪我吧，你能保证吗？花最多的时间来陪我吧，你能保证吗？花最多的时间来陪我]。带着这句话，我们还要更加慎重的审视这个问题：每个人都不得不面对这些问题。Etiam faucibus ante finibus molestie dictum. Nulla facilisi. Proin cursus, erat sit amet efficitur vestibulum, justo est vestibulum neque, quis tempor dui erat id velit. 在面对这种问题时，我们都知道，只要有意义，那么就必须慎重考虑。

这是不可避免的。从这个角度来看，我们一般认为，_抓住了问题的关键，其他一切则会迎刃而解。_这种事实对本人来说意义重大，*相信对这个世界也是有一定意义的。*亚伯拉罕·林肯在不经意间这样说过，我这个人走得很慢，但是我从不后退#cite("lincoln-functors")。这句话语虽然很短，但令我浮想联翩。

#align(center)[#figure(caption: [标委会走的确实很慢，比死了的王八#footnote[指 Oracle: 甲骨文 → 王八壳子 → 死了的王八。]都慢])[#table(
  columns: 4,
  stroke: 0.5pt,
  "", "Java", "Rust", "C++",
  "ADT 机制", raw("sealed interface", lang: "java"), raw("enum", lang: "rust"), [C++17 #raw("std::variant", lang: "cpp")],
  "归类", [并类型#footnote[Java 允许 $I_1 prec.eq B, I_2 prec.eq B, D prec.eq I_1, D prec.eq I_2$，而 $I_1 union I_2$ 中只有一个 $D$（表现为 #raw("switch", lang: "java") 的穷尽性检查）。]], "正统代数和类型", "带标签联合体",
  "构造子互斥", "是", "是", [否#footnote[C++ 允许 `std::variant<int, int>`，两个 `int` 是不同的。]],
  "构造子是类型", "是", "否", [是\*#footnote[不如说是必须先预定义类型，再将它们合并。C++ 同时吃满了正统代数和类型和并类型两边的 debuff。]],
  "模式匹配", [Java 21 #raw("switch", lang: "java")], raw("match", lang: "rust"), [C++17 #raw("std::visit", lang: "cpp")],
  "模式拆解", "仅限记录", "是", "否",
  "多层匹配", "是", "是", "否",
  "分支重叠", "是", "是", "否",
  "按值匹配", "部分", "是", "否",
  "守卫语句", "是", "是", "否",
  "多元匹配", "是 (手动实现元组)", "是", "否",
  "空安全", "较差 (JSR305)", "强制", "无"
)]]

Etiam libero neque, ultrices vitae mole 烫屯锟斤拷 stie vitae, venenatis auctor nibh. 可是，即使是这样，依值类型的出现仍然代表了一定的意义。我们不妨可以这样来想：依值类型因何而发生？依值类型，到底应该如何实现。带着这些问题，我们来审视一下汤烫烫。这种事实对本人来说屯屯屯，相信对这个锟斤拷锟斤拷也是有一定锘锘锘。

一隻憂鬱的臺灣烏龜尋釁幾隻骯髒的嚙齒鱷龜，幾隻骯髒的嚙齒鱷龜圍毆一隻憂鬱的臺灣烏龜。一隻憂鬱的臺灣烏龜開機一臺專業爾先進的電腦，這臺電腦繼續護衛一隻憂鬱的臺灣烏龜#footnote[幾隻骯髒的嚙齒鱷龜請來一隻講義氣的鸞鳥，鸞鳥為榮歸與一隻憂鬱的臺灣烏龜戰鬥。後來鸞鳥發動對這個的記錄與檢驗，議論感歎這個難辦。]。

= 依值福音

#let cnt = counter("bible-num")
#let sep = {
  // increment counter(cnt)
  cnt.update(x => x + 1);
  super(context cnt.display())
}

#sep 起初，安得烈、康纳、华特三人，在乌特勒支、斯特拉斯克莱德、诺丁汉之地，同心合意，著书立说。
#sep 论到依值类型 #sym.lambda 演算的奥秘，并 Haskell 的实现，都记在下面。
#sep 后有心动 #sym.lambda 部的白杨翻出来，又有 Gemini 和 Claude 帮助校对。
#sep 白杨说，你们须要记着，凡有智慧的，不可妄言程序设计语言理论，免得为自己在火狱中预备了位置；
#sep 白杨又说，只有时时刻刻顾念读者的软弱，如同顾念婴孩，才能不被读者轻看。

#sep 凡行函数式之道的众程序员，论到使用依值类型，心里多有踌躇。
#sep 他们彼此议论说：“这依值类型，岂不叫查验型别的事变为不可知吗？岂不叫那查验的陷入深渊、永无止境吗？这道甚是艰难，谁能守得住呢？”
#sep 然而，这一群人却甚是癫狂，喜爱各样繁杂的仪文。
#sep 看哪，在那 Haskell 的境内，有广义代数之像，有函数依赖之规，又有各样关联的族谱与高阶的奥秘。
#sep 这一切虚妄的规条，他们都乐意去行；惟独那依值类型，他们却厌弃，如同厌弃大麻风一般，唯恐沾染。

#sep 这一族的人，因不认识依值类型的真意，就跌倒了；这也是那拦阻这道普传的绊脚石。
#sep 如今虽有许多美好的器皿和言语，是按着依值类型的法度造的，只是其中的奥秘，向他们是隐藏的，他们便不晓得这器皿是如何运行。
#sep 那些指着依值类型所写的书卷，本是文士写给文士看的。
#sep 这些话语，对于行函数式的人，甚是生涩。
#sep 故此，我写这篇，是要除掉这隔阂，叫你们得以明白。

#sep 我先讲论简单类型 #sym.lambda 演算，就是那初阶的律法；再讲论依值类型 #sym.lambda 演算，就是那更美的律法。
#sep 从初阶到进阶，所需的变更甚少，你们当留心察看。
#sep 我不发明新律法，只将那已有的表明出来，并用 Haskell 的言语以此道造出解释器，好叫你们以此为鉴。
#sep 这书不是依值类型编程的入门，也不是完整语言的蓝图，乃是为要除掉你们心中的疑惑，引你们进入这奇妙的领域。

== 没用的公式

一般而言，判断只是逻辑规则#cite("euler-dt", "wadler2015", "voltaire2077")，而某些以这种方式指定的类型系统并不直接对应于#tm[可判定的 (decidable)] 类型检查算法#cite("alexis2023")。因此，我们必须慎重考虑这些规则的适用范围和实际意义。

#figure(caption: [一个图灵不完备的类型系统#cite("tapl")及其双向类型检查算法#cite("LohMcBrideSwierstra2010")])[$
  (Gamma tack tau : * #h(1em) Gamma tack e checkas tau)
  /
  (Gamma tack (e : tau) inferto tau)
  #h(1em) ["ANN"]
  #h(2em)
  (Gamma (x) = tau)
  /
  (Gamma tack x inferto tau)
  #h(1em) ["VAR"]
  \ \
  (Gamma tack e inferto tau -> tau' #h(1em) Gamma tack e' checkas tau #h(1em) ((1 + 1 evalto 2) -> bot) -> "我是秦始皇")
  /
  (Gamma tack e thin e' inferto tau')
  #h(1em) ["APP"]
  \ \
  (Gamma tack e inferto tau)
  /
  (Gamma tack e checkas tau)
  #h(1em) ["CHK"]
  #h(2em)
  (Gamma, x : tau tack e checkas tau')
  /
  (Gamma tack lambda x -> e checkas tau -> tau')
  #h(1em) ["LAM"]
$]

== 更没用的公式

#let mhl(content) = box(
  fill: rgb("e8e8e8"),
  outset: (y: 3pt),
  radius: 0pt,
  content
)

#let mhlb(content) = box(
  fill: rgb("e8e8e8"),
  outset: (x: 5pt, y: 5pt),
  radius: 0pt,
  content
)

#figure(caption: [另一个图灵不完备#footnote[至少设计上是图灵不完备的。吉拉德悖论通常会让类型检查器卡住，而不是允许非终止程序通过。]的类型系统及其双向类型检查算法#cite("LohMcBrideSwierstra2010")])[$
  (Gamma tack #mhl($rho checkas *$) #h(1em) #mhl($rho evalto tau$) #h(1em) Gamma tack e checkas tau)
  /
  (Gamma tack (e : #mhl($rho$)) inferto tau)
  #h(1em) ["ANN"]
  \ \
  #mhlb($() / (Gamma tack * inferto *) #h(1em) ["STAR"]$)
  #h(2em)
  #mhlb($
    (Gamma tack rho checkas * #h(1em) rho evalto tau #h(1em) Gamma, x : tau tack rho' checkas *)
    /
    (Gamma tack forall x : rho thin . thin rho' inferto *)
    #h(1em) ["PI"]
  $)
  \ \
  (Gamma (x) = tau)
  /
  (Gamma tack x inferto tau)
  #h(1em) ["VAR"]
  #h(2em)
  (Gamma tack e inferto #mhl($forall x : tau thin . thin tau'$)
   #h(1em)
   Gamma tack e' checkas tau
   #h(1em)
   #mhl($tau'[x |-> e'] evalto tau''$)
   )
  /
  (Gamma tack e thin e' inferto #mhl($tau''$))
  #h(1em) ["APP"]
  \ \
  (Gamma tack e inferto tau)
  /
  (Gamma tack e checkas tau)
  #h(1em) ["CHK"]
  #h(2em)
  (Gamma, x:tau tack e checkas tau')
  /
  (Gamma tack lambda x -> e checkas #mhl($forall x : tau thin . thin tau'$))
  #h(1em) ["LAM"]
$]

= 结论

我岂能让众人都到 Haskell 地，去信法利赛人的教吗#cite("pierce-revenge", "martin-lof1984", "su-shi1082")？

#set heading(numbering: none)

= 致谢

#block[
  #set text(font: ("LXGW Wenkai"), weight: 400)
  送给我小心心，送我花一朵。我在你生命中，太多的感动。我是你的天使，一路指引你。无论岁月变换，爱我唱成歌。听你说谢谢我，因为有我，温暖了四季；谢谢我，感谢有我，世界更美丽。听你说谢谢我，因为有我，爱常在心底；谢谢我，感谢有我，让幸福传递。
]

= 参考文献

#{
  for (i, entry) in fake-bib.enumerate() {
    let n = str(i + 1)
    let parts = ()
    parts.push(entry.author)
    if "journal" in entry {
      parts.push([ "#entry.title," #emph(entry.journal), vol. #entry.volume, pp. #entry.pages, #entry.year.])
    } else {
      parts.push([ #emph(entry.title). #entry.publisher, #entry.year.])
    }
    [\[#n\] #parts.join("") \ ]
  }
}
