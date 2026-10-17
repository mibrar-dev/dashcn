((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var B,C,A={
aTe(d,e,f,g,h,i,j){return new A.u1(j,f,e,i,h,g,d,null)},
u1:function u1(d,e,f,g,h,i,j,k){var _=this
_.c=d
_.d=e
_.e=f
_.f=g
_.r=h
_.w=i
_.ax=j
_.a=k},
Z8:function Z8(d,e,f){var _=this
_.d=null
_.dz$=d
_.hs$=e
_.bt$=f
_.c=_.a=null},
bmt:function bmt(d,e){this.a=d
this.b=e},
bmu:function bmu(d){this.a=d},
bmo:function bmo(d){this.a=d},
bmp:function bmp(d){this.a=d},
bmq:function bmq(d,e,f,g,h){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h},
bms:function bms(d,e){this.a=d
this.b=e},
bmr:function bmr(d,e){this.a=d
this.b=e},
ar7:function ar7(){},
u2:function u2(d,e,f,g,h,i,j){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h
_.f=i
_.r=j},
Ho:function Ho(d,e){this.a=d
this.b=e}},D
B=c[0]
C=c[2]
A=a.updateHolder(c[148],A)
D=c[331]
A.u1.prototype={
t(){return new A.Z8(null,0,null)}}
A.Z8.prototype={
gJH(){var x=this.a,w=x.d
w=w==null?null:w.a
if(w==null){x=x.c
x.toString}else x=w
return x},
ad(){this.ah()
this.a_C()},
an(d){var x
this.aw(d)
x=this.a.ax
if(x!==d.ax)this.a_C()},
m(){var x=this.d
if(x!=null)x.m()
this.T()},
a_C(){var x,w=this,v=w.a.ax
if(v&&w.d==null){x=B.cK(!0,"Toggle",!0,!0,null,null,!1)
w.d=x
$.ah.x1$.push(new A.bmt(w,x))
return}if(!v&&w.d!=null){w.d.m()
w.d=null}},
azd(){var x=this.a,w=x.d
if(w!=null)w.xY()
else{x=x.r
if(x!=null)x.$1(!this.gJH())}},
j(d){var x,w=this
w.scW(w.gJH())
x=w.a.d
if(x==null)return w.a_B(d)
return new B.dd(new A.bmu(w),null,x,null)},
a_B(d){var x,w,v,u,t,s,r,q,p=this,o=null,n=B.h(d),m=p.gJH(),l=p.a,k=l.w
if(k==null)k=l.d!=null||l.r!=null
l=m?D.caJ:D.caI
x=B.aF(d,l,new A.bmo(m),o,y.a,y.j)
switch(p.a.f.a){case 0:l=32
break
case 1:l=36
break
case 2:l=40
break
default:l=o}w=B.cf(x.f,n.r.c*n.f)
d.Z(y.o).toString
v=C.f.I(l-Math.max(w.a,0)-Math.max(w.c,0),0,1/0)
u=C.f.I(l-Math.max(w.b,0)-Math.max(w.d,0),0,1/0)
l=new A.bmp(n)
t=k?1:0.5
s=k?p.gazc():o
r=p.a
q=p.d
return B.bJ(!0,o,B.dY(B.cp(o,!1,C.P,new B.at(new B.a6(v,1/0,u,1/0),B.aQ(r.e,1,1),o),new B.d9(new A.bmq(l,x,!1,0,n)),!1,k,q,!0,new B.d9(new A.bmr(l,x)),o,C.cW,o,o,o,o,s,o,o,o,new B.bR(w,y.l),o,o,new B.d9(new A.bms(x,l))),o,t),!1,o,k,!1,o,!1,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,m,o,o)}}
A.ar7.prototype={
aY(){var x,w,v=this
v.bs()
x=v.c
x.toString
w=B.bH(x,y.f)
if(w!=v.bt$){v.bt$=w
x=v.dz$
v.h3(B.bV(x==null?null:x.a))}}}
A.u2.prototype={
F(d){var x,w,v=this,u=d.a,t=v.a.F(u)
u=t
t=d.b
x=v.b.F(t)
t=x
x=v.r
w=d.r.F(x)
x=w
return new A.u2(u,t,d.c,d.d,d.e,v.f,x)},
h(d,e){var x=this
if(e==null)return!1
if(x===e)return!0
return e instanceof A.u2&&e.a.h(0,x.a)&&e.b.h(0,x.b)&&e.f.h(0,x.f)&&e.r.h(0,x.r)},
gq(d){var x=this
return B.P(x.a,x.b,x.c,x.d,x.e,x.f,x.r,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a)}}
A.Ho.prototype={
K(){return"ToggleSize."+this.b}}
var z=a.updateTypes(["~()","u2?(bA4)"])
A.bmt.prototype={
$1(d){if(this.a.c!=null)this.b.bc()},
$S:3}
A.bmu.prototype={
$2(d,e){return this.a.a_B(d)},
$S:16}
A.bmo.prototype={
$1(d){return this.a?d.d:d.e},
$S:z+1}
A.bmp.prototype={
$2(d,e){var x
if(d==null)x=null
else{x=d.H(e)
x=x==null?null:x.H(this.a.a)}return x},
$S:67}
A.bmq.prototype={
$1(d){var x=this,w=null,v=x.a,u=x.b,t=v.$2(u.a,d),s=v.$2(u.c,d)
if(x.c){v=s==null?C.aB:s
v=B.aU(v,C.y,x.d)}else v=w
return new B.a2(t,w,v,B.ab(Math.max(0,x.e.b.a*16-2)),w,w,C.q)},
$S:187}
A.bms.prototype={
$1(d){var x=this.a,w=this.b.$2(x.b,d)
return x.r.wz(w,null)},
$S:188}
A.bmr.prototype={
$1(d){var x=null,w=this.a.$2(this.b.b,d)
return w==null?x:new B.cs(x,x,x,x,x,w,x,x,x)},
$S:189};(function installTearOffs(){var x=a._instance_0u
x(A.Z8.prototype,"gazc","azd",0)})();(function inheritance(){var x=a.mixinHard,w=a.inherit,v=a.inheritMany
w(A.u1,B.r)
w(A.ar7,B.t)
w(A.Z8,A.ar7)
v(B.ap,[A.bmt,A.bmo,A.bmq,A.bms,A.bmr])
v(B.bG,[A.bmu,A.bmp])
w(A.u2,B.J)
w(A.Ho,B.dW)
x(A.ar7,B.cq)})()
B.ag(b.typeUniverse,JSON.parse('{"u1":{"r":[],"b":[]},"Z8":{"cq":["B","u1"],"t":["u1"],"cq.T":"B"},"bA4":{"ao":[]}}'))
var y={o:B.e("dC"),f:B.e("jH"),j:B.e("u2"),a:B.e("bA4"),l:B.e("bR<ee>")};(function constants(){D.caG=new A.Ho(0,"sm")
D.hT=new A.Ho(1,"md")
D.caH=new A.Ho(2,"lg")
D.caI=new A.u2(C.RN,C.eM,null,null,null,C.hh,C.cb)
D.caJ=new A.u2(C.li,C.vm,null,null,null,C.hh,C.cb)})()};
(a=>{a["xecsyVeB0Duqu5O2HV2PWK0YnpE="]=a.current})($__dart_deferred_initializers__);