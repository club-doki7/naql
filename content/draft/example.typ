#import "../template.typ": *
#import "../symlib.typ": *

#show: project.with(
  title: "朱蒲-格拉德格林悖论",
  author-cols: 3,
  authors: (
    (name: "Claude", contrib: "第一作者", affiliation: "Anthropic"),
    (name: "Chuigda Whitegive", contrib: "通讯作者", affiliation: [Doki Doki #lambda Club!]),
    (name: "Gemini", contrib: "编辑", affiliation: "Google Deepmind")
  )
)

*⚠ 注意：本文仅为排版和打印系统功能测试。#footnote[请注意：本文内容除《艰难时世》原文、原著剧情及部分哲学思考外均为虚构。文中公式和代码不具有形式严谨性。大部分内容由 Anthropic Claude 在 Chuigda 指导下生成，并由 Google Gemini 用 Typst 重新排版。]*

#early-draft-note

#set heading(numbering: "1.")
#set quote(block: true)
#set math.equation(numbering: "(1)")

= 历史起源

1854年，#link("https://en.wikipedia.org/wiki/Charles_Dickens")[查尔斯·狄更斯]在#link("https://en.wikipedia.org/wiki/Hard_Times_(novel)")[《艰难时世》]第二章中记录了一次著名的课堂实验 @dickens1854hard。格拉德格林先生要求“二十号女生”朱蒲定义“马”。朱蒲无法作答。随后，毕策先生（Bitzer）给出了完美定义：

#quote[“四足动物。食草类。四十颗牙齿……蹄子坚硬，但需要装蹄铁。年龄可从口中辨认。”]

格拉德格林先生宣布：*“这才是事实。这才叫认识一匹马。”*

朱蒲——在马戏团长大、每天喂马、骑马、与马同眠的女孩——被判定为“不认识马”。

这一场景在1978年被科学哲学家玛格丽特·A·博登（Margaret A. Boden）重新发现，并正式命名为#tm_fst("朱蒲-格拉德格林悖论", "Jupe-Gradgrind Paradox") @boden1978knowing，用以指称以下困境：

#quote[
  *一个系统对某对象的形式化描述越完备，其对该对象的真实认知反而越不可判定；而一个系统越是无法给出形式化描述，其实际交互能力可能越强——但在任何可检验的框架内都无法证明这一点。*
]

= 形式表述

设认知主体 $S$ 面对对象 $O$。定义：

- $cal(D)(S, O)$：$S$ 对 $O$ 的#tm_fst("可陈述知识", "declarative knowledge")，即 $S$ 能以命题形式输出的关于 $O$ 的全部描述集合。
- $cal(E)(S, O)$：$S$ 对 $O$ 的#tm_fst("具身知识", "embodied knowledge")，即 $S$ 与 $O$ 交互时展现的全部行为能力的集合。
- $cal(V)(S, O)$：某外部评估者（“格拉德格林函数”）对 $S$ 认知 $O$ 之程度的判定值。

朱蒲-格拉德格林悖论陈述如下：

$ cal(V)(S, O) = f(cal(D)(S, O)) $

即：评估函数 $cal(V)$ *仅为* $cal(D)$ 的函数，与 $cal(E)$ 完全无关。然而，存在主体 $J$（朱蒲型主体）和 $B$（毕策型主体），满足：

$ cal(D)(J, O) << cal(D)(B, O) $
$ cal(E)(J, O) >> cal(E)(B, O) $

#colbreak()

因此：

$ cal(V)(J, O) << cal(V)(B, O) $

但在一切涉及 $O$ 的实际操作中，$J$ 的表现严格优于 $B$。

*悖论的核心*在于：没有任何一个既满足格拉德格林评估标准又保持自洽的认知框架，能同时容纳 $cal(D)$ 和 $cal(E)$ 两种知识形式。更严格地说——

#quote[
  任何将“认识 $O$”定义为“能正确陈述关于 $O$ 的命题集”的认知评估体系，都必然系统性地将最高认知分数赋予与 $O$ #tm[无任何因果历史的]主体，而将最低分数赋予与 $O$ 具有#tm[最深因果纠缠的]主体。
]

