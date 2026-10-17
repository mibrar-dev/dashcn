((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var B,C,A={
bTw(d,e,f,g,h,i,j,k,l,m,n,o,p,q){return new A.tT(g,f,m,k,l,j,h,d,p,o,n,e,i,q.i("tT<0>"))},
tT:function tT(d,e,f,g,h,i,j,k,l,m,n,o,p,q){var _=this
_.c=d
_.d=e
_.x=f
_.y=g
_.z=h
_.Q=i
_.at=j
_.ax=k
_.ay=l
_.ch=m
_.CW=n
_.db=o
_.a=p
_.$ti=q},
Cu:function Cu(d,e){var _=this
_.r=_.f=_.e=_.d=null
_.w=d
_.c=_.a=null
_.$ti=e},
biF:function biF(){},
biE:function biE(d){this.a=d},
biG:function biG(d){this.a=d},
ccz(d,e,f,g,h,i){var x,w,v={},u=!g,t=!u||h,s=!i,r=!s||f
if(!t&&!r)return null
if(i&&!f)return D.qS
if(f&&s)return D.CZ
if(g&&!h)return D.CX
if(h&&u)return D.CY
x=e.a
if(x<=0)x=0
w=e.b
if(w<=0)w=0
v.a=D.qS
v.b=1/0
u=new A.bvX(v)
if(i)u.$2(D.qS,w===0?0:d.b/w)
if(f)u.$2(D.CZ,w===0?0:(w-d.b)/w)
if(g)u.$2(D.CX,x===0?0:d.a/x)
if(h)u.$2(D.CY,x===0?0:(x-d.a)/x)
return v.a},
bIE(d,e,f){if(!isFinite(d)||e>f)return 0
return C.f.I(d,e,f)},
vt:function vt(d,e){this.a=d
this.b=e},
bvX:function bvX(d){this.a=d},
aza:function aza(d,e,f){this.a=d
this.b=e
this.c=f},
bzO(d,e){return new A.QF(!0,d,null)},
mk:function mk(d,e){this.a=d
this.$ti=e},
a9O:function a9O(d,e,f,g,h){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h},
QF:function QF(d,e,f){this.c=d
this.r=e
this.a=f},
B5:function B5(d,e,f,g,h,i){var _=this
_.d=d
_.e=$
_.f=null
_.r=e
_.w=f
_.x=g
_.e4$=h
_.aU$=i
_.c=_.a=null},
aQw:function aQw(){},
aQx:function aQx(){},
aQv:function aQv(){},
Ym:function Ym(){},
PM:function PM(d,e,f,g,h){var _=this
_.bK=d
_.E=e
_.D$=f
_.dy=g
_.b=_.fy=null
_.c=0
_.y=_.d=null
_.z=!0
_.Q=null
_.as=!1
_.at=null
_.ay=$
_.ch=h
_.CW=!1
_.cx=$
_.cy=!0
_.db=!1
_.dx=$},
a68:function a68(d,e,f,g){var _=this
_.e=d
_.f=e
_.c=f
_.a=g}},D
B=c[0]
C=c[2]
A=a.updateHolder(c[165],A)
D=c[471]
A.tT.prototype={
t(){return new A.Cu(new B.bq(!1,$.a4(),y.q),this.$ti.i("Cu<1>"))}}
A.Cu.prototype={
m(){var x,w=this,v=w.d,u=w.e
w.e=w.d=null
w.uE()
if(v!=null)if(u!=null)u.Oa(v)
x=w.w
x.k1$=$.a4()
x.id$=0
w.T()},
aro(d){var x,w,v,u,t,s,r,q,p,o=this
if(!o.a.c)return
x=o.c
x.toString
x=B.ja(x,y.o)
w=o.c.ga8()
w.toString
v=y.g
v.a(w)
u=x.c.ga8()
u.toString
v.a(u)
v=o.a.d
t=w.gA()
s=w.aG(u)
w=w.gA()
u=u.gA()
r=B.bY(s,C.x)
q=B.bY(s,new B.y(w.a,w.b))
w=o.a.db
p=new A.a9O(v,t,new A.aza(u,r,q),w,new B.bq(C.x,$.a4(),y.k))
o.d=p
o.e=x
x.aJL(p)
o.p(new A.biF())
x=o.a.ay
if(x!=null)x.$0()},
ay6(d){var x,w,v,u,t,s=this.d
if(s==null)return
x=s.e
w=s.c
v=x.a.a9(0,d.d)
u=w.b
t=w.a
w=w.c
x.sG(new B.y(A.bIE(v.a,-u.a,t.a-w.a),A.bIE(v.b,-u.b,t.b-w.b)))
this.aAq(s)},
aAq(d){var x,w,v,u,t,s,r,q,p,o,n,m,l=this,k=l.c
k.toString
k=B.ja(k,y.o)
if(k==null)return
k=k.c.ga8()
k.toString
x=y.g
x.a(k)
w=B.bD4()
v=d.c
k.eb(w,v.b.a9(0,d.e.a).a9(0,new B.y(v.gNd().a/2,v.gNd().b/2)))
k=w.a
v=k.length
s=l.$ti
r=0
for(;;){if(!(r<v)){u=null
t=C.x
break}q=k[r]
p=q.a
if(p instanceof A.PM&&s.b(p.bK)){o=s.a(p.bK)
if(o!==l){t=y.d.a(q).c
u=o
break}}++r}if(u==null){l.uE()
return}k=u.c.ga8()
k.toString
k=x.a(k).gA()
x=u.a
v=x.x
s=x.y
n=x.z
m=A.ccz(t,k,x.Q!=null,s!=null,n!=null,v!=null)
if(m==null){l.uE()
return}if(l.f!==u){l.uE()
l.f=u
u.w.sG(!0)}l.r=m},
uE(){var x=this.f
if(x!=null)x.w.sG(!1)
this.r=this.f=null},
ay5(d){var x,w,v,u,t,s=this,r=s.d
if(r==null)return
x=s.f
w=s.r
if(x!=null&&w!=null){v=s.ap2(r,x)
u=x.a
u.toString
t=w.a
switch(t){case 0:break
case 1:break
case 2:break
case 3:break}switch(t){case 0:u=u.x
break
case 1:u=u.y
break
case 2:u=u.z
break
case 3:u=u.Q
break
default:u=null}if(u!=null)u.$1(s.$ti.i("mk<1>").a(r.a))}else{s.a.toString
v=C.x}s.U4(r,v)
u=s.a.ch
if(u!=null)u.$0()},
arl(){var x,w=this.d
if(w==null)return
this.U4(w,C.x)
x=this.a.CW
if(x!=null)x.$0()},
ap2(d,e){var x,w,v=this.c
v.toString
v=B.ja(v,y.o)
v=v==null?null:v.c.ga8()
x=y.h
x.a(v)
w=x.a(e.c.ga8())
if(v==null||w==null)return C.x
return B.bY(w.aG(v),C.x).ae(0,d.c.b)},
U4(d,e){var x,w=this
w.uE()
w.e=null
w.p(new A.biE(w))
x=w.c
x.toString
x=B.ja(x,y.o)
if(x!=null)x.a91(d,e,!0)},
j(d){var x=this,w=null,v=x.a.c,u=v?x.gX1():w,t=v?x.gZO():w,s=v?x.gZN():w
v=v?x.gX0():w
return new A.a68(x,C.P,new B.bg(x,B.dc(C.bt,new B.im(x.w,new A.biG(x),w,w,y.m),!1,w,w,w,w,w,w,w,w,w,v,w,s,u,t,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w),w,x.$ti.i("bg<0>")),w)}}
A.vt.prototype={
K(){return"DragDropEdge."+this.b}}
A.aza.prototype={
gNd(){var x=this.c,w=this.b
return new B.a1(x.a-w.a,x.b-w.b)},
l(d){return"DragBounds(layer: "+this.a.l(0)+", item: "+this.gNd().l(0)+", at: "+this.b.l(0)+")"}}
A.mk.prototype={}
A.a9O.prototype={}
A.QF.prototype={
t(){return new A.B5(B.a([],y.p),C.x,C.x,C.b4,null,null)}}
A.B5.prototype={
gB4(){var x,w=this,v=w.e
if(v===$){x=B.fj(null,null,null,w)
w.e!==$&&B.bE()
w.e=x
v=x}return v},
ad(){this.ah()
var x=this.gB4()
x.f0()
x.ha$.M(0,this.garA())},
m(){this.gB4().m()
this.acS()},
aJL(d){d.e.a_(this.gZP())
this.d.push(d)
this.p(new A.aQw())},
Oa(d){var x=this,w=d.e
w.P(x.gZP())
if(C.b.J(x.d,d)){w.k1$=$.a4()
w.id$=0}if(x.c!=null)x.p(new A.aQx())},
a91(d,e,f){var x,w=this,v=w.c
v.toString
v=B.de(v,null)
v=v==null?null:v.ax
x=v===!0
if(!x)w.a.toString
if(x){w.Oa(d)
return}w.f=d
w.r=d.e.a
w.w=e
w.a.toString
w.x=C.b4
v=w.gB4()
w.a.toString
v.e=C.da
v.lI(0)},
arB(){var x,w,v,u,t,s,r=this,q=r.f
if(q==null)return
x=q.e
w=r.r
v=r.w
u=r.x
t=r.gB4()
s=t.x
s===$&&B.d()
s=B.aIA(w,v,u.aE(s))
s.toString
x.sG(s)
x=t.Q
x===$&&B.d()
if(x===C.cs){r.f=null
r.Oa(q)}},
ay7(){if(this.c!=null)this.p(new A.aQv())},
j(d){var x,w,v,u,t,s,r,q=null,p=this.a
p=B.a([p.r],y.u)
for(x=this.d,w=x.length,v=0;v<x.length;x.length===w||(0,B.F)(x),++v){u=x[v]
t=u.c.b
s=u.e.a
r=u.b
p.push(new B.iF(t.a+s.a,t.b+s.b,q,q,r.a,r.b,new B.vS(!0,u.d,q),q))}return new B.bg(this,B.cd(C.a2,p,C.T,C.an),q,y.B)}}
A.Ym.prototype={
m(){var x=this,w=x.aU$
if(w!=null)w.P(x.geV())
x.aU$=null
x.T()},
bP(){this.dR()
this.dO()
this.eW()}}
A.PM.prototype={}
A.a68.prototype={
aI(d){var x=new A.PM(this.e,this.f,null,new B.bu(),B.aS())
x.aH()
x.sb1(null)
return x},
aM(d,e){e.bK=this.e
e.E=this.f}}
var z=a.updateTypes(["~()","~(iU)","~(kg)","~(fY)","~(vt,C)"])
A.biF.prototype={
$0(){},
$S:0}
A.biE.prototype={
$0(){return this.a.d=null},
$S:0}
A.biG.prototype={
$3(d,e,f){var x,w=this.a
if(w.d!=null){w=w.a
x=w.at
return x==null?B.dY(w.db,null,0.4):x}if(e){w=w.a
x=w.ax
return x==null?w.db:x}return w.a.db},
$S:831}
A.bvX.prototype={
$2(d,e){var x=this.a
if(e<x.b){x.a=d
x.b=e}},
$S:z+4}
A.aQw.prototype={
$0(){},
$S:0}
A.aQx.prototype={
$0(){},
$S:0}
A.aQv.prototype={
$0(){},
$S:0};(function aliases(){var x=A.Ym.prototype
x.acS=x.m})();(function installTearOffs(){var x=a._instance_1u,w=a._instance_0u
var v
x(v=A.Cu.prototype,"gX1","aro",1)
x(v,"gZO","ay6",2)
x(v,"gZN","ay5",3)
w(v,"gX0","arl",0)
w(v=A.B5.prototype,"garA","arB",0)
w(v,"gZP","ay7",0)})();(function inheritance(){var x=a.mixinHard,w=a.inheritMany,v=a.inherit
w(B.r,[A.tT,A.QF])
w(B.t,[A.Cu,A.Ym])
w(B.aA,[A.biF,A.biE,A.aQw,A.aQx,A.aQv])
v(A.biG,B.ap)
v(A.vt,B.dW)
v(A.bvX,B.bG)
w(B.J,[A.aza,A.mk,A.a9O])
v(A.B5,A.Ym)
v(A.PM,B.G2)
v(A.a68,B.bp)
x(A.Ym,B.fa)})()
B.ag(b.typeUniverse,JSON.parse('{"tT":{"r":[],"b":[]},"Cu":{"t":["tT<1>"]},"QF":{"r":[],"b":[]},"B5":{"t":["QF"]},"PM":{"S":[],"bt":["S"],"R":[],"aW":[]},"a68":{"bp":[],"b_":[],"b":[]}}'))
var y=(function rtii(){var x=B.e
return{d:x("v3"),B:x("bg<B5>"),p:x("f<a9O>"),u:x("f<b>"),g:x("S"),o:x("B5"),m:x("im<B>"),k:x("bq<y>"),q:x("bq<B>"),h:x("S?")}})();(function constants(){D.qS=new A.vt(0,"top")
D.CX=new A.vt(1,"left")
D.CY=new A.vt(2,"right")
D.CZ=new A.vt(3,"bottom")})()};
(a=>{a["3ZmPVIIKyjZUlZ56IXqILWU80V4="]=a.current})($__dart_deferred_initializers__);