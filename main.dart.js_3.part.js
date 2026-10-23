((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var B,C,A={aF8:function aF8(){},aV7:function aV7(d,e){this.a=d
this.b=e},U9:function U9(d){this.a=d},Ua:function Ua(d){this.a=null
this.b=d},Ub:function Ub(d,e){this.c=d
this.a=e},avi:function avi(d){this.d=d
this.c=this.a=null},JA:function JA(d,e,f){this.e=d
this.c=e
this.a=f},aho:function aho(d,e,f,g,h){var _=this
_.K=d
_.a5=e
_.H$=f
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
_.dx=$},aul:function aul(d,e,f){var _=this
_.a=d
_.b=e
_.id$=0
_.k1$=f
_.k3$=_.k2$=0},
cj_(){return new A.xz(null)},
xz:function xz(d){this.a=d},
anN:function anN(d){this.d=d
this.c=this.a=null},
baZ:function baZ(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},
baX:function baX(d,e){this.a=d
this.b=e},
baW:function baW(d,e,f){this.a=d
this.b=e
this.c=f},
baY:function baY(d){this.a=d}}
B=c[0]
C=c[2]
A=a.updateHolder(c[105],A)
A.aF8.prototype={}
A.aV7.prototype={}
A.U9.prototype={}
A.Ua.prototype={
afh(d){var x=this.b.j(0,d)
if(x==null){x=this.a
x=x==null?null:x.afh(d)}return x}}
A.Ub.prototype={
q(){return new A.avi(new A.Ua(B.S(y.o,y.l)))}}
A.avi.prototype={
aW(){this.bg()
var x=this.c
x.toString
this.d.a=B.bR(x,y.h)},
k(d){return new B.bA(this.d,this.a.c,null,y.j)}}
A.JA.prototype={
aN(d){var x=B.k0(d,y.h)
x.toString
x=new A.aho(this.e,x,null,new B.bL(),B.b2())
x.aL()
x.sb3(null)
return x},
aR(d,e){var x,w=this.e,v=B.k0(d,y.h)
v.toString
x=e.K
if(x!==w||e.a5!==v){e.a5.b.M(0,x)
e.K=w
e.a5=v
if(e.y!=null)v.b.p(0,w,new A.U9(e))}}}
A.aho.prototype={
aA(d){var x=this
x.wt(d)
x.a5.b.p(0,x.K,new A.U9(x))},
ap(){this.a5.b.M(0,this.K)
this.t9()}}
A.aul.prototype={
gaet(){var x=this.b.afh(this.a),w=x==null?null:x.a
return w!=null&&w.y!=null?w:null}}
A.xz.prototype={
q(){return new A.anN($.c().$2(null,"tap a row"))}}
A.anN.prototype={
aLc(d,e){var x,w=B.k0(d,y.h),v=new A.aV7("row-anchor",w),u=v.b
u.toString
w=$.a3()
x=new A.aul(v.a,u,w)
this.n(new A.baZ(this,x.gaet(),e,x))
x.k1$=w
x.id$=0},
k(d){var x=B.ds(d)
if(x==null)x=C.x
return B.hh(this.aLb(d),x)},
aLb(d){var x,w,v=null,u=B.h(d),t=B.a([B.d(this.d,v,v,v,v,v,v,v,v,v,v,v,v,v),new B.w(v,B.h(d).x.a*3,v,v)],y.e)
for(x=["first","second"],w=0;w<2;++w)t.push(new B.P(C.fJ,new A.Ub(new B.aC(new A.baX(this,x[w]),v),v),v))
t.push(new B.w(v,B.h(d).x.a*3,v,v))
t.push(new B.aC(new A.baY(this),v))
return B.bt(new B.P(C.cN,B.u(t,C.p,v,C.c,C.j,0,C.h),v),u.a.b,!0)}}
var z=a.updateTypes(["JA(n)"])
A.baZ.prototype={
$0(){var x=this,w=x.b,v=x.c
w=w==null?v+": no anchor":v+": "+C.f.a6(w.gD().a,0)+"x"+C.f.a6(w.gD().b,0)+" visible="+(x.d.gaet()!=null)+" tracking=true"
x.a.d=w},
$S:0}
A.baX.prototype={
$1(d){var x=null,w=this.b
return new A.JA("row-anchor",B.U(!1,B.d(w+" row",x,x,x,x,x,x,x,x,x,x,x,x,x),x,x,x,x,x,x,x,x,new A.baW(this.a,d,w),x,x,C.G,x,x,x,x,C.F),x)},
$S:z+0}
A.baW.prototype={
$0(){return this.a.aLc(this.b,this.c)},
$S:0}
A.baY.prototype={
$1(d){var x=null,w=B.h(d)
return B.bt(new B.P(C.dY,B.d("dark tokens / "+this.a.d,x,x,x,x,x,x,x,x,x,x,x,x,x),x),w.a.b,!0)},
$S:94};(function inheritance(){var x=a.inheritMany,w=a.inherit
x(B.I,[A.aF8,A.U9,A.Ua])
w(A.aV7,A.aF8)
x(B.q,[A.Ub,A.xz])
x(B.t,[A.avi,A.anN])
w(A.JA,B.bB)
w(A.aho,B.lY)
w(A.aul,B.ex)
x(B.aN,[A.baZ,A.baW])
x(B.ax,[A.baX,A.baY])})()
B.ap(b.typeUniverse,JSON.parse('{"Ub":{"q":[],"b":[]},"JA":{"bB":[],"ba":[],"b":[]},"avi":{"t":["Ub"]},"aho":{"Z":[],"bO":["Z"],"Y":[],"b7":[]},"aul":{"az":[]},"xz":{"q":[],"b":[]},"anN":{"t":["xz"]}}'))
var y={j:B.j("bA<Ua>"),e:B.j("i<b>"),o:B.j("I"),l:B.j("U9"),h:B.j("Ua")}};
(a=>{a["EoYx6+wloKb514lK3L0uxGdaA5g="]=a.current})($__dart_deferred_initializers__);