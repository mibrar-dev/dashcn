((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var B,C,A={
cBG(d){return new A.x6(C.b7,$.c().$2(d,"Bottom sheet"),E.hJ,new D.I7(),!1,null)},
cBI(d){return new A.x6(C.c7,$.c().$2(d,"Right sheet"),E.hJ,null,!1,null)},
cBH(d){return new A.x6(C.c6,$.c().$2(d,"Left sheet"),E.hJ,null,!1,null)},
cBK(d){return new A.x6(C.bL,$.c().$2(d,"Top sheet"),E.hJ,null,!1,null)},
cBJ(d){return new A.x6(C.b7,$.c().$2(d,"Snap points"),B.a([new D.Q9(),new A.S_(0.4),new D.I7()],y.a),new A.S_(0.4),!0,null)},
cJy(){var x=null
$.c().$2(x,"Bottom sheet")
$.c().$2(x,"Right side")
$.c().$2(x,"Left side")
$.c().$2(x,"Top sheet")
$.c().$2(x,"Snap points")
return B.a([new F.v(A.cRn()),new F.v(A.cRp()),new F.v(A.cRo()),new F.v(A.cRr()),new F.v(A.cRq())],y.d)},
ayO:function ayO(d,e,f){this.c=d
this.d=e
this.a=f},
x6:function x6(d,e,f,g,h,i){var _=this
_.c=d
_.d=e
_.e=f
_.f=g
_.r=h
_.a=i},
ayP:function ayP(d){this.d=d
this.c=this.a=null},
bDJ:function bDJ(d){this.a=d},
bDK:function bDK(d,e){this.a=d
this.b=e},
S_:function S_(d){this.a=d}},D,E,G,H,F
B=c[0]
C=c[2]
A=a.updateHolder(c[29],A)
D=c[194]
E=c[429]
G=c[212]
H=c[369]
F=c[242]
A.ayO.prototype={
k(d){var x=null,w=B.h(d),v=w.x.a,u=v*4
return new B.P(new B.O(u,u,u,u),B.u(B.a([B.d(this.c,x,x,x,x,x,x,x,x,H.l0,x,x,x,x),B.o(v*2,x),B.d($.c().$2(d,"Drag the handle to move between snap stages."),x,x,x,x,x,x,x,x,B.ay(x,x,w.a.as,x,x,x,x,x,x,x,x,x,x,x,x,x,x,!0,x,x,x,x,x,x,x,x),x,x,x,x),B.o(v*3,x),B.U(!1,B.d($.c().$2(d,"Done"),x,x,x,x,x,x,x,x,x,x,x,x,x),x,x,x,x,x,x,x,x,this.d.grm(),x,x,C.u,x,x,x,x,C.F)],y.e),C.q,x,C.c,C.j,0,C.h),x)}}
A.x6.prototype={
q(){return new A.ayP(new D.lo($.a3()))}}
A.ayP.prototype={
l(){var x=this.d
x.k1$=$.a3()
x.id$=0
this.O()},
k(d){var x,w,v,u,t,s,r,q,p,o,n=this,m=null,l=B.h(d),k=n.a.c,j=k===C.bL||k===C.b7
k=l.x.a*2
x=n.d
w=y.e
v=B.a([B.U(!1,B.d($.c().$2(d,"Open sheet"),m,m,m,m,m,m,m,m,m,m,m,m,m),m,m,m,m,m,m,m,m,x.gb13(),m,m,C.u,m,m,m,m,C.T)],w)
if(n.a.e.length>2)C.b.E(v,B.a([B.U(!1,B.d($.c().$2(d,"Half"),m,m,m,m,m,m,m,m,m,m,m,m,m),m,m,m,m,m,m,m,m,new A.bDJ(n),m,m,C.u,m,m,m,m,C.aG)],w))
v.push(B.U(!1,B.d($.c().$2(d,"Close"),m,m,m,m,m,m,m,m,m,m,m,m,m),m,m,m,m,m,m,m,m,x.grm(),m,m,C.u,m,m,m,m,C.F))
if(n.a.r)v.push(new B.cZ(new A.bDK(n,l),m,x,m))
v=B.bd(C.v,v,C.aN,m,C.v,k,k)
k=B.o(k,m)
u=j?240:220
t=l.a
s=B.aO(t.CW,C.w,1)
r=B.a5(l.b.a*16)
q=n.a
p=q.c
o=q.e
q=q.f
if(q==null)q=o.length!==0?C.b.gV(o):E.jz
return B.u(B.a([v,k,new B.w(320,u,B.af(m,D.ag0(G.R6(new A.ayO(n.a.d,x,m),m),x,q,p,o),C.O,m,m,new B.V(t.Q,m,s,r,m,m,m,C.o),m,m,m,m,m,m,m,m),m)],w),C.p,m,C.c,C.j,0,C.h)}}
A.S_.prototype={
qH(d){return d.gada()*this.a}}
var z=a.updateTypes(["b(n)"])
A.bDJ.prototype={
$0(){var x=this.a
return x.d.aTk(x.a.e[1])},
$S:0}
A.bDK.prototype={
$2(d,e){var x=null,w=this.a.d.a
w=w==null?x:w.gaeu()
return B.d(""+C.f.ai((w==null?0:w)*100)+"% open",x,x,x,x,x,x,x,x,B.ay(x,x,this.b.a.as,x,x,x,x,x,x,x,x,x,x,x,x,x,x,!0,x,x,x,x,x,x,x,x),x,x,x,x)},
$S:948};(function installTearOffs(){var x=a._static_1
x(A,"cRn","cBG",0)
x(A,"cRp","cBI",0)
x(A,"cRo","cBH",0)
x(A,"cRr","cBK",0)
x(A,"cRq","cBJ",0)})();(function inheritance(){var x=a.inherit
x(A.ayO,B.m)
x(A.x6,B.q)
x(A.ayP,B.t)
x(A.bDJ,B.aN)
x(A.bDK,B.bF)
x(A.S_,D.o5)})()
B.ap(b.typeUniverse,JSON.parse('{"x6":{"q":[],"b":[]},"ayO":{"m":[],"b":[]},"ayP":{"t":["x6"]},"S_":{"o5":[]}}'))
var y={d:B.j("i<v>"),a:B.j("i<o5>"),e:B.j("i<b>")}};
(a=>{a["i2FaLtWwBs3eDlx8U+xJK+q9EMo="]=a.current})($__dart_deferred_initializers__);