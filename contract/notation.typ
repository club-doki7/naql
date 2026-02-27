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

#let subst(e, x, e_1) = $#e thin [ #x := #e_1 ]$

$
  subst(e, x, e_1)
$

值化函数

$
  [| e |] = v
$

小步求值

$
  e --> e'
$

大步求值

#let evalto = sym.arrow.b.double

$
  e evalto v
$

类型判断

$
  e : tau wide Gamma tack e : tau
$

双向类型检查 - 综合

#let inferto = $#math.op(sym.colon, limits: false)_arrow.t$

$
  e inferto tau
$

双向类型检查 - 判定

#let checkas = $#math.op(sym.colon, limits: false)_arrow.b$

$
  e checkas tau
$

公式编号

#let sub-refl = $[prec.eq"-Refl"]$

$
  () / (T prec.eq T) wide #(sub-refl)
$
