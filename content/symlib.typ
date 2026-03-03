#let subst(e, x, e_1) = $#e thin [ #x := #e_1 ]$
#let denote(e) = $[| #e |]$
#let stepto = sym.arrow.r.long
#let stepclj = $arrow.r.long^*$
#let evalto = sym.arrow.b.double
#let inferto = $#math.op(sym.colon, limits: false)_arrow.t$
#let checkas = $#math.op(sym.colon, limits: false)_arrow.b$
#let csharp = [C#sym.sharp]
#let lambda = sym.lambda