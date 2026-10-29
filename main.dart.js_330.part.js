((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,C,F,B={
bZI(d,e,f,g,h,i,j){return new B.BH(d,e,h,i,f,j,g)},
BH:function BH(d,e,f,g,h,i,j){var _=this
_.d=d
_.e=e
_.r=f
_.w=g
_.Q=h
_.ax=i
_.a=j},
app:function app(){var _=this
_.d=!1
_.c=_.a=_.e=null},
bhg:function bhg(d){this.a=d},
bhh:function bhh(d){this.a=d},
bhf:function bhf(d){this.a=d},
bhi:function bhi(){},
bhe:function bhe(d,e){this.a=d
this.b=e},
bhd:function bhd(d,e){this.a=d
this.b=e},
bhc:function bhc(d){this.a=d},
np:function np(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s){var _=this
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
ct_(d){return D.Z8},
ct1(d){return D.Z3},
csZ(d){var x=null
return new A.bk(C.C,x,x,new A.x(360,x,B.bZI(C.b5,D.ceM,new B.bMH(),x,x,x,D.a38),x),x)},
ct0(d){return D.cnB},
ct2(d){return D.cnC},
cEl(){var x=null
$.c().$2(x,"Default")
$.c().$2(x,"With actions")
$.c().$2(x,"Long lines")
$.c().$2(x,"Languages")
$.c().$2(x,"Customized")
return A.a([new E.v(B.cLr()),new E.v(B.cLu()),new E.v(B.cLt()),new E.v(B.cLs()),new E.v(B.cLq())],y.j)},
ZN:function ZN(d,e,f){this.c=d
this.d=e
this.a=f},
ZO:function ZO(d){this.a=d},
apo:function apo(){this.d=0
this.c=this.a=null},
bhb:function bhb(d,e){this.a=d
this.b=e},
bh9:function bh9(d,e){this.a=d
this.b=e},
bha:function bha(d,e,f){this.a=d
this.b=e
this.c=f},
ZP:function ZP(d){this.a=d},
apq:function apq(){this.d="idle"
this.c=this.a=null},
bhl:function bhl(d){this.a=d},
bhk:function bhk(d){this.a=d},
bhm:function bhm(d){this.a=d},
bhj:function bhj(d){this.a=d},
bMH:function bMH(){},
bMG:function bMG(d,e){this.a=d
this.b=e},
abb:function abb(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},
cSq(d){var x,w,v,u,t=C.d.rX(d),s=A.ab("^(?:```+|~~~+)\\s*([A-Za-z][\\w+-]*)",!0,!1,!1,!1).ha(t)
if(s!=null){x=A.aE0(s.b[1])
if(x!=null)return x}w=A.ab("^import\\s+['\"]package:flutter/",!0,!1,!1,!1)
v=!0
if(!w.b.test(t)){w=A.ab("^import\\s+['\"]dart:",!0,!1,!1,!1)
if(!w.b.test(t)){w=A.ab("^\\s*void\\s+main\\s*\\(",!0,!1,!0,!1)
w=w.b.test(t)}else w=v}else w=v
if(w)return C.nl
w=A.ab("^#!\\S*\\b(?:ba)?sh\\b|^#!\\S*\\bzsh\\b",!0,!1,!1,!1)
v=!0
if(!w.b.test(t)){w=A.ab("^\\$\\s+\\w+",!0,!1,!1,!1)
if(!w.b.test(t)){w=A.ab("^(?:flutter|dart|npm|npx|pnpm|yarn|cargo|git|brew|docker|kubectl)\\s+[a-z]",!0,!1,!1,!1)
w=w.b.test(t)}else w=v}else w=v
if(w)return C.nm
w=A.ab("^<!DOCTYPE html|^<html[\\s>]",!1,!1,!1,!1)
v=!0
if(!w.b.test(t)){w=A.ab("^<\\?xml",!0,!1,!1,!1)
if(!w.b.test(t)){w=A.ab("^<([A-Za-z][\\w-]*)(\\s+[^>]*)?>[\\s\\S]*<\\/\\1>",!1,!1,!1,!1)
w=w.b.test(t)}else w=v}else w=v
if(w)return C.We
w=A.ab("^import\\s+(?:UIKit|Foundation|SwiftUI)\\b",!0,!1,!1,!1)
if(w.b.test(t))return C.W7
w=A.ab("^\\s*def\\s+\\w+\\s*\\([^)]*\\)\\s*:",!0,!1,!1,!1)
if(!w.b.test(t)){w=A.ab("^\\s*(?:async\\s+)?def\\s+\\w+\\s*\\(.*\\)\\s*(?:->\\s*\\w+\\s*)?:",!0,!1,!1,!1)
w=w.b.test(t)}else w=!0
if(w)return C.Wb
w=A.ab("^\\s*(?:pub\\s+)?(?:fun|val|var)\\s+\\w+",!0,!1,!1,!1)
if(w.b.test(t)&&C.d.C(t,A.ab("\\b(?:Unit|Int|String|Boolean)\\b",!0,!1,!1,!1)))return C.W6
w=A.ab("^\\s*(?:const|let|var|function)\\s+\\w+",!0,!1,!1,!1)
v=!0
if(!w.b.test(t)){w=A.ab("=>",!0,!1,!1,!1)
if(!w.b.test(t)){w=A.ab("^\\s*console\\.log\\(",!0,!1,!0,!1)
w=w.b.test(t)}else w=v}else w=v
if(w)return C.yD
u=C.d.av(t)
if(u.length===0)return null
if(C.d.ac(u,"{")||C.d.ac(u,"[")){w=A.ab('^[\\s{}\\[\\]",:0-9aeflnrtyA-FLNR\\.\\-+]*$',!0,!1,!1,!1)
w=w.b.test(u)}else w=!1
if(w)return C.Wc
w=A.ab("^---\\s*$",!0,!1,!0,!1)
if(!w.b.test(t)){w=A.ab("^[a-zA-Z0-9_-]+:\\s*(?:$|[^\\s])",!0,!1,!0,!1)
v=!1
if(w.b.test(t))if(!C.d.C(t,"{"))if(!C.d.C(t,";")){w=A.ab(":\\s",!0,!1,!1,!1)
w=w.b.test(t)}else w=v
else w=v
else w=v}else w=!0
if(w)return C.Wd
return null}},D,E,G
J=c[1]
A=c[0]
C=c[2]
F=c[184]
B=a.updateHolder(c[98],B)
D=c[343]
E=c[242]
G=c[344]
B.BH.prototype={
q(){return new B.app()}}
B.app.prototype={
l(){var x=this.e
if(x!=null)x.ah()
this.P()},
ga3j(){var x=this.a,w=x.e
x=w.c
if(x==null){x=w.d
x=x==null?null:x.Ye()}return x},
HH(d){return this.aAf(d)},
aAf(d){var x=0,w=A.M(y.H),v,u=this,t,s
var $async$HH=A.H(function(e,f){if(e===1)return A.J(f,w)
for(;;)switch(x){case 0:s=u.ga3j()
x=s!=null&&s.length!==0?3:4
break
case 3:x=5
return A.D(A.no(new A.kk(s)),$async$HH)
case 5:case 4:u.a.toString
if(u.c==null){x=1
break}u.n(new B.bhg(u))
t=u.e
if(t!=null)t.ah()
u.e=A.dr(d,new B.bhh(u))
u.a.toString
case 1:return A.K(v,w)}})
return A.L($async$HH,w)},
k(a6){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d=this,a0=null,a1=A.h(a6),a2=y._,a3=A.aL(a6,D.a37,new B.bhi(),d.a.ax,a2,a2),a4=a1.f,a5=a6.R(y.I).w
a2=a3.x
if(a2==null)a2=C.U
x=a1.r
w=A.c9(a2,x.a*a4).B(a5)
a2=a1.Q
v=a2==null
u=A.xg(v?A.b5():a2)
t=28*a4
s=Math.max(0,(((v?A.b5():a2)===C.aK?44:48)-t)/2)
r=t+(u?2*s:0)
a2=d.a
v=a2.w
if(v==null)v=a3.y
a2=A.ai(a2.d,y.k)
if(v!==!1)a2.push(d.atp(a6,a1,a3,a4,t,s))
if(a2.length===0)q=a0
else{d.a.toString
v=a3.ax
a2=A.R(d.aPw(a2,a4,v==null?4:v),C.l,a0,C.c,C.j,0,a0)
q=a2}a2=d.a
a2.toString
v=u&&q!=null?r:0
p=Math.max(0,v)
o=C.nS.aVn(p)
n=a2.e
m=d.ga3j()
if(m!=null){l=A.aE0(d.a.r)
if(l==null)l=B.cSq(m)
if(l!=null){k=a1.d.b.T(a1.a.c)
n=A.kH(A.ba(A.Gh(k,m,a1.gq1(),l),a0,a0,a0,a0,a0,a0,a0,a0,k,a0),a0,a0,a0,a0,a0,a0,a0,a0,a0)}}j=A.jK(F.c8v(n))
d.a.toString
i=A.yY(a6,!1)==null||A.zr(a6)!=null?j:A.aid(j,a0,a0,new A.hO())
h=A.a4(a1.b.a*16)
a2=a3.e
g=a2==null?a0:a2.B(a1.a)
f=g==null?a0:A.ev(g,a1.as)
a2=a1.a
v=a3.f.B(a2)
v=A.aQ(v,C.w,a3.r*a4)
a2=A.a([A.ag(a0,A.bd(A.bd(A.dm(i,a0,a0,a0,A.ay(a0,a0,a2.c,a0,a0,a0,a0,a0,a0,a0,a0,a0,a0,a0,a0,a0,a0,!0,a0,a0,a0,a0,a0,a0,a0,a0),a0,a0),a0,w,a0,a0,C.I),a0,a0,a0,a0,C.z),C.n,a0,o,a0,a0,a0,a0,a0,a0,a0,a0,a0)],y.p)
if(q!=null){x=x.b
e=x*a4
if(u)e=Math.max(0,e-s)
a2.push(A.c_S(a0,q,e,a0,a5,u?Math.max(0,(p-r)/2):x*a4,a0))}return new A.dR(A.ag(a0,A.bT(C.W,a2,C.N,C.dO),C.n,a0,a0,new A.V(f,a0,v,h,a0,a0,a0,C.o),a0,a0,a0,a0,a0,a0,a0,a0),a1.at,h,a0)},
atp(d,e,f,g,h,i){var x,w,v,u,t,s,r,q=null,p=this.a
p.toString
x=this.d
w=f.ay
v=new B.bhe(this,w==null?C.iw:w)
p=p.Q
if(p!=null)return p.$3(d,v,x)
if(x){p=f.Q
u=p==null?C.d1:p}else{p=f.z
u=p==null?C.iI:p}if(x){p=f.at
p=p==null?q:p.B(e.a)
t=p}else{p=f.as
p=p==null?q:p.B(e.a)
t=p}if(t==null){p=e.a
t=x?p.w:p.as}s=A.cf(d,C.i4,y.w).w.ax
r=s?C.B:C.ah
h=28*g
p=e.Q
i=Math.max(0,(((p==null?A.b5():p)===C.aK?44:48)-h)/2)
p=x?"Copied":"Copy code"
return A.EH(A.be(!0,q,new A.x(h,h,A.ca(q,!1,C.S,A.as(A.GB(A.an(u,t,new A.aq(x,y.l),q,14*g),r,A.bPP(),q,C.bL,C.bL,new B.bhc(s)),q,q),new A.cP(new B.bhd(e,g)),!1,!0,!0,q,!0,q,q,G.za,q,q,q,q,v,q,q,q,C.Y0,q,q,q,q,q),q),!1,q,q,!1,q,!1,q,q,q,q,q,q,q,q,q,p,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q),i,i)},
aPw(d,e,f){var x,w,v,u=y.p,t=A.a([],u)
for(x=f*e,w=0;w<d.length;++w){v=A.a([],u)
if(w>0)v.push(new A.cj(x,null,null))
v.push(d[w])
C.b.E(t,v)}return t}}
B.np.prototype={
F(d){var x,w,v,u,t,s,r,q,p=this,o=p.e
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
return new B.np(o,p.f,p.r,d.w,x,w,v,u,t,s,r,q,d.a,null,d.c,d.d)},
h(d,e){var x=this
if(e==null)return!1
if(x===e)return!0
return e instanceof B.np&&J.z(e.e,x.e)&&e.f.h(0,x.f)&&e.r===x.r&&J.z(e.x,x.x)&&e.y==x.y&&J.z(e.z,x.z)&&J.z(e.Q,x.Q)&&J.z(e.as,x.as)&&J.z(e.at,x.at)&&e.ax==x.ax&&J.z(e.ay,x.ay)},
gt(d){var x=this
return A.W(x.a,x.c,x.d,x.e,x.f,x.r,x.w,x.x,x.y,x.z,x.Q,x.as,x.at,x.ax,x.ay,C.a,C.a,C.a,C.a,C.a)}}
B.ZN.prototype={
k(d){var x=null
return A.X(!1,A.d(this.c,x,x,x,x,x,x,x,x,x,x,x,x,x),x,x,x,x,x,x,x,x,this.d,x,x,C.u,x,x,x,x,C.Y)}}
B.ZO.prototype={
q(){return new B.apo()}}
B.apo.prototype={
k(d){var x,w,v,u,t,s,r,q,p,o,n,m=this,l=null,k=A.h(d),j=$.cfk(),i=j[m.d],h=y.p,g=A.a([],h)
for(x=k.a,w=x.as,v=k.x.a,u=v*2,t=y.a,s=k.d.d,x=x.x,r=0;r<6;++r){q=A.a([],h)
if(r>0)q.push(new A.cj(v,l,l))
p=j[r]
o=r===m.d
n=o?x:w
q.push(A.ca(l,!1,C.S,new A.a5(p.b,l,s.fb(n,o?C.R:C.a0),l,l,l,l,l,l,l,l,l,l,l,l,l),new A.cP(new B.bha(m,r,k)),!1,!0,!0,l,!0,l,l,l,l,l,l,l,new B.bhb(m,r),l,l,l,new A.bH(new A.O(u,v,u,v),t),l,l,l,l,l))
C.b.E(g,q)}j=i.c
return A.u(A.a([A.bd(A.R(g,C.l,l,C.c,C.j,0,l),l,l,l,l,C.I),A.p(u,l),new A.x(380,l,B.bZI(C.b5,A.d(i.a,l,l,l,l,l,l,l,l,l,l,l,l,l),l,new A.aq(j,y.O),j,l,l),l)],h),C.l,l,C.c,C.j,0,C.i)}}
B.ZP.prototype={
q(){return new B.apq()}}
B.apq.prototype={
k(d){var x=null,w=A.h(d),v=y.p
return A.u(A.a([new A.x(320,x,B.bZI(A.a([new B.ZN($.c().$2(d,"Copy"),new B.bhl(this),x),new B.ZN("Run",new B.bhm(this),x)],v),A.d("flutter run -d chrome",x,x,x,x,x,x,x,x,x,x,x,x,x),x,x,x,!1,x),x),A.p(w.x.a*2,x),A.d(this.d,x,x,x,x,x,x,x,x,A.ay(x,x,A.h(d).a.as,x,x,x,x,x,x,x,x,12,x,x,x,x,x,!0,x,x,x,x,x,x,x,x),x,x,x,x)],v),C.l,x,C.c,C.j,0,C.i)}}
B.abb.prototype={
aik(d){var x=this
return new A.fY(x.a*d,x.b*d,x.c*d,x.d*d)},
$iaLx:1}
var z=a.updateTypes(["b(n)","np(np)"])
B.bhg.prototype={
$0(){return this.a.d=!0},
$S:0}
B.bhh.prototype={
$0(){var x=this.a
if(x.c!=null){x.n(new B.bhf(x))
x.a.toString}},
$S:0}
B.bhf.prototype={
$0(){return this.a.d=!1},
$S:0}
B.bhi.prototype={
$1(d){return d},
$S:z+1}
B.bhe.prototype={
$0(){return this.a.HH(this.b)},
$S:0}
B.bhd.prototype={
$1(d){var x=null,w=d.C(0,C.bb)||d.C(0,C.db),v=this.a,u=v.a,t=w?u.Q:u.d.aH(0.8)
u=w?x:A.aQ(u.CW.aH(0.5),C.w,this.b)
return new A.V(t,x,u,A.a4(Math.max(0,v.b.a*16-4)),x,x,x,C.o)},
$S:21}
B.bhc.prototype={
$2(d,e){var x,w=new A.eK(e,!1,d,null)
if(this.a)return w
x=y.t
return A.Kj(C.C,w,null,new A.d_(e,new A.bX(0.8,1,x),x.i("d_<cJ.T>")))},
$S:135}
B.bhb.prototype={
$0(){var x=this.a
return x.n(new B.bh9(x,this.b))},
$S:0}
B.bh9.prototype={
$0(){return this.a.d=this.b},
$S:0}
B.bha.prototype={
$1(d){var x,w=this,v=null
if(w.b===w.a.d)x=w.c.a.w
else x=d.C(0,C.bb)?w.c.a.Q:v
return new A.V(x,v,v,A.a4(Math.max(0,w.c.b.a*16-4)),v,v,v,C.o)},
$S:21}
B.bhl.prototype={
$0(){var x=this.a
return x.n(new B.bhk(x))},
$S:0}
B.bhk.prototype={
$0(){return this.a.d="copied"},
$S:0}
B.bhm.prototype={
$0(){var x=this.a
return x.n(new B.bhj(x))},
$S:0}
B.bhj.prototype={
$0(){return this.a.d="running"},
$S:0}
B.bMH.prototype={
$3(d,e,f){var x,w,v=null,u=A.h(d),t=u.x.a,s=t*2,r=f?C.d1:C.iI,q=u.a
r=A.an(r,f?q.w:q.c,v,v,13)
x=A.p(t,v)
w=f?$.c().$2(d,"Copied!"):$.c().$2(d,"Copy")
q=f?q.w:q.c
return A.ca(v,!1,C.S,A.R(A.a([r,x,A.d(w,v,v,v,v,v,v,v,v,u.d.d.UO(q,12,C.am),v,v,v,v)],y.p),C.l,v,C.c,C.j,0,v),new A.cP(new B.bMG(f,u)),!1,!0,!0,v,!0,v,v,v,v,v,v,v,e,v,v,v,new A.bH(new A.O(s,t,s,t),y.a),v,v,v,v,v)},
$S:887}
B.bMG.prototype={
$1(d){var x=null,w=this.b,v=w.a
v=this.a?v.w.aH(0.2):v.Q
return new A.V(v,x,x,A.a4(Math.max(0,w.b.a*16-4)),x,x,x,C.o)},
$S:21};(function installTearOffs(){var x=a._static_1
x(B,"cLr","ct_",0)
x(B,"cLt","ct1",0)
x(B,"cLq","csZ",0)
x(B,"cLs","ct0",0)
x(B,"cLu","ct2",0)})();(function inheritance(){var x=a.inheritMany,w=a.inherit
x(A.q,[B.BH,B.ZO,B.ZP])
x(A.t,[B.app,B.apo,B.apq])
x(A.aM,[B.bhg,B.bhh,B.bhf,B.bhe,B.bhb,B.bh9,B.bhl,B.bhk,B.bhm,B.bhj])
x(A.ax,[B.bhi,B.bhd,B.bha,B.bMH,B.bMG])
w(B.bhc,A.bD)
w(B.np,A.av)
w(B.ZN,A.m)
w(B.abb,A.fY)})()
A.ao(b.typeUniverse,JSON.parse('{"BH":{"q":[],"b":[]},"app":{"t":["BH"]},"np":{"av":[]},"ZO":{"q":[],"b":[]},"ZP":{"q":[],"b":[]},"ZN":{"m":[],"b":[]},"apo":{"t":["ZO"]},"apq":{"t":["ZP"]},"abb":{"aLx":[],"es":[]}}'))
var y=(function rtii(){var x=A.j
return{_:x("np"),I:x("ds"),j:x("i<v>"),p:x("i<b>"),w:x("j9"),t:x("bX<G>"),O:x("aq<o>"),l:x("aq<F>"),k:x("b"),a:x("bH<es>"),H:x("~")}})();(function constants(){D.cfN=new A.a5('void main() { runApp(const MyApp(home: Center(child: Text("long line scrolls horizontally inside code block")))); }',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)
D.a3a=new B.BH(C.b5,D.cfN,null,null,null,null,null)
D.cbg=new A.x(320,null,D.a3a,null)
D.Z3=new A.bk(C.C,null,null,D.cbg,null)
D.cfb=new A.a5('const greeting = "hello";',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)
D.a39=new B.BH(C.b5,D.cfb,null,null,null,null,null)
D.Z8=new A.bk(C.C,null,null,D.a39,null)
D.aos=new B.abb(1,1,3.5,1)
D.a37=new B.np(C.dy,C.aB,1,null,D.aos,!0,C.iI,C.d1,C.bH,C.aW,4,C.iw,null,null,null,null)
D.a38=new B.np(null,C.aW,1.5,null,null,null,null,null,null,null,null,null,null,null,null,null)
D.ceM=new A.a5("final custom = CodeSnippetCustomized();",null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)
D.cnB=new B.ZO(null)
D.cnC=new B.ZP(null)})();(function lazyInitializers(){var x=a.lazyFinal
x($,"cVv","cfk",()=>A.a([new A.wW("void main() {\n  runApp(MyApp());\n}",A.a_(null,"Dart"),"dart"),new A.wW('{\n  "name": "dashcn",\n  "version": "1.0.0",\n  "private": true\n}',"JSON","json"),new A.wW("name: dashcn\nversion: 1.0.0\nenvironment:\n  sdk: ^3.0.0","YAML","yaml"),new A.wW("flutter pub add dashcn\ndashcn add code_snippet",A.a_(null,"Shell"),"bash"),new A.wW("interface User {\n  id: string;\n  name: string;\n}","TypeScript","ts"),new A.wW('<div class="card">\n  <span id="title">Hello</span>\n</div>',"HTML","html")],A.j("i<+code,label,lang(o,o,o)>")))})()};
(a=>{a["KdPPCuOIZGwEWKWGClq6AXARwAU="]=a.current})($__dart_deferred_initializers__);