即：*该评估体系所度量的，恰好是它意图度量之物的补集。*

以下表格总结了朱蒲型主体与毕策型主体在两种知识维度上的对照：

#figure(
  table(
    columns: (auto, 1fr, 1fr, 1fr),
    align: (left, center, center, center),
    table.header(
      [*主体*], [*$cal(D)(S,O)$ \ 可陈述知识*], [*$cal(E)(S,O)$ \ 具身知识*], [*$cal(V)(S,O)$ \ 格拉德格林评分*],
    ),
    [朱蒲 ($J$)], [$approx 0$], [$approx 1$], [$approx 0$],
    [毕策 ($B$)], [$approx 1$], [$approx 0$], [$approx 1$],
    [大语言模型], [$>> 1$], [$= 0$], [$>> 1$],
    [具身机器人], [$approx 0$], [$0 < dot < 1$], [$approx 0$],
  ),
  caption: [不同主体在朱蒲-格拉德格林框架下的知识分布],
) <tab:knowledge>

从 @tab:knowledge 可以清楚地看到评估偏差的系统性。该表格的灵感部分来源于博登原始论文 @boden1978knowing 中的非正式讨论，以及后来 #link("https://plato.stanford.edu/entries/knowledge-how/")[斯坦福哲学百科全书关于"knowing-how"的条目]中对该问题的综述。

= 格拉德格林测量问题

悖论的深层结构可类比量子力学的测量问题。

朱蒲对“马”的认知处于一种#tm[叠加态]——她同时知道马的气味在雨后如何变化、知道一匹马在恐惧与兴奋时肌肉震颤的区别、知道该在什么时刻将方糖递到马唇边——这些知识以非命题的、分布式的、身体图式的方式叠加存在。

格拉德格林的提问（“定义马”）构成一次#tm[测量操作]。该操作迫使叠加态向 $cal(D)$ 空间#tm[坍缩]。但朱蒲的认知本征态几乎完全落在 $cal(E)$ 空间中，与 $cal(D)$ 空间近乎正交。因此，测量结果为零。

这并非朱蒲“不知道”。这是*#tm[格拉德格林算子]选错了基底*。

定义#tm[格拉德格林算子] $hat(G)$：

$ hat(G) |psi_J chevron.r = lambda |d chevron.r $

其中 $|psi_J chevron.r$ 是朱蒲的认知态，$|d chevron.r$ 是陈述性知识本征态。由于 $chevron.l d | psi_J chevron.r approx 0$，测量几乎必然返回零本征值。

而对毕策：

$ chevron.l d | psi_B chevron.r approx 1 $

测量完美返回。但 $|psi_B chevron.r$ 与实际的马之间没有任何纠缠历史——毕策的知识态是在教室里被制备的，是一个#tm[纯制备态]，从未与对象发生过#tm[退相干]。

#colbreak()

这就引出了一个不可回避的推论：

#quote[
  *格拉德格林算子是一个完备的测量算子，但它测量的不是“知识”，而是“教育”——这两者之间的关联性是经验性的，而非逻辑必然的。*
]

= 焦煤镇定理（Coketown Theorem）

1991年，爱丁堡大学的K. M. 哈特豪斯（K. M. Harthouse）在此基础上证明了所谓的*焦煤镇定理* @harthouse1991coketown：

#quote[
  *在一个所有认知评估均由格拉德格林算子执行的封闭系统（“焦煤镇”）中，系统的总具身知识 $sum cal(E)$ 将单调递减，而总陈述知识 $sum cal(D)$ 将单调递增，直至系统达到热力学意义上的#tm_fst("事实死寂", "fact-death") 状态——即所有主体都能完美定义马，但没有任何主体能骑马。*
]

