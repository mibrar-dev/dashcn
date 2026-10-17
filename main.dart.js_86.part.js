((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,C,A,B={
DX(d,e,f,g){return new B.a32(e,f,g,d,null)},
bDT(d,e){var x,w,v,u
if(d.length<2)return d
x=y.u
w=C.a([],x)
for(v=0;v<d.length;++v){u=C.a([],x)
if(v>0)u.push(e)
u.push(d[v])
A.b.C(w,u)}return w},
a32:function a32(d,e,f,g,h){var _=this
_.c=d
_.d=e
_.e=f
_.r=g
_.a=h},
az5:function az5(){},
az4:function az4(d,e){this.a=d
this.b=e},
aof:function aof(d,e,f,g,h,i){var _=this
_.c=d
_.d=e
_.e=f
_.f=g
_.r=h
_.a=i},
agM:function agM(d,e,f,g){var _=this
_.c=d
_.d=e
_.e=f
_.a=g},
z4:function z4(d,e,f,g,h){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h},
kZ:function kZ(d,e,f,g,h,i,j,k){var _=this
_.d=d
_.e=e
_.f=f
_.r=g
_.w=h
_.a=i
_.b=j
_.c=k}},D,E
J=c[1]
C=c[0]
A=c[2]
B=a.updateHolder(c[190],B)
D=c[478]
E=c[427]
B.a32.prototype={
j(d){var x,w,v,u,t=this,s=null,r=C.h(d),q=y.z,p=C.aF(d,D.bgs,new B.az5(),s,q,q),o=p.f
if(o==null)o=r.w.a*2*r.f
q=p.r
if(q==null)q=A.iu
x=C.cf(q,r.r.c*r.f)
d.Z(y.o).toString
q=C.a([],y.u)
for(w=t.d,v=0;v<w;++v)q.push(t.aiy(d,r,p,v,o))
u=t.e==null?o:0
return new C.I(x,t.r===A.B?C.M(B.bDT(q,new C.A(u,s,s,s)),A.m,s,A.c,A.i,0,s):C.u(B.bDT(q,new C.A(s,u,s,s)),A.m,A.c,A.i,0,A.h),s)},
aiy(d,e,f,g,h){var x,w,v,u=this,t=null,s=g===u.c,r=s?f.d:f.e
if(r==null)r=s?D.CV:D.CW
x=r.d
if(x==null)x=12*e.f
w=f.w
w.toString
v=new B.aof(r,x,w,e.a,e.f,t)
if(u.e==null)return C.bJ(t,t,v,!1,t,t,!1,t,!1,t,t,t,t,t,t,t,t,t,"Page "+(g+1)+" of "+u.d,t,t,t,t,t,t,t,t,t,t,t,t,t,t,s,t,t,t,t,t,t,t,t)
w=h/2
return C.bJ(t,t,C.cp(t,!1,A.P,v,t,!1,!0,t,!0,t,t,E.UV,t,t,t,t,new B.az4(u,g),t,t,t,new C.bR(new C.K(w,w,w,w),y.B),t,t,t),!1,t,t,!1,t,!1,t,t,t,t,t,t,t,t,t,"Page "+(g+1)+" of "+u.d,t,t,t,t,t,t,t,t,t,t,t,t,t,t,s,t,t,t,t,t,t,t,t)},
gL(d){return this.d}}
B.aof.prototype={
j(d){var x,w,v=this,u=null,t=C.bH(d,y.i),s=t==null?u:t.a
if(s==null)s=A.bz
t=v.c
x=t.d
if(x==null)x=12*v.r
t=t.a.H(s)
t=t==null?u:t.H(v.f)
w=C.ab(x/2)
return new B.agM(v.d,v.e,new C.a2(t,u,u,w,u,u,A.q),u)}}
B.agM.prototype={
j(d){var x=null,w=this.c
return C.Kb(x,A.n,A.b4,this.e,this.d,w,x,x,x,w)}}
B.z4.prototype={
F(d){var x,w,v,u,t
if(d==null)return this
x=d.a
w=this.a.F(x)
x=w
w=d.b
v=d.c
u=this.d
if(u==null)u=d.d
t=d.e
return new B.z4(x,w,v,u,t)},
h(d,e){var x
if(e==null)return!1
if(this===e)return!0
x=!1
if(e instanceof B.z4)if(e.a.h(0,this.a))x=e.d==this.d
return x},
gq(d){var x=this
return C.P(x.a,x.b,x.c,x.d,x.e,A.a,A.a,A.a,A.a,A.a,A.a,A.a,A.a,A.a,A.a,A.a,A.a,A.a,A.a,A.a)}}
B.kZ.prototype={
F(d){var x,w,v,u=this,t=d.d,s=u.d.F(t)
t=s
s=u.e
s=s==null?null:s.F(d.e)
if(s==null)s=d.e
x=u.f
if(x==null)x=d.f
w=u.r
if(w==null)w=d.r
v=u.w
if(v==null)v=d.w
return new B.kZ(t,s,x,w,v,d.a,d.b,d.c)},
h(d,e){var x=this
if(e==null)return!1
if(x===e)return!0
return e instanceof B.kZ&&e.d.h(0,x.d)&&J.x(e.e,x.e)&&e.f==x.f&&J.x(e.r,x.r)&&J.x(e.w,x.w)},
gq(d){var x=this
return C.P(x.a,x.b,x.c,x.d,x.e,x.f,x.r,x.w,A.a,A.a,A.a,A.a,A.a,A.a,A.a,A.a,A.a,A.a,A.a,A.a)}}
var z=a.updateTypes(["kZ(kZ)"])
B.az5.prototype={
$1(d){return d},
$S:z+0}
B.az4.prototype={
$0(){return this.a.e.$1(this.b)},
$S:0};(function inheritance(){var x=a.inheritMany,w=a.inherit
x(C.i,[B.a32,B.aof,B.agM])
w(B.az5,C.ap)
w(B.az4,C.aA)
w(B.z4,C.J)
w(B.kZ,C.ao)})()
C.ag(b.typeUniverse,JSON.parse('{"a32":{"i":[],"b":[]},"aof":{"i":[],"b":[]},"agM":{"i":[],"b":[]},"kZ":{"ao":[]}}'))
var y={o:C.e("dC"),z:C.e("kZ"),u:C.e("f<b>"),l:C.e("bZ<eF>"),B:C.e("bR<ee>"),i:C.e("ub")};(function constants(){D.bZh=new C.bZ(A.az,A.o7,A.o7,null,A.az,null,y.l)
D.CV=new B.z4(D.bZh,null,null,null,null)
D.bZw=new C.bZ(A.bP,A.ch,A.ch,null,A.bP,null,y.l)
D.CW=new B.z4(D.bZw,null,null,null,null)
D.bgs=new B.kZ(D.CV,D.CW,null,A.iu,A.ai,null,null,null)})()};
(a=>{a["I/1945UtWiPnzj3Hh9boURipEAg="]=a.current})($__dart_deferred_initializers__);