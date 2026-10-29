((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var B,C,A={aET:function aET(){},aUT:function aUT(d,e){this.a=d
this.b=e},U5:function U5(d){this.a=d},U6:function U6(d){this.a=null
this.b=d},U7:function U7(d,e){this.c=d
this.a=e},av6:function av6(d){this.d=d
this.c=this.a=null},Js:function Js(d,e,f){this.e=d
this.c=e
this.a=f},ahd:function ahd(d,e,f,g,h){var _=this
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
_.dx=$},au9:function au9(d,e,f){var _=this
_.a=d
_.b=e
_.id$=0
_.k1$=f
_.k3$=_.k2$=0},
chE(){return new A.xr(null)},
xr:function xr(d){this.a=d},
anC:function anC(d){this.d=d
this.c=this.a=null},
bas:function bas(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},
baq:function baq(d,e){this.a=d
this.b=e},
bap:function bap(d,e,f){this.a=d
this.b=e
this.c=f},
bar:function bar(d){this.a=d}}
B=c[0]
C=c[2]
A=a.updateHolder(c[105],A)
A.aET.prototype={}
A.aUT.prototype={}
A.U5.prototype={}
A.U6.prototype={
af8(d){var x=this.b.j(0,d)
if(x==null){x=this.a
x=x==null?null:x.af8(d)}return x}}
A.U7.prototype={
q(){return new A.av6(new A.U6(B.S(y.o,y.l)))}}
A.av6.prototype={
aW(){this.bg()
var x=this.c
x.toString
this.d.a=B.bQ(x,y.h)},
k(d){return new B.bA(this.d,this.a.c,null,y.j)}}
A.Js.prototype={
aM(d){var x=B.jZ(d,y.h)
x.toString
x=new A.ahd(this.e,x,null,new B.bM(),B.b2())
x.aL()
x.sb3(null)
return x},
aR(d,e){var x,w=this.e,v=B.jZ(d,y.h)
v.toString
x=e.K
if(x!==w||e.a5!==v){e.a5.b.M(0,x)
e.K=w
e.a5=v
if(e.y!=null)v.b.p(0,w,new A.U5(e))}}}
A.ahd.prototype={
aA(d){var x=this
x.ws(d)
x.a5.b.p(0,x.K,new A.U5(x))},
ap(){this.a5.b.M(0,this.K)
this.t7()}}
A.au9.prototype={
gaek(){var x=this.b.af8(this.a),w=x==null?null:x.a
return w!=null&&w.y!=null?w:null}}
A.xr.prototype={
q(){return new A.anC($.c().$2(null,"tap a row"))}}
A.anC.prototype={
aL2(d,e){var x,w=B.jZ(d,y.h),v=new A.aUT("row-anchor",w),u=v.b
u.toString
w=$.a3()
x=new A.au9(v.a,u,w)
this.n(new A.bas(this,x.gaek(),e,x))
x.k1$=w
x.id$=0},
k(d){var x=B.dt(d)
if(x==null)x=C.x
return B.hg(this.aL1(d),x)},
aL1(d){var x,w,v=null,u=B.h(d),t=B.a([B.d(this.d,v,v,v,v,v,v,v,v,v,v,v,v,v),new B.x(v,B.h(d).x.a*3,v,v)],y.e)
for(x=["first","second"],w=0;w<2;++w)t.push(new B.P(C.fI,new A.U7(new B.aC(new A.baq(this,x[w]),v),v),v))
t.push(new B.x(v,B.h(d).x.a*3,v,v))
t.push(new B.aC(new A.bar(this),v))
return B.bu(new B.P(C.cN,B.u(t,C.p,v,C.c,C.j,0,C.i),v),u.a.b,!0)}}
var z=a.updateTypes(["Js(n)"])
A.bas.prototype={
$0(){var x=this,w=x.b,v=x.c
w=w==null?v+": no anchor":v+": "+C.f.a8(w.gD().a,0)+"x"+C.f.a8(w.gD().b,0)+" visible="+(x.d.gaek()!=null)+" tracking=true"
x.a.d=w},
$S:0}
A.baq.prototype={
$1(d){var x=null,w=this.b
return new A.Js("row-anchor",B.X(!1,B.d(w+" row",x,x,x,x,x,x,x,x,x,x,x,x,x),x,x,x,x,x,x,x,x,new A.bap(this.a,d,w),x,x,C.G,x,x,x,x,C.E),x)},
$S:z+0}
A.bap.prototype={
$0(){return this.a.aL2(this.b,this.c)},
$S:0}
A.bar.prototype={
$1(d){var x=null,w=B.h(d)
return B.bu(new B.P(C.e0,B.d("dark tokens / "+this.a.d,x,x,x,x,x,x,x,x,x,x,x,x,x),x),w.a.b,!0)},
$S:108};(function inheritance(){var x=a.inheritMany,w=a.inherit
x(B.I,[A.aET,A.U5,A.U6])
w(A.aUT,A.aET)
x(B.q,[A.U7,A.xr])
x(B.t,[A.av6,A.anC])
w(A.Js,B.bC)
w(A.ahd,B.mN)
w(A.au9,B.ew)
x(B.aM,[A.bas,A.bap])
x(B.ax,[A.baq,A.bar])})()
B.ao(b.typeUniverse,JSON.parse('{"U7":{"q":[],"b":[]},"Js":{"bC":[],"b7":[],"b":[]},"av6":{"t":["U7"]},"ahd":{"Y":[],"bO":["Y"],"Z":[],"b6":[]},"au9":{"az":[]},"xr":{"q":[],"b":[]},"anC":{"t":["xr"]}}'))
var y={j:B.j("bA<U6>"),e:B.j("i<b>"),o:B.j("I"),l:B.j("U5"),h:B.j("U6")}};
(a=>{a["K4sr61Gyqpbf1bUxxiuA+3aB87A="]=a.current})($__dart_deferred_initializers__);