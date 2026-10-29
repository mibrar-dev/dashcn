((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var C,B,A={
cuz(d){var x=null
return new C.x(320,72,A.c5v(F.CR(x,new A.bNc(),20,x,x,B.I,!1)),x)},
cBR(d){var x=null
return new C.x(280,160,A.c5v(F.CR(x,new A.bPM(),20,x,x,B.z,!1)),x)},
cRd(){$.c().$2(null,"Default")
$.c().$2(null,"Vertical")
return C.a([new E.v(A.cPM()),new E.v(A.cPN())],y.d)},
bNc:function bNc(){},
bPM:function bPM(){},
c5v(d){return new A.Ru(d,null)},
cjE(d,e,f,g){var x,w=y.k,v=C.aL(d,D.c8G,new A.aOV(),g,w,w)
w=v.e
x=v.f
return new C.awB(w,x)},
Ru:function Ru(d,e){this.c=d
this.a=e},
aOV:function aOV(){},
a0m:function a0m(d){this.d=d
this.c=this.a=null},
bnt:function bnt(d,e){this.a=d
this.b=e},
bnu:function bnu(d,e,f,g,h,i){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h
_.f=i},
qv:function qv(d,e,f,g,h,i){var _=this
_.e=d
_.f=e
_.a=f
_.b=g
_.c=h
_.d=i},
can(d){if(!isFinite(d))return 0
return B.f.A(d,0,1)},
VN:function VN(d,e,f,g,h,i){var _=this
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
A.Ru.prototype={
q(){return new A.a0m(D.c8C)}}
A.a0m.prototype={
aHg(d){var x,w,v,u,t=d.a,s=t.c
s.toString
x=t.a
x.toString
w=t.b
w.toString
v=t.d
v.toString
t=t.e
u=new A.VN(s,x,w,v,C.cA(t),t)
if(!u.h(0,this.d))this.n(new A.bnt(this,u))
return!1},
k(d){var x,w,v,u,t,s,r,q=this,p=null
q.a.toString
x=A.cjE(d,p,p,p)
w=q.d
v=x.a
u=A.can((w.a-w.b)/v)
w=q.d
t=A.can((w.c-w.a)/v)
s=q.d.e===B.z
r=s?D.c7n:D.c6Y
w=C.h(d)
return new C.fm(q.gaHf(),C.W6(B.jy,q.a.c,new A.bnu(s,r,w.a.b,u,t,x)),p,y.f)}}
A.qv.prototype={
F(d){return new A.qv(this.e,this.f,d.a,null,d.c,d.d)},
h(d,e){if(e==null)return!1
if(this===e)return!0
return e instanceof A.qv&&e.e===this.e&&e.f===this.f},
gt(d){var x=this
return C.W(x.a,x.c,x.d,x.e,x.f,B.a,B.a,B.a,B.a,B.a,B.a,B.a,B.a,B.a,B.a,B.a,B.a,B.a,B.a,B.a)}}
A.VN.prototype={
h(d,e){var x=this
if(e==null)return!1
if(x===e)return!0
return e instanceof A.VN&&e.a===x.a&&e.b===x.b&&e.c===x.c&&e.d===x.d&&e.e===x.e&&e.f===x.f},
gt(d){var x=this
return C.W(x.a,x.b,x.c,x.d,x.e,x.f,B.a,B.a,B.a,B.a,B.a,B.a,B.a,B.a,B.a,B.a,B.a,B.a,B.a,B.a)},
m(d){var x=this
return"ScrollMetricsSnapshot("+C.E(x.b)+"..["+C.E(x.a)+"].."+C.E(x.c)+", viewport: "+C.E(x.d)+")"}}
var z=a.updateTypes(["b(n)","qv(qv)","F(hL)"])
A.bNc.prototype={
$2(d,e){var x=null
return new C.P(B.e0,C.d("Item "+(e+1),x,x,x,x,x,x,x,x,x,x,x,x,x),x)},
$S:99}
A.bPM.prototype={
$2(d,e){var x=null
return new C.P(B.d0,C.d("Row "+(e+1),x,x,x,x,x,x,x,x,x,x,x,x,x),x)},
$S:99}
A.aOV.prototype={
$1(d){return d},
$S:z+1}
A.bnt.prototype={
$0(){this.a.d=this.b},
$S:0}
A.bnu.prototype={
$1(d){var x,w,v=this,u=v.a?d.d-d.b:d.c-d.a,t=v.b,s=v.c
s=C.a([s.aH(0),s,s,s.aH(0)],y.c)
x=u<=0?0:v.f.b/u
w=B.f.A(v.d*x,0,1)
return new C.fN(t.a,t.b,B.bA,s,C.a([0,w,B.f.A(1-v.e*x,w,1),1],y.h),null).pz(d)},
$S:81};(function installTearOffs(){var x=a._static_1,w=a._instance_1u
x(A,"cPM","cuz",0)
x(A,"cPN","cBR",0)
w(A.a0m.prototype,"gaHf","aHg",2)})();(function inheritance(){var x=a.inheritMany,w=a.inherit
x(C.bD,[A.bNc,A.bPM])
w(A.Ru,C.q)
x(C.ax,[A.aOV,A.bnu])
w(A.a0m,C.t)
w(A.bnt,C.aM)
w(A.qv,C.av)
w(A.VN,C.I)})()
C.ao(b.typeUniverse,JSON.parse('{"Ru":{"q":[],"b":[]},"a0m":{"t":["Ru"]},"qv":{"av":[]}}'))
var y={c:C.j("i<ae>"),d:C.j("i<v>"),h:C.j("i<G>"),f:C.j("fm<hL>"),k:C.j("qv")};(function constants(){D.c6Y=new C.a33(B.bJ,B.c9)
D.c7n=new C.a33(B.aH,B.bC)
D.c8C=new A.VN(0,0,0,0,B.z,B.bo)
D.c8G=new A.qv(20,50,null,null,null,null)})()};
(a=>{a["0DFLKlkk+5jWRM0ignPUFnY3bBc="]=a.current})($__dart_deferred_initializers__);