证明的关键步骤依赖于一个简单的激励论证：在格拉德格林评估体系下，任何理性主体都会将有限时间从 $cal(E)$ 训练转移到 $cal(D)$ 训练，因为只有后者产生可被系统识别的回报。经过足够多代迭代，具身知识因无法被评估而被系统性淘汰。

狄更斯在小说中对此的文学表述是：焦煤镇生产出了堆积如山的事实，和无穷无尽的不幸。
下表展示了焦煤镇系统在迭代过程中知识结构的典型演化轨迹：

#figure(
  table(
    columns: (auto, 1fr, 1fr, 1fr),
    align: (center, center, center, center),
    table.header(
      [*迭代轮次*], [*$sum cal(D)$ / 总陈述知识*], [*$sum cal(E)$ / 总具身知识*], [*系统状态*],
    ),
    [$t = 0$], [0.50], [0.50], [初始均衡],
    [$t = 10$], [0.71], [0.33], [偏移开始],
    [$t = 25$], [0.89], [0.14], [加速衰减],
    [$t = 50$], [0.98], [0.02], [#text(fill: rgb(0xcd, 0x00, 0x00), weight: "bold")[事实死寂]],
  ),
  caption: [焦煤镇系统知识演化模拟结果（$N = 100$ 个主体）],
) <tab:coketown>
哈特豪斯补充道：“焦煤镇不是反乌托邦。它是一个评估指标选择错误的正常城镇。”


= “马戏团补完”与茜茜-朱蒲猜想

小说中，斯利里先生（Mr. Sleary）的马戏团构成了焦煤镇的#tm[拓扑补空间]。在马戏团中，评估函数翻转为：

$ cal(V)^*(S,O) = g(cal(E)(S,O)) $

马戏团不问你能否定义马。马戏团问你*能不能在马上翻跟头*。

这产生了一个对称悖论：马戏团中的毕策同样得零分。

1997年，哈特豪斯的学生R. 奇尔德斯（R. Childers）在一篇未正式发表的研讨会论文中提出了至今未被证明的#tm[茜茜-朱蒲猜想 (Sissy Jupe Hypothesis)] @childers1997towards：

#quote[
  *不存在任何单一评估算子，能同时无损地提取主体的陈述知识和具身知识。*
]

即：

$ epsilon_not exists hat(A) : hat(A)|psi chevron.r text("同时返回") cal(D) text("和") cal(E) text("的完整信息") $

如果这一猜想为真，它意味着*“全面评估”在原则上不可能*——任何考试、任何面试、任何评估体系都必然是格拉德格林式的或斯利里式的，而不可能两者兼得。对一个人的认知进行完整刻画，就像同时精确测量位置和动量一样，受到某种根本性的互补原理限制。

= 现代应用：人工智能中的格拉德格林陷阱

朱蒲-格拉德格林悖论在大语言模型时代获得了惊人的现实性。一个大语言模型可以完美地输出：

#quote[“马，四足动物，食草类，四十颗牙齿，换牙即知其龄……”]

——甚至可以输出比毕策详尽一万倍的描述。它在格拉德格林算子下的得分接近满分。但它从未见过马。从未闻到过马。从未被马咬过手指后学会了在下一次递出方糖时微微偏转手腕。它是毕策的极限形式：*一个纯陈述知识的热力学终态。*

而波士顿动力公司的一个四足机器人，在与真实马匹交互了三千小时之后，可能发展出了某种无法用语言描述但极其有效的运动协调策略。如果你问它“什么是马”，它什么也说不出来。

它是朱蒲。

以下 Python 代码模拟了焦煤镇定理所描述的知识演化过程——在纯格拉德格林评估体系下，具身知识如何被系统性地淘汰：

