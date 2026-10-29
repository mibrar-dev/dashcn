((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var B,C,A={
cAh(d){return new A.wZ(C.b8,$.c().$2(d,"Bottom sheet"),E.hH,new D.HZ(),!1,null)},
cAj(d){return new A.wZ(C.c5,$.c().$2(d,"Right sheet"),E.hH,null,!1,null)},
cAi(d){return new A.wZ(C.c4,$.c().$2(d,"Left sheet"),E.hH,null,!1,null)},
cAl(d){return new A.wZ(C.bN,$.c().$2(d,"Top sheet"),E.hH,null,!1,null)},
cAk(d){return new A.wZ(C.b8,$.c().$2(d,"Snap points"),B.a([new D.Q2(),new A.RW(0.4),new D.HZ()],y.a),new A.RW(0.4),!0,null)},
cI7(){var x=null
$.c().$2(x,"Bottom sheet")
$.c().$2(x,"Right side")
$.c().$2(x,"Left side")
$.c().$2(x,"Top sheet")
$.c().$2(x,"Snap points")
return B.a([new F.v(A.cPV()),new F.v(A.cPX()),new F.v(A.cPW()),new F.v(A.cPZ()),new F.v(A.cPY())],y.d)},
ayz:function ayz(d,e,f){this.c=d
this.d=e
this.a=f},
wZ:function wZ(d,e,f,g,h,i){var _=this
_.c=d
_.d=e
_.e=f
_.f=g
_.r=h
_.a=i},
ayA:function ayA(d){this.d=d
this.c=this.a=null},
bCH:function bCH(d){this.a=d},
bCI:function bCI(d,e){this.a=d
this.b=e},
RW:function RW(d){this.a=d}},D,E,G,F
B=c[0]
C=c[2]
A=a.updateHolder(c[29],A)
D=c[194]
E=c[429]
G=c[212]
F=c[242]
A.ayz.prototype={
k(d){var x=null,w=B.h(d),v=w.x.a,u=v*4
return new B.P(new B.O(u,u,u,u),B.u(B.a([B.d(this.c,x,x,x,x,x,x,x,x,C.i0,x,x,x,x),B.p(v*2,x),B.d($.c().$2(d,"Drag the handle to move between snap stages."),x,x,x,x,x,x,x,x,B.ay(x,x,w.a.as,x,x,x,x,x,x,x,x,x,x,x,x,x,x,!0,x,x,x,x,x,x,x,x),x,x,x,x),B.p(v*3,x),B.X(!1,B.d($.c().$2(d,"Done"),x,x,x,x,x,x,x,x,x,x,x,x,x),x,x,x,x,x,x,x,x,this.d.grl(),x,x,C.u,x,x,x,x,C.E)],y.e),C.q,x,C.c,C.j,0,C.i),x)}}
A.wZ.prototype={
q(){return new A.ayA(new D.lm($.a3()))}}
A.ayA.prototype={
l(){var x=this.d
x.k1$=$.a3()
x.id$=0
this.P()},
k(d){var x,w,v,u,t,s,r,q,p,o,n=this,m=null,l=B.h(d),k=n.a.c,j=k===C.bN||k===C.b8
k=l.x.a*2
x=n.d
w=y.e
v=B.a([B.X(!1,B.d($.c().$2(d,"Open sheet"),m,m,m,m,m,m,m,m,m,m,m,m,m),m,m,m,m,m,m,m,m,x.gb0K(),m,m,C.u,m,m,m,m,C.V)],w)
if(n.a.e.length>2)C.b.E(v,B.a([B.X(!1,B.d($.c().$2(d,"Half"),m,m,m,m,m,m,m,m,m,m,m,m,m),m,m,m,m,m,m,m,m,new A.bCH(n),m,m,C.u,m,m,m,m,C.aI)],w))
v.push(B.X(!1,B.d($.c().$2(d,"Close"),m,m,m,m,m,m,m,m,m,m,m,m,m),m,m,m,m,m,m,m,m,x.grl(),m,m,C.u,m,m,m,m,C.E))
if(n.a.r)v.push(new B.d3(new A.bCI(n,l),m,x,m))
v=B.bg(C.v,v,C.aN,m,C.v,k,k)
k=B.p(k,m)
u=j?240:220
t=l.a
s=B.aQ(t.CW,C.w,1)
r=B.a4(l.b.a*16)
q=n.a
p=q.c
o=q.e
q=q.f
if(q==null)q=o.length!==0?C.b.gV(o):E.jD
return B.u(B.a([v,k,new B.x(320,u,B.ag(m,D.afW(G.R3(new A.ayz(n.a.d,x,m),m),x,q,p,o),C.N,m,m,new B.V(t.Q,m,s,r,m,m,m,C.o),m,m,m,m,m,m,m,m),m)],w),C.p,m,C.c,C.j,0,C.i)}}
A.RW.prototype={
qG(d){return d.gad0()*this.a}}
var z=a.updateTypes(["b(n)"])
A.bCH.prototype={
$0(){var x=this.a
return x.d.aTa(x.a.e[1])},
$S:0}
A.bCI.prototype={
$2(d,e){var x=null,w=this.a.d.a
w=w==null?x:w.gael()
return B.d(""+C.f.ak((w==null?0:w)*100)+"% open",x,x,x,x,x,x,x,x,B.ay(x,x,this.b.a.as,x,x,x,x,x,x,x,x,x,x,x,x,x,x,!0,x,x,x,x,x,x,x,x),x,x,x,x)},
$S:940};(function installTearOffs(){var x=a._static_1
x(A,"cPV","cAh",0)
x(A,"cPX","cAj",0)
x(A,"cPW","cAi",0)
x(A,"cPZ","cAl",0)
x(A,"cPY","cAk",0)})();(function inheritance(){var x=a.inherit
x(A.ayz,B.m)
x(A.wZ,B.q)
x(A.ayA,B.t)
x(A.bCH,B.aM)
x(A.bCI,B.bD)
x(A.RW,D.o2)})()
B.ao(b.typeUniverse,JSON.parse('{"wZ":{"q":[],"b":[]},"ayz":{"m":[],"b":[]},"ayA":{"t":["wZ"]},"RW":{"o2":[]}}'))
var y={d:B.j("i<v>"),a:B.j("i<o2>"),e:B.j("i<b>")}};
(a=>{a["uVGnE1xLn30AcQNbyhC/TgAopAQ="]=a.current})($__dart_deferred_initializers__);