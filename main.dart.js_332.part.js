((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,C,F,B={
c_W(d,e,f,g,h,i,j){return new B.BP(d,e,h,i,f,j,g)},
BP:function BP(d,e,f,g,h,i,j){var _=this
_.d=d
_.e=e
_.r=f
_.w=g
_.Q=h
_.ax=i
_.a=j},
apA:function apA(){var _=this
_.d=!1
_.c=_.a=_.e=null},
bhO:function bhO(d){this.a=d},
bhP:function bhP(d){this.a=d},
bhN:function bhN(d){this.a=d},
bhQ:function bhQ(){},
bhM:function bhM(d,e){this.a=d
this.b=e},
bhL:function bhL(d,e){this.a=d
this.b=e},
bhK:function bhK(d){this.a=d},
nr:function nr(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s){var _=this
_.e=d
_.f=e
_.r=f
_.w=g
_.x=h
_.y=i
_.z=j
_.Q=k
_.as=l
_.at=m
_.ax=n
_.ay=o
_.a=p
_.b=q
_.c=r
_.d=s},
cug(d){return D.Z5},
cui(d){return D.Z0},
cuf(d){var x=null
return new A.bi(C.D,x,x,new A.w(360,x,B.c_W(C.b4,D.cgT,new B.bNM(),x,x,x,D.a3b),x),x)},
cuh(d){return D.cq7},
cuj(d){return D.cq8},
cFL(){var x=null
$.c().$2(x,"Default")
$.c().$2(x,"With actions")
$.c().$2(x,"Long lines")
$.c().$2(x,"Languages")
$.c().$2(x,"Customized")
return A.a([new E.v(B.cMU()),new E.v(B.cMX()),new E.v(B.cMW()),new E.v(B.cMV()),new E.v(B.cMT())],y.j)},
ZM:function ZM(d,e,f){this.c=d
this.d=e
this.a=f},
ZN:function ZN(d){this.a=d},
apz:function apz(){this.d=0
this.c=this.a=null},
bhJ:function bhJ(d,e){this.a=d
this.b=e},
bhH:function bhH(d,e){this.a=d
this.b=e},
bhI:function bhI(d,e,f){this.a=d
this.b=e
this.c=f},
ZO:function ZO(d){this.a=d},
apB:function apB(){this.d="idle"
this.c=this.a=null},
bhT:function bhT(d){this.a=d},
bhS:function bhS(d){this.a=d},
bhU:function bhU(d){this.a=d},
bhR:function bhR(d){this.a=d},
bNM:function bNM(){},
bNL:function bNL(d,e){this.a=d
this.b=e},
abf:function abf(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},
cTT(d){var x,w,v,u,t=C.d.rY(d),s=A.ab("^(?:```+|~~~+)\\s*([A-Za-z][\\w+-]*)",!0,!1,!1,!1).h9(t)
if(s!=null){x=A.aEh(s.b[1])
if(x!=null)return x}w=A.ab("^import\\s+['\"]package:flutter/",!0,!1,!1,!1)
v=!0
if(!w.b.test(t)){w=A.ab("^import\\s+['\"]dart:",!0,!1,!1,!1)
if(!w.b.test(t)){w=A.ab("^\\s*void\\s+main\\s*\\(",!0,!1,!0,!1)
w=w.b.test(t)}else w=v}else w=v
if(w)return C.nj
w=A.ab("^#!\\S*\\b(?:ba)?sh\\b|^#!\\S*\\bzsh\\b",!0,!1,!1,!1)
v=!0
if(!w.b.test(t)){w=A.ab("^\\$\\s+\\w+",!0,!1,!1,!1)
if(!w.b.test(t)){w=A.ab("^(?:flutter|dart|npm|npx|pnpm|yarn|cargo|git|brew|docker|kubectl)\\s+[a-z]",!0,!1,!1,!1)
w=w.b.test(t)}else w=v}else w=v
if(w)return C.nk
w=A.ab("^<!DOCTYPE html|^<html[\\s>]",!1,!1,!1,!1)
v=!0
if(!w.b.test(t)){w=A.ab("^<\\?xml",!0,!1,!1,!1)
if(!w.b.test(t)){w=A.ab("^<([A-Za-z][\\w-]*)(\\s+[^>]*)?>[\\s\\S]*<\\/\\1>",!1,!1,!1,!1)
w=w.b.test(t)}else w=v}else w=v
if(w)return C.Wp
w=A.ab("^import\\s+(?:UIKit|Foundation|SwiftUI)\\b",!0,!1,!1,!1)
if(w.b.test(t))return C.Wi
w=A.ab("^\\s*def\\s+\\w+\\s*\\([^)]*\\)\\s*:",!0,!1,!1,!1)
if(!w.b.test(t)){w=A.ab("^\\s*(?:async\\s+)?def\\s+\\w+\\s*\\(.*\\)\\s*(?:->\\s*\\w+\\s*)?:",!0,!1,!1,!1)
w=w.b.test(t)}else w=!0
if(w)return C.Wm
w=A.ab("^\\s*(?:pub\\s+)?(?:fun|val|var)\\s+\\w+",!0,!1,!1,!1)
if(w.b.test(t)&&C.d.B(t,A.ab("\\b(?:Unit|Int|String|Boolean)\\b",!0,!1,!1,!1)))return C.Wh
w=A.ab("^\\s*(?:const|let|var|function)\\s+\\w+",!0,!1,!1,!1)
v=!0
if(!w.b.test(t)){w=A.ab("=>",!0,!1,!1,!1)
if(!w.b.test(t)){w=A.ab("^\\s*console\\.log\\(",!0,!1,!0,!1)
w=w.b.test(t)}else w=v}else w=v
if(w)return C.yG
u=C.d.ar(t)
if(u.length===0)return null
if(C.d.ac(u,"{")||C.d.ac(u,"[")){w=A.ab('^[\\s{}\\[\\]",:0-9aeflnrtyA-FLNR\\.\\-+]*$',!0,!1,!1,!1)
w=w.b.test(u)}else w=!1
if(w)return C.Wn
w=A.ab("^---\\s*$",!0,!1,!0,!1)
if(!w.b.test(t)){w=A.ab("^[a-zA-Z0-9_-]+:\\s*(?:$|[^\\s])",!0,!1,!0,!1)
v=!1
if(w.b.test(t))if(!C.d.B(t,"{"))if(!C.d.B(t,";")){w=A.ab(":\\s",!0,!1,!1,!1)
w=w.b.test(t)}else w=v
else w=v
else w=v}else w=!0
if(w)return C.Wo
return null}},D,E,G
J=c[1]
A=c[0]
C=c[2]
F=c[184]
B=a.updateHolder(c[98],B)
D=c[342]
E=c[242]
G=c[343]
B.BP.prototype={
q(){return new B.apA()}}
B.apA.prototype={
l(){var x=this.e
if(x!=null)x.ah()
this.O()},
ga3q(){var x=this.a,w=x.e
x=w.c
if(x==null){x=w.d
x=x==null?null:x.Yk()}return x},
HK(d){return this.aAn(d)},
aAn(d){var x=0,w=A.M(y.H),v,u=this,t,s
var $async$HK=A.H(function(e,f){if(e===1)return A.J(f,w)
for(;;)switch(x){case 0:s=u.ga3q()
x=s!=null&&s.length!==0?3:4
break
case 3:x=5
return A.D(A.nq(new A.kn(s)),$async$HK)
case 5:case 4:u.a.toString
if(u.c==null){x=1
break}u.n(new B.bhO(u))
t=u.e
if(t!=null)t.ah()
u.e=A.dp(d,new B.bhP(u))
u.a.toString
case 1:return A.K(v,w)}})
return A.L($async$HK,w)},
k(a6){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d=this,a0=null,a1=A.h(a6),a2=y._,a3=A.aL(a6,D.a3a,new B.bhQ(),d.a.ax,a2,a2),a4=a1.f,a5=a6.S(y.I).w
a2=a3.x
if(a2==null)a2=C.V
x=a1.r
w=A.cb(a2,x.a*a4).C(a5)
a2=a1.Q
v=a2==null
u=A.xo(v?A.b5():a2)
t=28*a4
s=Math.max(0,(((v?A.b5():a2)===C.aK?44:48)-t)/2)
r=t+(u?2*s:0)
a2=d.a
v=a2.w
if(v==null)v=a3.y
a2=A.aj(a2.d,y.k)
if(v!==!1)a2.push(d.att(a6,a1,a3,a4,t,s))
if(a2.length===0)q=a0
else{d.a.toString
v=a3.ax
a2=A.Q(d.aPH(a2,a4,v==null?4:v),C.l,a0,C.c,C.j,0,a0)
q=a2}a2=d.a
a2.toString
v=u&&q!=null?r:0
p=Math.max(0,v)
o=C.nQ.aVA(p)
n=a2.e
m=d.ga3q()
if(m!=null){l=A.aEh(d.a.r)
if(l==null)l=B.cTT(m)
if(l!=null){k=a1.d.b.T(a1.a.c)
n=A.kK(A.bc(A.Gs(k,m,a1.gq2(),l),a0,a0,a0,a0,a0,a0,a0,a0,k,a0),a0,a0,a0,a0,a0,a0,a0,a0,a0)}}j=A.jM(F.c9P(n))
d.a.toString
i=A.z3(a6,!1)==null||A.zy(a6)!=null?j:A.ain(j,a0,a0,new A.hQ())
h=A.a5(a1.b.a*16)
a2=a3.e
g=a2==null?a0:a2.C(a1.a)
f=g==null?a0:A.ew(g,a1.as)
a2=a1.a
v=a3.f.C(a2)
v=A.aO(v,C.w,a3.r*a4)
a2=A.a([A.af(a0,A.b6(A.b6(A.dq(i,a0,a0,a0,A.ay(a0,a0,a2.c,a0,a0,a0,a0,a0,a0,a0,a0,a0,a0,a0,a0,a0,a0,!0,a0,a0,a0,a0,a0,a0,a0,a0),a0,a0),a0,w,a0,a0,C.I),a0,a0,a0,a0,C.z),C.n,a0,o,a0,a0,a0,a0,a0,a0,a0,a0,a0)],y.p)
if(q!=null){x=x.b
e=x*a4
if(u)e=Math.max(0,e-s)
a2.push(A.c16(a0,q,e,a0,a5,u?Math.max(0,(p-r)/2):x*a4,a0))}return new A.dR(A.af(a0,A.bV(C.W,a2,C.O,C.eH),C.n,a0,a0,new A.V(f,a0,v,h,a0,a0,a0,C.o),a0,a0,a0,a0,a0,a0,a0,a0),a1.at,h,a0)},
att(d,e,f,g,h,i){var x,w,v,u,t,s,r,q=null,p=this.a
p.toString
x=this.d
w=f.ay
v=new B.bhM(this,w==null?C.m9:w)
p=p.Q
if(p!=null)return p.$3(d,v,x)
if(x){p=f.Q
u=p==null?C.d0:p}else{p=f.z
u=p==null?C.iF:p}if(x){p=f.at
p=p==null?q:p.C(e.a)
t=p}else{p=f.as
p=p==null?q:p.C(e.a)
t=p}if(t==null){p=e.a
t=x?p.w:p.as}s=A.ce(d,C.i2,y.w).w.ax
r=s?C.C:C.ae
h=28*g
p=e.Q
i=Math.max(0,(((p==null?A.b5():p)===C.aK?44:48)-h)/2)
p=x?"Copied":"Copy code"
return A.EQ(A.bb(!0,q,new A.w(h,h,A.cc(q,!1,C.U,A.as(A.GM(A.ao(u,t,new A.ak(x,y.l),q,14*g),r,A.bQY(),q,C.bX,C.bX,new B.bhK(s)),q,q),new A.cP(new B.bhL(e,g)),!1,!0,!0,q,!0,q,q,G.z8,q,q,q,q,v,q,q,q,C.XY,q,q,q,q,q),q),!1,q,q,!1,q,!1,q,q,q,q,q,q,q,q,q,p,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q),i,i)},
aPH(d,e,f){var x,w,v,u=y.p,t=A.a([],u)
for(x=f*e,w=0;w<d.length;++w){v=A.a([],u)
if(w>0)v.push(new A.ci(x,null,null))
v.push(d[w])
C.b.E(t,v)}return t}}
B.nr.prototype={
G(d){var x,w,v,u,t,s,r,q,p=this,o=p.e
if(o==null)o=d.e
x=p.x
if(x==null)x=d.x
w=p.y
if(w==null)w=d.y
v=p.z
if(v==null)v=d.z
u=p.Q
if(u==null)u=d.Q
t=p.as
if(t==null)t=d.as
s=p.at
if(s==null)s=d.at
r=p.ax
if(r==null)r=d.ax
q=p.ay
if(q==null)q=d.ay
return new B.nr(o,p.f,p.r,d.w,x,w,v,u,t,s,r,q,d.a,null,d.c,d.d)},
h(d,e){var x=this
if(e==null)return!1
if(x===e)return!0
return e instanceof B.nr&&J.z(e.e,x.e)&&e.f.h(0,x.f)&&e.r===x.r&&J.z(e.x,x.x)&&e.y==x.y&&J.z(e.z,x.z)&&J.z(e.Q,x.Q)&&J.z(e.as,x.as)&&J.z(e.at,x.at)&&e.ax==x.ax&&J.z(e.ay,x.ay)},
gt(d){var x=this
return A.X(x.a,x.c,x.d,x.e,x.f,x.r,x.w,x.x,x.y,x.z,x.Q,x.as,x.at,x.ax,x.ay,C.a,C.a,C.a,C.a,C.a)}}
B.ZM.prototype={
k(d){var x=null
return A.U(!1,A.d(this.c,x,x,x,x,x,x,x,x,x,x,x,x,x),x,x,x,x,x,x,x,x,this.d,x,x,C.u,x,x,x,x,C.X)}}
B.ZN.prototype={
q(){return new B.apz()}}
B.apz.prototype={
k(d){var x,w,v,u,t,s,r,q,p,o,n,m=this,l=null,k=A.h(d),j=$.cgH(),i=j[m.d],h=y.p,g=A.a([],h)
for(x=k.a,w=x.as,v=k.x.a,u=v*2,t=y.a,s=k.d.d,x=x.x,r=0;r<6;++r){q=A.a([],h)
if(r>0)q.push(new A.ci(v,l,l))
p=j[r]
o=r===m.d
n=o?x:w
q.push(A.cc(l,!1,C.U,new A.a4(p.b,l,s.eV(n,o?C.R:C.a1),l,l,l,l,l,l,l,l,l,l,l,l,l),new A.cP(new B.bhI(m,r,k)),!1,!0,!0,l,!0,l,l,l,l,l,l,l,new B.bhJ(m,r),l,l,l,new A.bH(new A.O(u,v,u,v),t),l,l,l,l,l))
C.b.E(g,q)}j=i.c
return A.u(A.a([A.b6(A.Q(g,C.l,l,C.c,C.j,0,l),l,l,l,l,C.I),A.o(u,l),new A.w(380,l,B.c_W(C.b4,A.d(i.a,l,l,l,l,l,l,l,l,l,l,l,l,l),l,new A.ak(j,y.O),j,l,l),l)],h),C.l,l,C.c,C.j,0,C.h)}}
B.ZO.prototype={
q(){return new B.apB()}}
B.apB.prototype={
k(d){var x=null,w=A.h(d),v=y.p
return A.u(A.a([new A.w(320,x,B.c_W(A.a([new B.ZM($.c().$2(d,"Copy"),new B.bhT(this),x),new B.ZM("Run",new B.bhU(this),x)],v),A.d("flutter run -d chrome",x,x,x,x,x,x,x,x,x,x,x,x,x),x,x,x,!1,x),x),A.o(w.x.a*2,x),A.d(this.d,x,x,x,x,x,x,x,x,A.ay(x,x,A.h(d).a.as,x,x,x,x,x,x,x,x,12,x,x,x,x,x,!0,x,x,x,x,x,x,x,x),x,x,x,x)],v),C.l,x,C.c,C.j,0,C.h)}}
B.abf.prototype={
aiu(d){var x=this
return new A.fW(x.a*d,x.b*d,x.c*d,x.d*d)},
$iaLK:1}
var z=a.updateTypes(["b(n)","nr(nr)"])
B.bhO.prototype={
$0(){return this.a.d=!0},
$S:0}
B.bhP.prototype={
$0(){var x=this.a
if(x.c!=null){x.n(new B.bhN(x))
x.a.toString}},
$S:0}
B.bhN.prototype={
$0(){return this.a.d=!1},
$S:0}
B.bhQ.prototype={
$1(d){return d},
$S:z+1}
B.bhM.prototype={
$0(){return this.a.HK(this.b)},
$S:0}
B.bhL.prototype={
$1(d){var x=null,w=d.B(0,C.bd)||d.B(0,C.d9),v=this.a,u=v.a,t=w?u.Q:u.d.aG(0.8)
u=w?x:A.aO(u.CW.aG(0.5),C.w,this.b)
return new A.V(t,x,u,A.a5(Math.max(0,v.b.a*16-4)),x,x,x,C.o)},
$S:22}
B.bhK.prototype={
$2(d,e){var x,w=new A.f_(e,!1,d,null)
if(this.a)return w
x=y.t
return A.Kr(C.D,w,null,new A.d0(e,new A.bY(0.8,1,x),x.i("d0<cJ.T>")))},
$S:132}
B.bhJ.prototype={
$0(){var x=this.a
return x.n(new B.bhH(x,this.b))},
$S:0}
B.bhH.prototype={
$0(){return this.a.d=this.b},
$S:0}
B.bhI.prototype={
$1(d){var x,w=this,v=null
if(w.b===w.a.d)x=w.c.a.w
else x=d.B(0,C.bd)?w.c.a.Q:v
return new A.V(x,v,v,A.a5(Math.max(0,w.c.b.a*16-4)),v,v,v,C.o)},
$S:22}
B.bhT.prototype={
$0(){var x=this.a
return x.n(new B.bhS(x))},
$S:0}
B.bhS.prototype={
$0(){return this.a.d="copied"},
$S:0}
B.bhU.prototype={
$0(){var x=this.a
return x.n(new B.bhR(x))},
$S:0}
B.bhR.prototype={
$0(){return this.a.d="running"},
$S:0}
B.bNM.prototype={
$3(d,e,f){var x,w,v=null,u=A.h(d),t=u.x.a,s=t*2,r=f?C.d0:C.iF,q=u.a
r=A.ao(r,f?q.w:q.c,v,v,13)
x=A.o(t,v)
w=f?$.c().$2(d,"Copied!"):$.c().$2(d,"Copy")
q=f?q.w:q.c
return A.cc(v,!1,C.U,A.Q(A.a([r,x,A.d(w,v,v,v,v,v,v,v,v,u.d.d.UV(q,12,C.am),v,v,v,v)],y.p),C.l,v,C.c,C.j,0,v),new A.cP(new B.bNL(f,u)),!1,!0,!0,v,!0,v,v,v,v,v,v,v,e,v,v,v,new A.bH(new A.O(s,t,s,t),y.a),v,v,v,v,v)},
$S:894}
B.bNL.prototype={
$1(d){var x=null,w=this.b,v=w.a
v=this.a?v.w.aG(0.2):v.Q
return new A.V(v,x,x,A.a5(Math.max(0,w.b.a*16-4)),x,x,x,C.o)},
$S:22};(function installTearOffs(){var x=a._static_1
x(B,"cMU","cug",0)
x(B,"cMW","cui",0)
x(B,"cMT","cuf",0)
x(B,"cMV","cuh",0)
x(B,"cMX","cuj",0)})();(function inheritance(){var x=a.inheritMany,w=a.inherit
x(A.q,[B.BP,B.ZN,B.ZO])
x(A.t,[B.apA,B.apz,B.apB])
x(A.aN,[B.bhO,B.bhP,B.bhN,B.bhM,B.bhJ,B.bhH,B.bhT,B.bhS,B.bhU,B.bhR])
x(A.ax,[B.bhQ,B.bhL,B.bhI,B.bNM,B.bNL])
w(B.bhK,A.bF)
w(B.nr,A.av)
w(B.ZM,A.m)
w(B.abf,A.fW)})()
A.ap(b.typeUniverse,JSON.parse('{"BP":{"q":[],"b":[]},"apA":{"t":["BP"]},"nr":{"av":[]},"ZN":{"q":[],"b":[]},"ZO":{"q":[],"b":[]},"ZM":{"m":[],"b":[]},"apz":{"t":["ZN"]},"apB":{"t":["ZO"]},"abf":{"aLK":[],"et":[]}}'))
var y=(function rtii(){var x=A.j
return{_:x("nr"),I:x("dr"),j:x("i<v>"),p:x("i<b>"),w:x("jD"),t:x("bY<G>"),O:x("ak<p>"),l:x("ak<E>"),k:x("b"),a:x("bH<et>"),H:x("~")}})();(function constants(){D.ci7=new A.a4('void main() { runApp(const MyApp(home: Center(child: Text("long line scrolls horizontally inside code block")))); }',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)
D.a3d=new B.BP(C.b4,D.ci7,null,null,null,null,null)
D.ccr=new A.w(320,null,D.a3d,null)
D.Z0=new A.bi(C.D,null,null,D.ccr,null)
D.chl=new A.a4('const greeting = "hello";',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)
D.a3c=new B.BP(C.b4,D.chl,null,null,null,null,null)
D.Z5=new A.bi(C.D,null,null,D.a3c,null)
D.aox=new B.abf(1,1,3.5,1)
D.a3a=new B.nr(C.dx,C.aD,1,null,D.aox,!0,C.iF,C.d0,C.bG,C.aW,4,C.m9,null,null,null,null)
D.a3b=new B.nr(null,C.aW,1.5,null,null,null,null,null,null,null,null,null,null,null,null,null)
D.cgT=new A.a4("final custom = CodeSnippetCustomized();",null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)
D.cq7=new B.ZN(null)
D.cq8=new B.ZO(null)})();(function lazyInitializers(){var x=a.lazyFinal
x($,"cWY","cgH",()=>A.a([new A.x3("void main() {\n  runApp(MyApp());\n}",A.a_(null,"Dart"),"dart"),new A.x3('{\n  "name": "dashcn",\n  "version": "1.0.0",\n  "private": true\n}',"JSON","json"),new A.x3("name: dashcn\nversion: 1.0.0\nenvironment:\n  sdk: ^3.0.0","YAML","yaml"),new A.x3("flutter pub add dashcn\ndashcn add code_snippet",A.a_(null,"Shell"),"bash"),new A.x3("interface User {\n  id: string;\n  name: string;\n}","TypeScript","ts"),new A.x3('<div class="card">\n  <span id="title">Hello</span>\n</div>',"HTML","html")],A.j("i<+code,label,lang(p,p,p)>")))})()};
(a=>{a["6Fssc+heQkPNhDUTUDF+rq0099Y="]=a.current})($__dart_deferred_initializers__);