#import "symlib.typ": *

#set page(columns: 2)

符号

$
  & e, e'     & wide & "表达式" \
  & tau, tau', rho, rho' & wide & "类型" \
  & x         & wide & "变量" \
  & v         & wide & "值" \
  & E         & wide & "表达式文法" \
  & V         & wide & "值文法" \
  & T         & wide & "类型文法" \
  & epsilon   & wide & "空串" \
  & Gamma, Delta & wide & "语境"
$

#sym.lambda 演算

$
  e  ::= & x & wide & "变量" \
       | & #sym.lambda x. e & wide & lambda "抽象" \
       | & e med e' & wide & "应用"
$

替换

$
  subst(e, x, e_1)
$

值化函数

$
  val("棍母") = bot
$

小步求值


$
  e stepto e'
$

大步求值

$
  e evalto v
$

类型判断

$
  e : tau wide Gamma tack e : tau
$

双向类型检查 - 综合

$
  e inferto tau
$

双向类型检查 - 判定

$
  e checkas tau
$

公式编号

#let sub-refl = $[prec.eq"-Refl"]$

$
  () / (T prec.eq T) wide #(sub-refl)
$
