((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,C,D,B={mv:function mv(d,e){this.a=d
this.b=e},Hq:function Hq(d,e,f,g){var _=this
_.c=d
_.d=e
_.e=f
_.a=g},aTl:function aTl(){},aTm:function aTm(d){this.a=d},Hr:function Hr(d,e){this.a=d
this.b=e},kA:function kA(d,e,f,g,h,i,j,k,l,m){var _=this
_.d=d
_.e=e
_.f=f
_.r=g
_.w=h
_.x=i
_.y=j
_.a=k
_.b=l
_.c=m},
bYU(d){return A.bYl},
bYf(d){return A.bY_},
c2s(d){return A.bY4}},A,E,F
J=c[1]
C=c[0]
D=c[2]
B=a.updateHolder(c[139],B)
A=c[249]
E=c[216]
F=c[397]
B.mv.prototype={}
B.Hq.prototype={
j(d){var x,w,v,u,t,s,r,q,p,o=null,n=C.h(d),m=y.m,l=C.aF(d,A.cb_,new B.aTl(),this.e,m,m)
m=this.c
x=m.length
if(x===0)return D.aa
w=n.a
v=l.x
if(v==null)v=2
u=l.y
t=l.w
s=C.ab(t==null?Math.max(0,n.b.a*16-2):t)
r=C.a([],y.e)
for(q=0;q<x;++q){if(q>0)r.push(new C.c2(v,o,o))
p=m[q]
r.push(new C.by(1,D.X,new C.qF(new C.A(o,u,new C.iu(l.aFx(p.b).H(w),!0,o,o),o),new B.aTm(p),D.O,o),o))}m=this.d
return C.fC(s,m==null?C.M(r,D.m,o,D.c,D.j,0,o):C.bJ(o,o,C.M(r,D.m,o,D.c,D.j,0,o),!0,o,o,!1,o,!1,o,o,o,o,o,o,o,o,o,m,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o))}}
B.Hr.prototype={
K(){return"TrackerLevel."+this.b}}
B.kA.prototype={
aFx(d){var x,w=this
switch(d.a){case 0:x=w.d
break
case 1:x=w.e
break
case 2:x=w.f
break
case 3:x=w.r
break
default:x=null}return x},
F(d){var x,w,v,u,t,s=this,r=s.d
if(r==null)r=d.d
x=s.e
if(x==null)x=d.e
w=s.f
if(w==null)w=d.f
v=s.r
if(v==null)v=d.r
u=s.w
if(u==null)u=d.w
t=s.x
if(t==null)t=d.x
return new B.kA(r,x,w,v,u,t,s.y,d.a,d.b,d.c)},
h(d,e){var x=this
if(e==null)return!1
if(x===e)return!0
return e instanceof B.kA&&J.x(e.d,x.d)&&J.x(e.e,x.e)&&J.x(e.f,x.f)&&J.x(e.r,x.r)&&e.w==x.w&&e.x==x.x&&e.y===x.y},
gq(d){var x=this
return C.P(x.a,x.b,x.c,x.d,x.e,x.f,x.r,x.w,x.x,x.y,D.a,D.a,D.a,D.a,D.a,D.a,D.a,D.a,D.a,D.a)}}
var z=a.updateTypes(["b(l)","kA(kA)"])
B.aTl.prototype={
$1(d){return d},
$S:z+1}
B.aTm.prototype={
$1(d){return this.a.a},
$S:11};(function installTearOffs(){var x=a._static_1
x(B,"c7n","bYU",0)
x(B,"c7m","bYf",0)
x(B,"c7o","c2s",0)})();(function inheritance(){var x=a.inherit,w=a.inheritMany
x(B.mv,C.J)
x(B.Hq,C.i)
w(C.ap,[B.aTl,B.aTm])
x(B.Hr,C.dW)
x(B.kA,C.ao)})()
C.ag(b.typeUniverse,JSON.parse('{"Hq":{"i":[],"b":[]},"kA":{"ao":[]}}'))
var y={j:C.e("f<mv>"),e:C.e("f<b>"),m:C.e("kA")};(function constants(){var x=a.makeConstList
A.a8w=new E.z(B.c7n())
A.a82=new E.z(B.c7m())
A.aaT=new E.z(B.c7o())
A.bGs=x([A.a8w,A.a82,A.aaT],C.e("f<z>"))
A.a_6=A.bGs
A.c5S=new C.o("One",null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)
A.oF=new B.Hr(0,"fine")
A.Um=new B.mv(A.c5S,A.oF)
A.TX=new C.o("Two",null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)
A.Uo=new B.Hr(2,"critical")
A.caS=new B.mv(A.TX,A.Uo)
A.TB=new C.o("Three",null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)
A.Un=new B.Hr(1,"warning")
A.caX=new B.mv(A.TB,A.Un)
A.brH=x([A.Um,A.caS,A.caX],y.j)
A.cb1=new B.kA(null,null,null,null,4,4,24,null,null,null)
A.cb2=new B.Hq(A.brH,null,A.cb1,null)
A.bY_=new C.A(320,null,A.cb2,null)
A.cb0=new B.kA(D.az,null,null,null,null,null,16,null,null,null)
A.caU=new B.mv(A.TX,A.oF)
A.caV=new B.mv(A.TB,A.oF)
A.bGA=x([A.Um,A.caU,A.caV],y.j)
A.cb4=new B.Hq(A.bGA,null,null,null)
A.abr=new C.ke(A.cb0,A.cb4,null,C.e("ke<kA>"))
A.bY4=new C.A(320,null,A.abr,null)
A.c9d=new C.o("Healthy",null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)
A.vX=new B.mv(A.c9d,A.oF)
A.c67=new C.o("Degraded",null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)
A.caT=new B.mv(A.c67,A.Un)
A.c4y=new C.o("Down",null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)
A.caW=new B.mv(A.c4y,A.Uo)
A.c8u=new C.o("No data",null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)
A.caZ=new B.Hr(3,"unknown")
A.caY=new B.mv(A.c8u,A.caZ)
A.br3=x([A.vX,A.caT,A.caW,A.caY,A.vX,A.vX],y.j)
A.cb3=new B.Hq(A.br3,"Activity tracker",null,null)
A.bYl=new C.A(320,null,A.cb3,null)
A.bUs=new C.cG(D.a2S,1)
A.cb_=new B.kA(F.uA,A.bUs,D.di,D.c9,null,2,32,null,null,null)})()};
(a=>{a["k2HBLzxKbz8Y5hWBTxuBZwIxQq0="]=a.current})($__dart_deferred_initializers__);