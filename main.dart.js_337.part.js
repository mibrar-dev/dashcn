((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,B,C,E,F,A={
ck_(d,e,f,g){var x,w,v=new A.aQT(g,null,e,f)
if(d instanceof B.aS){x=$.aU
w=new B.aS(x,f.i("aS<0>"))
if(x!==C.aQ)v=x.y8(v,f.i("0/"),y.K,y.j)
d.yJ(new B.ow(w,2,null,v,d.$ti.i("@<1>").bP(f).i("ow<1,2>")))
return w}return d.cp(new A.aQS(f),v,f)},
aQT:function aQT(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},
aQS:function aQS(d){this.a=d},
cx5(){return new b.G.XMLHttpRequest()},
cxd(){return b.G.document.createElement("img")},
c9r(d,e,f){var x=new A.asE(d,B.a([],y.v),B.a([],y.l),B.a([],y.u))
x.arA(d,e,f)
return x},
Jg:function Jg(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},
aX2:function aX2(d,e,f){this.a=d
this.b=e
this.c=f},
aX3:function aX3(d,e){this.a=d
this.b=e},
aX0:function aX0(d,e,f){this.a=d
this.b=e
this.c=f},
aX1:function aX1(d,e,f){this.a=d
this.b=e
this.c=f},
asE:function asE(d,e,f,g){var _=this
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
bp9:function bp9(d){this.a=d},
bpa:function bpa(d,e){this.a=d
this.b=e},
bpb:function bpb(d){this.a=d},
bpc:function bpc(d){this.a=d},
bpd:function bpd(d){this.a=d},
LY:function LY(d,e){this.a=d
this.b=e},
clo(d,e){return new A.Jh("HTTP request failed, statusCode: "+d+", "+e.m(0))},
b9t:function b9t(d,e){this.a=d
this.b=e},
Jh:function Jh(d){this.b=d},
clt(d,e){var x=new A.afz(B.a([],y.v),B.a([],y.l),B.a([],y.u))
x.ars(d,e)
return x},
afz:function afz(d,e,f){var _=this
_.a=d
_.b=e
_.e=_.d=_.c=null
_.r=_.f=!1
_.w=0
_.x=!1
_.y=f},
aXr:function aXr(d,e){this.a=d
this.b=e},
c5W(d,e,f,g){var x=null
return new B.CB(F.c7I(x,x,new A.Jg(d,1,x,D.ckl)),x,g,e,x,x,f,x)}},D
J=c[1]
B=c[0]
C=c[2]
E=c[224]
F=c[205]
A=a.updateHolder(c[178],A)
D=c[487]
A.Jg.prototype={
EW(d){return new B.fg(this,y.i)},
Ax(d,e){return A.c9r(this.BL(d,e),d.a,null)},
Ay(d,e){return A.c9r(this.BL(d,e),d.a,null)},
BL(d,e){return this.aEZ(d,e)},
aEZ(d,e){var x=0,w=B.M(y.R),v,u=2,t=[],s=this,r,q,p,o,n
var $async$BL=B.H(function(f,g){if(f===1){t.push(g)
x=u}for(;;)switch(x){case 0:p=new A.aX2(s,e,d)
o=new A.aX3(s,d)
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
return B.D(p.$0(),$async$BL)
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
return B.L($async$BL,w)},
Cj(d){var x=0,w=B.M(y.p),v,u=this,t,s,r,q,p,o,n
var $async$Cj=B.H(function(e,f){if(e===1)return B.J(f,w)
for(;;)switch(x){case 0:s=u.a
r=B.Y0().B(s)
q=new B.aS($.aU,y.Z)
p=new B.c_(q,y.x)
o=A.cx5()
o.open("GET",s,!0)
o.responseType="arraybuffer"
o.addEventListener("load",B.hm(new A.aX0(o,p,r)))
o.addEventListener("error",B.hm(new A.aX1(p,o,r)))
o.send()
x=3
return B.D(q,$async$Cj)
case 3:s=o.response
s.toString
t=B.c6Q(y.a.a(s),0,null)
if(t.byteLength===0)throw B.w(A.clo(B.aj(o,"status"),r))
n=d
x=4
return B.D(B.adV(t),$async$Cj)
case 4:v=n.$1(f)
x=1
break
case 1:return B.K(v,w)}})
return B.L($async$Cj,w)},
h(d,e){var x=this
if(e==null)return!1
if(J.bp(e)!==B.ah(x))return!1
return e instanceof A.Jg&&e.a===x.a&&e.b===x.b&&e.d===x.d&&B.a7q(e.c,x.c)},
gt(d){var x=this
return B.W(x.a,x.b,x.d,D.bZU.oR(x.c),C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a)},
m(d){var x=this
return'NetworkImage("'+x.a+'", scale: '+C.h.a8(x.b,1)+", webHtmlElementStrategy: "+x.d.b+", headers: "+B.E(x.c)+")"}}
A.asE.prototype={
arA(d,e,f){var x=this
x.e=e
x.z.cp(new A.bp9(x),new A.bpa(x,f),y.P)},
gagL(){var x=this,w=x.ax
return w===$?x.ax=new B.j4(new A.bpb(x),new A.bpc(x),new A.bpd(x),!0):w},
Xh(){var x,w=this
if(w.Q){x=w.as
x===$&&B.f()
x.O(w.gagL())}w.at=!0
w.anC()}}
A.LY.prototype={
rk(){return new A.LY(this.a,this.b)},
l(){},
ghb(){return B.aH(B.di("Could not create image data for this image because access to it is restricted by the Same-Origin Policy.\nSee https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy"))},
ghV(){return 1},
ga_5(){var x=this.a
return C.f.bW(4*x.naturalWidth*x.naturalHeight)},
$ik2:1,
goH(){return this.b}}
A.b9t.prototype={
J(){return"WebHtmlElementStrategy."+this.b}}
A.Jh.prototype={
m(d){return this.b},
$idn:1}
A.afz.prototype={
ars(d,e){d.cp(this.gal2(),new A.aXr(this,e),y.H)}}
var z=a.updateTypes([])
A.aQT.prototype={
$2(d,e){if(!this.a.b(d))throw B.w(d)
return this.c.$2(d,e)},
$S(){return this.d.i("0/(I,df)")}}
A.aQS.prototype={
$1(d){return d},
$S(){return this.a.i("0(0)")}}
A.aX2.prototype={
$0(){var x=0,w=B.M(y.R),v,u=this,t,s,r
var $async$$0=B.H(function(d,e){if(d===1)return B.J(e,w)
for(;;)switch(x){case 0:t=u.c
s=E
r=B
x=3
return B.D(u.a.Cj(u.b),$async$$0)
case 3:v=s.afc(r.eA(e,y.p),t.a,null,t.b)
x=1
break
case 1:return B.K(v,w)}})
return B.L($async$$0,w)},
$S:324}
A.aX3.prototype={
$0(){var x=0,w=B.M(y.R),v,u=this,t,s,r
var $async$$0=B.H(function(d,e){if(d===1)return B.J(e,w)
for(;;)switch(x){case 0:s=A.cxd()
r=u.b.a
s.src=r
x=3
return B.D(B.hV(s.decode(),y.X),$async$$0)
case 3:t=A.clt(B.eA(new A.LY(s,r),y.J),null)
t.e=r
v=t
x=1
break
case 1:return B.K(v,w)}})
return B.L($async$$0,w)},
$S:324}
A.aX0.prototype={
$1(d){var x=this.a,w=x.status,v=w>=200&&w<300,u=w>307&&w<400,t=v||w===0||w===304||u,s=this.b
if(t)s.f1(x)
else s.pu(new A.Jh("HTTP request failed, statusCode: "+B.E(w)+", "+this.c.m(0)))},
$S:34}
A.aX1.prototype={
$1(d){return this.a.pu(new A.Jh("HTTP request failed, statusCode: "+B.E(this.b.status)+", "+this.c.m(0)))},
$S:7}
A.bp9.prototype={
$1(d){var x=this.a
x.Q=!0
if(x.at){d.CL()
return}x.as!==$&&B.bS()
x.as=d
d.a1(x.gagL())},
$S:805}
A.bpa.prototype={
$2(d,e){this.a.yd(B.bU("resolving an image stream completer"),d,this.b,!0,e)},
$S:26}
A.bpb.prototype={
$2(d,e){this.a.Nr(d)},
$S:284}
A.bpc.prototype={
$1(d){this.a.b2n(d)},
$S:285}
A.bpd.prototype={
$2(d,e){this.a.b2m(d,e)},
$S:184}
A.aXr.prototype={
$2(d,e){this.a.yd(B.bU("resolving a single-frame image stream"),d,this.b,!0,e)},
$S:26};(function inheritance(){var x=a.inheritMany,w=a.inherit
x(B.bD,[A.aQT,A.bpa,A.bpb,A.bpd,A.aXr])
x(B.ax,[A.aQS,A.aX0,A.aX1,A.bp9,A.bpc])
w(A.Jg,B.j2)
x(B.aM,[A.aX2,A.aX3])
x(B.j3,[A.asE,A.afz])
x(B.I,[A.LY,A.Jh])
w(A.b9t,B.dA)})()
B.ao(b.typeUniverse,JSON.parse('{"Jg":{"j2":["c_M"],"j2.T":"c_M"},"asE":{"j3":[]},"LY":{"k2":[]},"c_M":{"j2":["c_M"]},"Jh":{"dn":[]},"afz":{"j3":[]}}'))
var y=(function rtii(){var x=B.j
return{p:x("iy"),J:x("k2"),R:x("j3"),v:x("i<j4>"),u:x("i<~()>"),l:x("i<~(I,df?)>"),a:x("yQ"),P:x("aZ"),K:x("I"),j:x("df"),i:x("fg<Jg>"),x:x("c_<c2>"),Z:x("aS<c2>"),X:x("I?"),H:x("~")}})();(function constants(){D.bZU=new B.D_(C.A2,C.A2,B.j("D_<o,o>"))
D.ckl=new A.b9t(0,"never")})()};
(a=>{a["lGR7dfnhdasV24TMXQ1z4ZJlb2E="]=a.current})($__dart_deferred_initializers__);