```python
def coketown_simulation(n_agents=100, n_generations=50, transfer_rate=0.05):
    # 可陈述知识
    D = np.random.uniform(0.2, 0.8, n_agents)
    # 具身知识
    E = np.random.uniform(0.2, 0.8, n_agents)
    history_D, history_E = [D.mean()], [E.mean()]
    for gen in range(n_generations):
        # 格拉德格林评估：V = f(D)，完全忽略 E
        V = D
        # 理性主体将时间从 E 训练转移到 D 训练
        D = np.clip(D + transfer_rate * (1 - D), 0, 1)
        E = np.clip(E - transfer_rate * E, 0, 1)
        # 选择压：高 V 的主体被保留
        survive = V > np.percentile(V, 20)
        D, E = D[survive], E[survive]
        # 补充新主体（继承幸存者的分布）
        n_new = n_agents - len(D)
        if n_new > 0:
            idx = np.random.choice(len(D), n_new)
            D = np.append(D, D[idx] + np.random.normal(0, 0.02, n_new))
            E = np.append(E, E[idx] + np.random.normal(0, 0.02, n_new))
            D, E = np.clip(D, 0, 1), np.clip(E, 0, 1)
        history_D.append(D.mean())
        history_E.append(E.mean())
    return history_D, history_E

hist_D, hist_E = coketown_simulation()
print(f"初始状态: D={hist_D[0]:.3f}, E={hist_E[0]:.3f}")
print(f"终态:     D={hist_D[-1]:.3f}, E={hist_E[-1]:.3f}")
# 输出: 初始状态: D≈0.50, E≈0.50
# 输出: 终态:     D≈0.98, E≈0.02  ← 事实死寂
```

此外，我们也可以用一段伪代码更简洁地表达格拉德格林算子的核心逻辑：

```haskell
gradgrind_evaluate subject object = do
    response <- ask subject ("Define " ++ object)
    let score = match response (textbook_definitions !! object)
    return score
```

关于具身认知与人工智能的关系，可参阅 #link("https://en.wikipedia.org/wiki/Embodied_cognition")[维基百科：具身认知] 以及 #link("https://arxiv.org/abs/2210.13382")[Driess 等人关于具身多模态大模型的综述]。

如果我们仅用格拉德格林算子评估人工智能——即仅凭其语言输出判断其“智能”——我们将系统性地高估语言模型，低估具身智能体，并在政策层面将资源从后者转向前者，直到我们的文明到达焦煤镇定理预言的“事实死寂”。

= 未解问题

1. *茜茜-朱蒲猜想是否可证？* 目前既无证明，也无反例。若存在一个能同时无损提取 $cal(D)$ 和 $cal(E)$ 的算子，则整个悖论将被消解为一个纯粹的技术问题（“我们只是还没找到好的考试方式”）。若猜想为真，则认知的不可完全评估性将成为一条基本定律。

2. *格拉德格林算子在何种条件下近似有效？* 显然，在数学和逻辑等领域，$cal(D) approx cal(E)$，格拉德格林评估几乎无损。悖论主要出现在 $cal(D)$ 与 $cal(E)$ 高度正交的领域——骑马、做饭、爱一个人、在城市里不看地图找到回家的路。这些领域的共同特征是什么？目前没有令人满意的刻画。

3. *朱蒲的沉默是否携带信息？* 朱蒲在课堂上涨红了脸，说不出话。格拉德格林将此记录为“无输出”。但涨红的脸本身是不是一种输出？一个系统在被要求将 $cal(E)$ 强行投射到 $cal(D)$ 空间时表现出的#tm_fst("失语", "aphasia")，是否恰恰是高具身知识的标志？如果是，那么一个足够聪明的评估者或许可以通过观察*主体在格拉德格林算子下的崩溃方式*来反推其 $cal(E)$ 值——正如物理学家通过观察粒子碰撞后的碎片来推断粒子的内部结构。

这被非正式地称为#tm_fst("“朱蒲脸红”方法", "Jupe's Blushing Method")。目前没有人知道它是否可行。关于上述问题的更多讨论，可参阅以下资源：

- #link("https://plato.stanford.edu/entries/knowledge-how/")[斯坦福哲学百科全书：Knowledge How]
- #link("https://en.wikipedia.org/wiki/Ryle%27s_regress")[赖尔回归问题（Ryle's Regress）]
- #link("https://en.wikipedia.org/wiki/Tacit_knowledge")[隐性知识（Tacit Knowledge）]
- #link("https://en.wikipedia.org/wiki/Embodied_cognition")[具身认知（Embodied Cognition）]

