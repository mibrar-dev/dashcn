((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var C,B,A={
cvR(d){var x=null
return new C.w(320,72,A.c6O(F.D_(x,new A.bOh(),20,x,x,B.I,!1)),x)},
cDf(d){var x=null
return new C.w(280,160,A.c6O(F.D_(x,new A.bQV(),20,x,x,B.z,!1)),x)},
cSG(){$.c().$2(null,"Default")
$.c().$2(null,"Vertical")
return C.a([new E.v(A.cRe()),new E.v(A.cRf())],y.d)},
bOh:function bOh(){},
bQV:function bQV(){},
c6O(d){return new A.Rx(d,null)},
cl_(d,e,f,g){var x,w=y.k,v=C.aL(d,D.c9R,new A.aP7(),g,w,w)
w=v.e
x=v.f
return new C.awP(w,x)},
Rx:function Rx(d,e){this.c=d
this.a=e},
aP7:function aP7(){},
a0k:function a0k(d){this.d=d
this.c=this.a=null},
boa:function boa(d,e){this.a=d
this.b=e},
bob:function bob(d,e,f,g,h,i){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h
_.f=i},
qw:function qw(d,e,f,g,h,i){var _=this
_.e=d
_.f=e
_.a=f
_.b=g
_.c=h
_.d=i},
cbH(d){if(!isFinite(d))return 0
return B.f.v(d,0,1)},
VR:function VR(d,e,f,g,h,i){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h
_.f=i}},D,E,F
C=c[0]
B=c[2]
A=a.updateHolder(c[128],A)
D=c[438]
E=c[242]
F=c[231]
A.Rx.prototype={
q(){return new A.a0k(D.c9N)}}
A.a0k.prototype={
aHp(d){var x,w,v,u,t=d.a,s=t.c
s.toString
x=t.a
x.toString
w=t.b
w.toString
v=t.d
v.toString
t=t.e
u=new A.VR(s,x,w,v,C.cC(t),t)
if(!u.h(0,this.d))this.n(new A.boa(this,u))
return!1},
k(d){var x,w,v,u,t,s,r,q=this,p=null
q.a.toString
x=A.cl_(d,p,p,p)
w=q.d
v=x.a
u=A.cbH((w.a-w.b)/v)
w=q.d
t=A.cbH((w.c-w.a)/v)
s=q.d.e===B.z
r=s?D.c8v:D.c85
w=C.h(d)
return new C.fl(q.gaHo(),C.Wa(B.ju,q.a.c,new A.bob(s,r,w.a.b,u,t,x)),p,y.f)}}
A.qw.prototype={
G(d){return new A.qw(this.e,this.f,d.a,null,d.c,d.d)},
h(d,e){if(e==null)return!1
if(this===e)return!0
return e instanceof A.qw&&e.e===this.e&&e.f===this.f},
gt(d){var x=this
return C.X(x.a,x.c,x.d,x.e,x.f,B.a,B.a,B.a,B.a,B.a,B.a,B.a,B.a,B.a,B.a,B.a,B.a,B.a,B.a,B.a)}}
A.VR.prototype={
h(d,e){var x=this
if(e==null)return!1
if(x===e)return!0
return e instanceof A.VR&&e.a===x.a&&e.b===x.b&&e.c===x.c&&e.d===x.d&&e.e===x.e&&e.f===x.f},
gt(d){var x=this
return C.X(x.a,x.b,x.c,x.d,x.e,x.f,B.a,B.a,B.a,B.a,B.a,B.a,B.a,B.a,B.a,B.a,B.a,B.a,B.a,B.a)},
m(d){var x=this
return"ScrollMetricsSnapshot("+C.F(x.b)+"..["+C.F(x.a)+"].."+C.F(x.c)+", viewport: "+C.F(x.d)+")"}}
var z=a.updateTypes(["b(n)","qw(qw)","E(hN)"])
A.bOh.prototype={
$2(d,e){var x=null
return new C.P(B.dY,C.d("Item "+(e+1),x,x,x,x,x,x,x,x,x,x,x,x,x),x)},
$S:100}
A.bQV.prototype={
$2(d,e){var x=null
return new C.P(B.d_,C.d("Row "+(e+1),x,x,x,x,x,x,x,x,x,x,x,x,x),x)},
$S:100}
A.aP7.prototype={
$1(d){return d},
$S:z+1}
A.boa.prototype={
$0(){this.a.d=this.b},
$S:0}
A.bob.prototype={
$1(d){var x,w,v=this,u=v.a?d.d-d.b:d.c-d.a,t=v.b,s=v.c
s=C.a([s.aG(0),s,s,s.aG(0)],y.c)
x=u<=0?0:v.f.b/u
w=B.f.v(v.d*x,0,1)
return new C.fK(t.a,t.b,B.bD,s,C.a([0,w,B.f.v(1-v.e*x,w,1),1],y.h),null).pA(d)},
$S:93};(function installTearOffs(){var x=a._static_1,w=a._instance_1u
x(A,"cRe","cvR",0)
x(A,"cRf","cDf",0)
w(A.a0k.prototype,"gaHo","aHp",2)})();(function inheritance(){var x=a.inheritMany,w=a.inherit
x(C.bF,[A.bOh,A.bQV])
w(A.Rx,C.q)
x(C.ax,[A.aP7,A.bob])
w(A.a0k,C.t)
w(A.boa,C.aN)
w(A.qw,C.av)
w(A.VR,C.I)})()
C.ap(b.typeUniverse,JSON.parse('{"Rx":{"q":[],"b":[]},"a0k":{"t":["Rx"]},"qw":{"av":[]}}'))
var y={c:C.j("i<ae>"),d:C.j("i<v>"),h:C.j("i<G>"),f:C.j("fl<hN>"),k:C.j("qw")};(function constants(){D.c85=new C.a33(B.bI,B.cb)
D.c8v=new C.a33(B.aI,B.bA)
D.c9N=new A.VR(0,0,0,0,B.z,B.bp)
D.c9R=new A.qw(20,50,null,null,null,null)})()};
(a=>{a["RYGMxUqHGvPTb1Fq37WgdSinVdE="]=a.current})($__dart_deferred_initializers__);