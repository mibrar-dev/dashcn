((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,B,C,E,F,A={
clk(d,e,f,g){var x,w,v=new A.aR7(g,null,e,f)
if(d instanceof B.aR){x=$.aT
w=new B.aR(x,f.i("aR<0>"))
if(x!==C.aQ)v=x.y8(v,f.i("0/"),y.K,y.j)
d.yK(new B.oz(w,2,null,v,d.$ti.i("@<1>").bP(f).i("oz<1,2>")))
return w}return d.cn(new A.aR6(f),v,f)},
aR7:function aR7(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},
aR6:function aR6(d){this.a=d},
cyp(){return new b.G.XMLHttpRequest()},
cyx(){return b.G.document.createElement("img")},
caK(d,e,f){var x=new A.asP(d,B.a([],y.v),B.a([],y.l),B.a([],y.u))
x.arG(d,e,f)
return x},
Jo:function Jo(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},
aXh:function aXh(d,e,f){this.a=d
this.b=e
this.c=f},
aXi:function aXi(d,e){this.a=d
this.b=e},
aXf:function aXf(d,e,f){this.a=d
this.b=e
this.c=f},
aXg:function aXg(d,e,f){this.a=d
this.b=e
this.c=f},
asP:function asP(d,e,f,g){var _=this
_.z=d
_.Q=!1
_.as=$
_.at=!1
_.ax=$
_.a=e
_.b=f
_.e=_.d=_.c=null
_.r=_.f=!1
_.w=0
_.x=!1
_.y=g},
bpQ:function bpQ(d){this.a=d},
bpR:function bpR(d,e){this.a=d
this.b=e},
bpS:function bpS(d){this.a=d},
bpT:function bpT(d){this.a=d},
bpU:function bpU(d){this.a=d},
M4:function M4(d,e){this.a=d
this.b=e},
cmJ(d,e){return new A.Jp("HTTP request failed, statusCode: "+d+", "+e.m(0))},
ba_:function ba_(d,e){this.a=d
this.b=e},
Jp:function Jp(d){this.b=d},
cmO(d,e){var x=new A.afE(B.a([],y.v),B.a([],y.l),B.a([],y.u))
x.ary(d,e)
return x},
afE:function afE(d,e,f){var _=this
_.a=d
_.b=e
_.e=_.d=_.c=null
_.r=_.f=!1
_.w=0
_.x=!1
_.y=f},
aXJ:function aXJ(d,e){this.a=d
this.b=e},
c7e(d,e,f,g){var x=null
return new B.CJ(F.c91(x,x,new A.Jo(d,1,x,D.cmO)),g,e,x,x,f,x)}},D
J=c[1]
B=c[0]
C=c[2]
E=c[224]
F=c[205]
A=a.updateHolder(c[178],A)
D=c[488]
A.Jo.prototype={
EX(d){return new B.ff(this,y.i)},
Ay(d,e){return A.caK(this.BM(d,e),d.a,null)},
Az(d,e){return A.caK(this.BM(d,e),d.a,null)},
BM(d,e){return this.aF6(d,e)},
aF6(d,e){var x=0,w=B.M(y.R),v,u=2,t=[],s=this,r,q,p,o,n
var $async$BM=B.H(function(f,g){if(f===1){t.push(g)
x=u}for(;;)switch(x){case 0:p=new A.aXh(s,e,d)
o=new A.aXi(s,d)
case 3:switch(s.d.a){case 0:x=5
break
case 2:x=6
break
case 1:x=7
break
default:x=4
break}break
case 5:v=p.$0()
x=1
break
case 6:v=o.$0()
x=1
break
case 7:u=9
x=12
return B.D(p.$0(),$async$BM)
case 12:r=g
v=r
x=1
break
u=2
x=11
break
case 9:u=8
n=t.pop()
r=o.$0()
v=r
x=1
break
x=11
break
case 8:x=2
break
case 11:x=4
break
case 4:case 1:return B.K(v,w)
case 2:return B.J(t.at(-1),w)}})
return B.L($async$BM,w)},
Ck(d){var x=0,w=B.M(y.p),v,u=this,t,s,r,q,p,o,n
var $async$Ck=B.H(function(e,f){if(e===1)return B.J(f,w)
for(;;)switch(x){case 0:s=u.a
r=B.XZ().C(s)
q=new B.aR($.aT,y.Z)
p=new B.c_(q,y.x)
o=A.cyp()
o.open("GET",s,!0)
o.responseType="arraybuffer"
o.addEventListener("load",B.hn(new A.aXf(o,p,r)))
o.addEventListener("error",B.hn(new A.aXg(p,o,r)))
o.send()
x=3
return B.D(q,$async$Ck)
case 3:s=o.response
s.toString
t=B.c88(y.a.a(s),0,null)
if(t.byteLength===0)throw B.x(A.cmJ(B.al(o,"status"),r))
n=d
x=4
return B.D(B.adZ(t),$async$Ck)
case 4:v=n.$1(f)
x=1
break
case 1:return B.K(v,w)}})
return B.L($async$Ck,w)},
h(d,e){var x=this
if(e==null)return!1
if(J.bp(e)!==B.ai(x))return!1
return e instanceof A.Jo&&e.a===x.a&&e.b===x.b&&e.d===x.d&&B.Op(e.c,x.c)},
gt(d){var x=this
return B.X(x.a,x.b,x.d,D.c00.oP(x.c),C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a)},
m(d){var x=this
return'NetworkImage("'+x.a+'", scale: '+C.i.a6(x.b,1)+", webHtmlElementStrategy: "+x.d.b+", headers: "+B.F(x.c)+")"}}
A.asP.prototype={
arG(d,e,f){var x=this
x.e=e
x.z.cn(new A.bpQ(x),new A.bpR(x,f),y.P)},
gagV(){var x=this,w=x.ax
return w===$?x.ax=new B.j5(new A.bpS(x),new A.bpT(x),new A.bpU(x),!0):w},
Xn(){var x,w=this
if(w.Q){x=w.as
x===$&&B.f()
x.P(w.gagV())}w.at=!0
w.anK()}}
A.M4.prototype={
rl(){return new A.M4(this.a,this.b)},
l(){},
gha(){return B.aH(B.dh("Could not create image data for this image because access to it is restricted by the Same-Origin Policy.\nSee https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy"))},
ghW(){return 1},
ga_c(){var x=this.a
return C.f.bS(4*x.naturalWidth*x.naturalHeight)},
$ik4:1,
goF(){return this.b}}
A.ba_.prototype={
J(){return"WebHtmlElementStrategy."+this.b}}
A.Jp.prototype={
m(d){return this.b},
$idl:1}
A.afE.prototype={
ary(d,e){d.cn(this.gala(),new A.aXJ(this,e),y.H)}}
var z=a.updateTypes([])
A.aR7.prototype={
$2(d,e){if(!this.a.b(d))throw B.x(d)
return this.c.$2(d,e)},
$S(){return this.d.i("0/(I,dg)")}}
A.aR6.prototype={
$1(d){return d},
$S(){return this.a.i("0(0)")}}
A.aXh.prototype={
$0(){var x=0,w=B.M(y.R),v,u=this,t,s,r
var $async$$0=B.H(function(d,e){if(d===1)return B.J(e,w)
for(;;)switch(x){case 0:t=u.c
s=E
r=B
x=3
return B.D(u.a.Ck(u.b),$async$$0)
case 3:v=s.afg(r.eC(e,y.p),t.a,null,t.b)
x=1
break
case 1:return B.K(v,w)}})
return B.L($async$$0,w)},
$S:324}
A.aXi.prototype={
$0(){var x=0,w=B.M(y.R),v,u=this,t,s,r
var $async$$0=B.H(function(d,e){if(d===1)return B.J(e,w)
for(;;)switch(x){case 0:s=A.cyx()
r=u.b.a
s.src=r
x=3
return B.D(B.hW(s.decode(),y.X),$async$$0)
case 3:t=A.cmO(B.eC(new A.M4(s,r),y.J),null)
t.e=r
v=t
x=1
break
case 1:return B.K(v,w)}})
return B.L($async$$0,w)},
$S:324}
A.aXf.prototype={
$1(d){var x=this.a,w=x.status,v=w>=200&&w<300,u=w>307&&w<400,t=v||w===0||w===304||u,s=this.b
if(t)s.f1(x)
else s.pv(new A.Jp("HTTP request failed, statusCode: "+B.F(w)+", "+this.c.m(0)))},
$S:34}
A.aXg.prototype={
$1(d){return this.a.pv(new A.Jp("HTTP request failed, statusCode: "+B.F(this.b.status)+", "+this.c.m(0)))},
$S:7}
A.bpQ.prototype={
$1(d){var x=this.a
x.Q=!0
if(x.at){d.CM()
return}x.as!==$&&B.bJ()
x.as=d
d.a1(x.gagV())},
$S:803}
A.bpR.prototype={
$2(d,e){this.a.yd(B.bU("resolving an image stream completer"),d,this.b,!0,e)},
$S:25}
A.bpS.prototype={
$2(d,e){this.a.Nv(d)},
$S:284}
A.bpT.prototype={
$1(d){this.a.b2H(d)},
$S:285}
A.bpU.prototype={
$2(d,e){this.a.b2G(d,e)},
$S:192}
A.aXJ.prototype={
$2(d,e){this.a.yd(B.bU("resolving a single-frame image stream"),d,this.b,!0,e)},
$S:25};(function inheritance(){var x=a.inheritMany,w=a.inherit
x(B.bF,[A.aR7,A.bpR,A.bpS,A.bpU,A.aXJ])
x(B.ax,[A.aR6,A.aXf,A.aXg,A.bpQ,A.bpT])
w(A.Jo,B.j3)
x(B.aN,[A.aXh,A.aXi])
x(B.j4,[A.asP,A.afE])
x(B.I,[A.M4,A.Jp])
w(A.ba_,B.dz)})()
B.ap(b.typeUniverse,JSON.parse('{"Jo":{"j3":["c1_"],"j3.T":"c1_"},"asP":{"j4":[]},"M4":{"k4":[]},"c1_":{"j3":["c1_"]},"Jp":{"dl":[]},"afE":{"j4":[]}}'))
var y=(function rtii(){var x=B.j
return{p:x("iA"),J:x("k4"),R:x("j4"),v:x("i<j5>"),u:x("i<~()>"),l:x("i<~(I,dg?)>"),a:x("yW"),P:x("aY"),K:x("I"),j:x("dg"),i:x("ff<Jo>"),x:x("c_<c2>"),Z:x("aR<c2>"),X:x("I?"),H:x("~")}})();(function constants(){D.c00=new B.D7(C.A2,C.A2,B.j("D7<p,p>"))
D.cmO=new A.ba_(0,"never")})()};
(a=>{a["sWeyqGxzbJBzxxuTygAEC7nsYSs="]=a.current})($__dart_deferred_initializers__);