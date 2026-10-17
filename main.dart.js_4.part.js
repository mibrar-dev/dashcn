((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var B,C,A={asV:function asV(){},aGv:function aGv(d,e){this.a=d
this.b=e},OP:function OP(d){this.a=d},OQ:function OQ(d){this.a=null
this.b=d},OR:function OR(d,e){this.c=d
this.a=e},aki:function aki(d){this.d=d
this.c=this.a=null},Fv:function Fv(d,e,f){this.e=d
this.c=e
this.a=f},a8_:function a8_(d,e,f,g,h){var _=this
_.E=d
_.a3=e
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
_.dx=$},ajq:function ajq(d,e,f){var _=this
_.a=d
_.b=e
_.id$=0
_.k1$=f
_.k3$=_.k2$=0},
bOr(){return new A.ym(null)},
ym:function ym(d){this.a=d},
adN:function adN(){this.d="tap a row"
this.c=this.a=null},
aV8:function aV8(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},
aV6:function aV6(d,e){this.a=d
this.b=e},
aV5:function aV5(d,e,f){this.a=d
this.b=e
this.c=f},
aV7:function aV7(d){this.a=d}}
B=c[0]
C=c[2]
A=a.updateHolder(c[28],A)
A.asV.prototype={}
A.aGv.prototype={}
A.OP.prototype={}
A.OQ.prototype={
a3i(d){var x=this.b.k(0,d)
if(x==null){x=this.a
x=x==null?null:x.a3i(d)}return x}}
A.OR.prototype={
t(){return new A.aki(new A.OQ(B.H(y.o,y.l)))}}
A.aki.prototype={
aY(){this.bs()
var x=this.c
x.toString
this.d.a=B.bH(x,y.h)},
j(d){return new B.bg(this.d,this.a.c,null,y.j)}}
A.Fv.prototype={
aI(d){var x=B.ja(d,y.h)
x.toString
x=new A.a8_(this.e,x,null,new B.bu(),B.aS())
x.aH()
x.sb1(null)
return x},
aM(d,e){var x,w=this.e,v=B.ja(d,y.h)
v.toString
x=e.E
if(x!==w||e.a3!==v){e.a3.b.J(0,x)
e.E=w
e.a3=v
if(e.y!=null)v.b.n(0,w,new A.OP(e))}}}
A.a8_.prototype={
ar(d){var x=this
x.oS(d)
x.a3.b.n(0,x.E,new A.OP(x))},
ai(){this.a3.b.J(0,this.E)
this.mi()}}
A.ajq.prototype={
ga2p(){var x=this.b.a3i(this.a),w=x==null?null:x.a
return w!=null&&w.y!=null?w:null}}
A.ym.prototype={
t(){return new A.adN()}}
A.adN.prototype={
aur(d,e){var x,w=B.ja(d,y.h),v=new A.aGv("row-anchor",w),u=v.b
u.toString
w=$.a4()
x=new A.ajq(v.a,u,w)
this.p(new A.aV8(this,x.ga2p(),e,x))
x.k1$=w
x.id$=0},
j(d){return B.hs(this.auq(d),C.t)},
auq(d){var x,w,v=null,u=B.h(d),t=B.a([B.j(this.d,v,v,v,v,v,v,v,v,v,v,v,v,v),new B.A(v,B.h(d).w.a*3,v,v)],y.e)
for(x=["first","second"],w=0;w<2;++w)t.push(new B.I(C.fj,new A.OR(new B.av(new A.aV6(this,x[w]),v),v),v))
t.push(new B.A(v,B.h(d).w.a*3,v,v))
t.push(new B.av(new A.aV7(this),v))
return B.bm(new B.I(C.cg,B.u(t,C.o,C.c,C.i,0,C.h),v),u.a.b,!0)}}
var z=a.updateTypes(["Fv(l)"])
A.aV8.prototype={
$0(){var x=this,w=x.b,v=x.c
w=w==null?v+": no anchor":v+": "+C.f.a7(w.gA().a,0)+"x"+C.f.a7(w.gA().b,0)+" visible="+(x.d.ga2p()!=null)+" tracking=true"
x.a.d=w},
$S:0}
A.aV6.prototype={
$1(d){var x=null,w=this.b
return new A.Fv("row-anchor",B.T(!1,B.j(w+" row",x,x,x,x,x,x,x,x,x,x,x,x,x),x,x,x,x,x,x,x,new A.aV5(this.a,d,w),x,x,C.C,x,x,x,x,C.A),x)},
$S:z+0}
A.aV5.prototype={
$0(){return this.a.aur(this.b,this.c)},
$S:0}
A.aV7.prototype={
$1(d){var x=null,w=B.h(d)
return B.bm(new B.I(C.eu,B.j("dark tokens / "+this.a.d,x,x,x,x,x,x,x,x,x,x,x,x,x),x),w.a.b,!0)},
$S:87};(function inheritance(){var x=a.inheritMany,w=a.inherit
x(B.J,[A.asV,A.OP,A.OQ])
w(A.aGv,A.asV)
x(B.r,[A.OR,A.ym])
x(B.t,[A.aki,A.adN])
w(A.Fv,B.bp)
w(A.a8_,B.oi)
w(A.ajq,B.ev)
x(B.aA,[A.aV8,A.aV5])
x(B.ap,[A.aV6,A.aV7])})()
B.ag(b.typeUniverse,JSON.parse('{"OR":{"r":[],"b":[]},"Fv":{"bp":[],"b_":[],"b":[]},"aki":{"t":["OR"]},"a8_":{"S":[],"bt":["S"],"R":[],"aW":[]},"ajq":{"as":[]},"ym":{"r":[],"b":[]},"adN":{"t":["ym"]}}'))
var y={j:B.e("bg<OQ>"),e:B.e("f<b>"),o:B.e("J"),l:B.e("OP"),h:B.e("OQ")}};
(a=>{a["moILNe2E+MOuc8+mHLSktjvhGFY="]=a.current})($__dart_deferred_initializers__);