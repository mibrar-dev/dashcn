((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,C,D,B={a_i:function a_i(d,e,f,g,h,i,j){var _=this
_.b=d
_.c=e
_.d=f
_.e=g
_.f=h
_.r=i
_.a=j},aaU:function aaU(d,e){this.w=d
this.a=e},aaV:function aaV(d){this.a=d},
cAi(d){var x=null,w=A.h(d).x.a*4
return new A.w(320,x,D.Jz(x,x,x,E.ch0,new A.O(w,w,w,w),x,x,x),x)},
cAj(d){var x=null,w=A.lI(20)
return new A.w(320,x,D.Jz(x,x,A.rE(new A.b9(24,24)),A.d($.c().$2(d,"Rounded corners"),x,x,x,x,x,x,x,x,x,x,x,x,x),w,x,x,x),x)},
cAk(d){var x,w=null,v=A.h(d),u=A.lI(16)
u=D.Jz(new A.bS(C.dD,1),w,w,A.d($.c().$2(d,"Translucent primary fill"),w,w,w,w,w,w,w,w,w,w,w,w,w),u,w,0.12,w)
v=A.o(v.x.a*4,w)
x=A.lI(16)
return A.u(A.a([new A.w(320,w,u,w),v,new A.w(320,w,D.Jz(w,w,w,A.d($.c().$2(d,"Backdrop blur"),w,w,w,w,w,w,w,w,w,w,w,w,w),x,12,0.6,w),w)],y.u),C.p,w,C.c,C.j,0,C.h)},
cAh(d){var x=null,w=A.h(d)
return new A.w(320,x,A.u(A.a([new B.aaU(new A.P(A.lI(16),A.d($.c().$2(d,"Dashed container"),x,x,x,x,x,x,x,x,x,x,x,x,x),x),x),A.o(w.x.a*4,x),E.anP],y.u),C.q,x,C.c,C.j,0,C.h),x)},
cJe(){var x=null
$.c().$2(x,"Default")
$.c().$2(x,"Rounded")
$.c().$2(x,"Translucent")
$.c().$2(x,"Dashed")
return A.a([new F.v(B.cRY()),new F.v(B.cRZ()),new F.v(B.cS_()),new F.v(B.cRX())],y.t)}},E,F
J=c[1]
A=c[0]
C=c[2]
D=c[215]
B=a.updateHolder(c[124],B)
E=c[422]
F=c[242]
B.a_i.prototype={
av(d,a0){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h=this,g=null,f=h.b,e=h.c+f
if(e<=0)return
x=$.aq().r
w=y.a
v=new A.ck(x,C.ai,g,g,A.a([],w))
u=h.r
if(u==null)u=C.bi
t=a0.a
if(h.f)v.aH(new A.iw(A.b_a(new A.T(0,0,0+t,0+a0.b),u.c,u.d,u.a,u.b)))
else{v.aH(new A.fL(0,0))
v.aH(new A.du(t,0))}t=A.a([],w)
s=new A.ck(x,C.ai,g,g,t)
for(x=A.I3(v),r=A.a([],y.C),q=new A.Cf(x,!1,r),p=x.a,o=y.r;q.u();){n=q.c
if(n===0||q.f)A.aH(A.wf('PathMetricIterator is not pointing to a PathMetric. This can happen in two situations:\n- The iteration has not started yet. If so, call "moveNext" to start iteration.\n- The iterator ran out of elements. If so, check that "moveNext" returns true prior to calling "current".'));--n
m=new A.Ce(q,n)
l=0
for(;;){q.o8()
k=r[n].b
k===$&&A.f()
if(!(l<k.a.length()))break
q.o8()
k=r[n].b
k===$&&A.f()
j=Math.min(l+f,k.a.length())
k=x.b
i=A.hj(A.a([],w),!0,o)
k=new A.uG(new A.ck(p,k,g,new A.un([m,l,j,!0]),i),C.y,g)
t.push(k)
i=s.f
if(i!=null)k.bU(i)
k=s.e
if(k!=null)k.a.delete()
s.e=null
l+=e}}$.aq()
f=A.bm()
f.r=h.e.I()
f.c=h.d
f.b=C.b2
d.fA(s,f)},
cd(d){var x=this
return d.b!==x.b||d.c!==x.c||d.d!==x.d||!d.e.h(0,x.e)||d.f!==x.f||!J.z(d.r,x.r)}}
B.aaU.prototype={
k(d){var x=A.h(d),w=x.f,v=A.a5(x.b.a*16)
d.S(y.o).toString
return A.dF(this.w,null,!1,null,new B.a_i(8*w,5*w,w,x.a.CW,!0,v,null),C.ag,!1)}}
B.aaV.prototype={
k(d){var x=null,w=A.h(d),v=w.f
return A.dF(x,x,!1,x,new B.a_i(8*v,5*v,v,w.a.CW,!1,x,x),C.ag,!1)}}
var z=a.updateTypes(["b(n)"]);(function installTearOffs(){var x=a._static_1
x(B,"cRY","cAi",0)
x(B,"cRZ","cAj",0)
x(B,"cS_","cAk",0)
x(B,"cRX","cAh",0)})();(function inheritance(){var x=a.inherit,w=a.inheritMany
x(B.a_i,A.iB)
w(A.m,[B.aaU,B.aaV])})()
A.ap(b.typeUniverse,JSON.parse('{"a_i":{"az":[]},"aaU":{"m":[],"b":[]},"aaV":{"m":[],"b":[]}}'))
var y={o:A.j("dr"),C:A.j("i<a8l>"),t:A.j("i<v>"),a:A.j("i<e1>"),u:A.j("i<b>"),r:A.j("e1")};(function constants(){E.anP=new B.aaV(null)
E.ch0=new A.a4("Outlined container",null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)})()};
(a=>{a["JghUkwXtJ85zwpaj0FrTW76tM4Q="]=a.current})($__dart_deferred_initializers__);