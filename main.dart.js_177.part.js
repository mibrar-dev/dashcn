((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,B,C,F,A={lr:function lr(d,e){this.a=d
this.b=e},LB:function LB(d,e,f,g){var _=this
_.c=d
_.d=e
_.e=f
_.a=g},b8l:function b8l(){},b8m:function b8m(d){this.a=d},
c0C(d,e,f,g,h,i,j,k,l,m){return new A.qX(e,m,d,l,h,f,g,i,null,k,j)},
LC:function LC(d,e){this.a=d
this.b=e},
qX:function qX(d,e,f,g,h,i,j,k,l,m,n){var _=this
_.e=d
_.f=e
_.r=f
_.w=g
_.x=h
_.y=i
_.z=j
_.a=k
_.b=l
_.c=m
_.d=n},
cuY(d){var x=null,w="Healthy",v=$.c().$2(d,"Activity tracker")
return new B.x(320,x,new A.LB(B.a([new A.lr(B.d($.c().$2(d,w),x,x,x,x,x,x,x,x,x,x,x,x,x),D.jo),new A.lr(B.d($.c().$2(d,"Degraded"),x,x,x,x,x,x,x,x,x,x,x,x,x),D.Xq),new A.lr(B.d($.c().$2(d,"Down"),x,x,x,x,x,x,x,x,x,x,x,x,x),D.Xr),new A.lr(B.d($.c().$2(d,"No data"),x,x,x,x,x,x,x,x,x,x,x,x,x),D.cgA),new A.lr(B.d($.c().$2(d,w),x,x,x,x,x,x,x,x,x,x,x,x,x),D.jo),new A.lr(B.d($.c().$2(d,w),x,x,x,x,x,x,x,x,x,x,x,x,x),D.jo)],y.j),v,x,x),x)},
cu2(d){var x=null,w=A.c0C(x,x,4,24,4,x,x,x,x,x)
return new B.x(320,x,new A.LB(B.a([new A.lr(B.d("One",x,x,x,x,x,x,x,x,x,x,x,x,x),D.jo),new A.lr(B.d("Two",x,x,x,x,x,x,x,x,x,x,x,x,x),D.Xr),new A.lr(B.d($.c().$2(d,"Three"),x,x,x,x,x,x,x,x,x,x,x,x,x),D.Xq)],y.j),x,w,x),x)},
cB6(d){var x=null,w=A.c0C(x,new B.bR(C.dF,1),x,16,x,x,x,x,x,x)
return new B.x(320,x,B.km(new A.LB(B.a([new A.lr(B.d("One",x,x,x,x,x,x,x,x,x,x,x,x,x),D.jo),new A.lr(B.d("Two",x,x,x,x,x,x,x,x,x,x,x,x,x),D.jo),new A.lr(B.d($.c().$2(d,"Three"),x,x,x,x,x,x,x,x,x,x,x,x,x),D.jo)],y.j),x,x,x),w,y.m),x)},
cSZ(){$.c().$2(null,"Default")
$.c().$2(null,"Custom size")
$.c().$2(null,"Themed")
return B.a([new E.v(A.cPP()),new E.v(A.cPO()),new E.v(A.cPQ())],y.d)}},D,E,G
J=c[1]
B=c[0]
C=c[2]
F=c[335]
A=a.updateHolder(c[32],A)
D=c[477]
E=c[242]
G=c[320]
A.lr.prototype={}
A.LB.prototype={
k(d){var x,w,v,u,t,s,r,q,p=null,o=B.h(d),n=y.m,m=B.aL(d,D.cgB,new A.b8l(),this.e,n,n)
n=this.c
if(n.length===0)return C.ab
x=o.a
w=m.y
if(w==null)w=2
v=m.z
u=m.x
t=B.a4(u==null?Math.max(0,o.b.a*16-2):u)
s=B.a([],y.e)
for(r=0;r<n.length;++r){if(r>0)s.push(new B.cj(w,p,p))
q=n[r]
s.push(new B.cx(1,C.ao,new B.u1(new B.x(p,v,new B.i8(m.aXP(q.b).B(x),!0,p,p),p),new A.b8m(q),C.B,p,p),p))}n=this.d
return B.dS(t,n==null?B.R(s,C.l,p,C.c,C.m,0,p):B.be(p,p,B.R(s,C.l,p,C.c,C.m,0,p),!0,p,p,!1,p,!1,p,p,p,p,p,p,p,p,p,n,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p,p))}}
A.LC.prototype={
J(){return"TrackerLevel."+this.b}}
A.qX.prototype={
aXP(d){var x,w=this
switch(d.a){case 0:x=w.e
break
case 1:x=w.f
break
case 2:x=w.r
break
case 3:x=w.w
break
default:x=null}return x},
F(d){var x,w,v,u,t,s=this,r=s.e
if(r==null)r=d.e
x=s.f
if(x==null)x=d.f
w=s.r
if(w==null)w=d.r
v=s.w
if(v==null)v=d.w
u=s.x
if(u==null)u=d.x
t=s.y
if(t==null)t=d.y
return A.c0C(w,r,t,s.z,u,d.a,d.d,d.c,v,x)},
h(d,e){var x=this
if(e==null)return!1
if(x===e)return!0
return e instanceof A.qX&&J.z(e.e,x.e)&&J.z(e.f,x.f)&&J.z(e.r,x.r)&&J.z(e.w,x.w)&&e.x==x.x&&e.y==x.y&&e.z===x.z},
gt(d){var x=this
return B.W(x.a,x.c,x.d,x.e,x.f,x.r,x.w,x.x,x.y,x.z,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a)}}
var z=a.updateTypes(["b(n)","qX(qX)"])
A.b8l.prototype={
$1(d){return d},
$S:z+1}
A.b8m.prototype={
$1(d){return this.a.a},
$S:9};(function installTearOffs(){var x=a._static_1
x(A,"cPP","cuY",0)
x(A,"cPO","cu2",0)
x(A,"cPQ","cB6",0)})();(function inheritance(){var x=a.inherit,w=a.inheritMany
x(A.lr,B.I)
x(A.LB,B.m)
w(B.ax,[A.b8l,A.b8m])
x(A.LC,B.dA)
x(A.qX,B.av)})()
B.ao(b.typeUniverse,JSON.parse('{"LB":{"m":[],"b":[]},"qX":{"av":[]}}'))
var y={d:B.j("i<v>"),j:B.j("i<lr>"),e:B.j("i<b>"),m:B.j("qX")};(function constants(){D.jo=new A.LC(0,"fine")
D.Xq=new A.LC(1,"warning")
D.Xr=new A.LC(2,"critical")
D.cgA=new A.LC(3,"unknown")
D.cgB=new A.qX(G.qG,F.Ur,C.ea,C.bH,null,2,32,null,null,null,null)})()};
(a=>{a["Cp1qnvTOYrcWoUDuEfmHuyYlxLQ="]=a.current})($__dart_deferred_initializers__);