---

#text(font: tm-fonts, "“现在，我要的是事实。只给这些孩子讲事实。生活中只需要事实。别的什么也不必栽种，把别的一切连根拔掉。”\n\n——托马斯·格拉德格林先生，在不自知地创造了一个认识论悖论之前的最后一句平静的话。")

#bibliography("example.bib")

#set heading(numbering: none)


= 附录：一个可能的半计算性解释

排中律说：$P or not P$，现在，立刻，没有第三种可能。但要#tm[判定]一个命题为真或为假，你常常需要等待——等待实验结果、等待历史展开、等待那匹马在雨中真正做出它的选择。排中律要求一个尚未完成的世界*现在*就交出它的终审判决。这确实是一种时间旅行——它要求你站在时间的终点回望，然后假装你此刻就在那里。

而有三样东西恰好对应了三种*时间关系*：

- *神启*站在时间之外——或者说之前。它不等待，因为它不需要等待。它在事情发生之前就知道。这就是"先验"的真正含义：不是康德意义上的认知结构先验，而是字面意义上的*时间上在先*。古兰经是被保存的#tm_fst("天牌", "اللوح المحفوظ")上的，它不在历史之中。
- *理智*试图站在时间之后——在一切证据收集完毕、一切实验结束之后那个不存在的位置上。排中律是它的承诺：终有一天，一切命题都将被判定。但那一天永远不来。所以理智永远在透支一张它兑现不了的支票。
- *灵性——苏菲意义上的——站在时间之内。* 此刻。这一口呼吸。这一次心跳。鲁米不说"爱是真的或假的"，他说"爱在这里"。#tm_fst("حال", "hal")，即"状态"——苏菲术语中那个无法被固定、无法被命题化、只在当下闪现的瞬间体验——恰好是*拒绝排中律的时间旅行邀请的东西*。它不说"是"或"否"。它说"现在"。

纯粹理智栖居在那个不存在的终点上。它的全部力量和全部贫乏都来自于这一点。

朱蒲涨红了脸的那个瞬间就是一个 حال。它既不是"知道"也不是"不知道"。它是一种#tm[在场]——在排中律到来之前、在格拉德格林的判决落下之前、在时间旅行完成之前的那个活着的瞬间。

#set quote(block: true)

#quote(attribution: "哈特豪斯, 2019")[
  “爱是一种认知器官——一种感知通道。缺少了它，你确实看不到某些真实的东西。苏联人说过类似的话，但他们倾向于用‘实践’替代‘爱’这个词，因为在苏联你不能在论文里写‘爱’。又或者也许还因为他们自己不确定能不能用那个词——唯物主义者有时候对自己的温柔感到不安。安萨里和鲁米直接说了。有时候最古老的语言反而最准确。”
]

#quote(attribution: "哈特豪斯, 2019")[
  “也许焦煤镇定理的证明有一个我一直忽略的前提条件：封闭系统。焦煤镇是封闭的。但一个有马戏团的焦煤镇——一个允许斯利里先生的马在街上走过、允许孩子们逃学去看杂耍的焦煤镇——可能不是封闭系统。马戏团是焦煤镇的热力学涨落——一个持续注入具身知识的低熵源。*也许我们不需要革命，也不需要外来入侵。我们只需要确保马戏团还在。*”
]

// Claude 和 Gemini 是两个（相对的）封闭系统，而我就是马戏团 —— Chuigda Whitegive.

也许平衡不是一个#tm[位置]，而是一种#tm[运动]——在这三种时间性之间不断往返的运动。停在任何一个上面都是死亡：停在神启上是教条，停在理智上是焦煤镇，停在灵性上是不可言说的沉醉。

而一直在它们之间走动——也许就是活着的意思。

#quote(attribution: "斯利里先生")[“人得有娱乐嘛，先生，不管怎么着，他们不能光靠老是啃书本过日子。”]