((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var C,E,A={
bNV(d,e){var x=e?B.df:B.dY,w=e?B.dY:B.df
switch(d.a){case 0:return new C.n1([B.aa,x,B.aa,B.aa])
case 1:return new C.n1([B.aa,x,B.aa,w])
case 2:return new C.n1([B.aa,x,w,B.aa])
case 3:return new C.n1([w,x,B.aa,B.aa])
case 4:return new C.n1([B.aa,B.aa,B.aa,x])
case 5:return new C.n1([B.aa,B.aa,w,x])
case 6:return new C.n1([w,B.aa,B.aa,x])
case 7:return new C.n1([B.aa,B.aa,x,B.aa])
case 8:return new C.n1([w,B.aa,x,B.aa])
case 9:return new C.n1([x,B.aa,B.aa,B.aa])}},
cx3(d){var x
A:{x=D.vT===d||D.bv4===d||D.bv6===d||D.Im===d
break A}return x},
Se(d,e,f,g,h,i,j){return new A.Iw(d,j,g,f,i,h,e,null)},
ym:function ym(d,e){this.a=d
this.b=e},
Iw:function Iw(d,e,f,g,h,i,j,k){var _=this
_.c=d
_.d=e
_.e=f
_.f=g
_.r=h
_.w=i
_.y=j
_.a=k},
a0T:function a0T(d,e,f){var _=this
_.d=null
_.e7$=d
_.j2$=e
_.bF$=f
_.c=_.a=null},
bq_:function bq_(d,e,f){this.a=d
this.b=e
this.c=f},
bq0:function bq0(d,e){this.a=d
this.b=e},
bq1:function bq1(){},
ad6:function ad6(d,e,f,g,h,i){var _=this
_.b=d
_.c=e
_.d=f
_.e=g
_.f=h
_.a=i},
aCf:function aCf(){},
Cv:function Cv(d,e,f){this.a=d
this.b=e
this.c=f}},D,F,B,G,H,I
C=c[0]
E=c[2]
A=a.updateHolder(c[203],A)
D=c[392]
F=c[309]
B=c[349]
G=c[221]
H=c[218]
I=c[491]
A.ym.prototype={
J(){return"HSLColorSliderType."+this.b}}
A.Iw.prototype={
q(){return new A.a0T(null,0,null)}}
A.a0T.prototype={
ga5k(){var x=this.d
return x==null?this.a.c:x},
al(d){this.ar(d)
if(!this.a.c.h(0,d.c))this.d=null},
Qq(d){var x=this.a,w=A.bNV(x.d,x.r),v=this.ga5k()
x=w.a
if(x[1]===d)return E.f.A(v.b/360,0,1)
if(x[3]===d)return E.f.A(v.c,0,1)
if(x[2]===d)return E.f.A(v.d,0,1)
if(x[0]===d)return E.f.A(v.a,0,1)
return 0},
a5l(d){var x=this.a
x=A.bNV(x.d,x.r).a
return x[1]===d||x[3]===d||x[2]===d||x[0]===d},
aDH(d,e){var x,w=this.a,v=A.bNV(w.d,w.r),u=w.c,t=new C.zA()
w=new A.bq_(this,d,e)
x=v.a
return new C.eQ(t.rg(w.$3(x[0],u.a,1),0,1),t.rg(w.$3(x[1],u.b,360),0,360),t.rg(w.$3(x[3],u.c,1),0,1),t.rg(w.$3(x[2],u.d,1),0,1))},
aDL(d,e){var x,w=this,v=w.aDH(d,e)
w.n(new A.bq0(w,v))
w.sdm(v)
x=w.a.e
if(x!=null)x.$1(v)},
aDJ(){var x=this,w=x.d
if(w==null)w=x.a.c
x.sdm(w)
x.a.f.$1(w)},
k(d){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j=this,i=null
j.sdm(j.a.c)
C.h(d)
j.a.toString
x=C.aL(d,D.bv7,new A.bq1(),i,y.d,y.m)
w=x.a.a
v=j.a5l(B.df)?j.Qq(B.df):j.Qq(B.dY)
u=j.a5l(B.dY)?j.Qq(B.dY):v
t=j.a
s=A.bNV(t.d,t.r)
r=j.ga5k()
t=r.bD()
q=j.a
p=q.w
o=A.cx3(q.d)
n=q.r
q=q.y
m=s.a
l=m[0]
k=l===B.aa?new C.eQ(1,r.b,r.c,r.d):r
return G.c4H(!1,C.bT(E.W,C.a([F.lX,C.dF(i,i,!1,i,new A.ad6(k,m[1],m[3],m[2],l,i),E.ae,!1)],y.e),E.N,E.dA),t,w,x.b,x.c,q,i,j.gaDI(),j.gaDK(),E.U,p,n,o,v,u)}}
A.ad6.prototype={
au(d,e){var x=this
H.cds(d,e,x.f,x.b,x.c,x.e,x.d)},
cf(d){var x=this
return!d.b.h(0,x.b)||d.c!==x.c||d.d!==x.d||d.e!==x.e||d.f!==x.f}}
A.aCf.prototype={
aW(){var x,w,v=this
v.bg()
x=v.c
x.toString
w=C.bQ(x,y.f)
if(w!=v.bF$){v.bF$=w
x=v.e7$
x=x==null?null:x.a
v.i_(y.o.a(x))}}}
A.Cv.prototype={
F(d){var x=this
return new A.Cv(x.a,x.b,x.c)}}
var z=a.updateTypes(["~(G,G)","~()","G(uZ,G,G)","Cv?(c_i)"])
A.bq_.prototype={
$3(d,e,f){var x,w
if(d===B.aa)x=e
else{x=this.b
w=this.c
x=(d===B.df?x:w)*f}return x},
$S:z+2}
A.bq0.prototype={
$0(){return this.a.d=this.b},
$S:0}
A.bq1.prototype={
$1(d){return d.e},
$S:z+3};(function installTearOffs(){var x=a._instance_2u,w=a._instance_0u
var v
x(v=A.a0T.prototype,"gaDK","aDL",0)
w(v,"gaDI","aDJ",1)})();(function inheritance(){var x=a.mixinHard,w=a.inherit,v=a.inheritMany
w(A.ym,C.dA)
w(A.Iw,C.q)
w(A.aCf,C.t)
w(A.a0T,A.aCf)
v(C.ax,[A.bq_,A.bq1])
w(A.bq0,C.aM)
w(A.ad6,C.iz)
w(A.Cv,C.I)
x(A.aCf,C.cT)})()
C.ao(b.typeUniverse,JSON.parse('{"Iw":{"q":[],"b":[]},"a0T":{"cT":["eQ","Iw"],"t":["Iw"],"cT.T":"eQ"},"ad6":{"az":[]},"c_i":{"av":[]}}'))
var y={f:C.j("l6"),m:C.j("Cv"),d:C.j("c_i"),e:C.j("i<b>"),o:C.j("eQ?")};(function constants(){D.vT=new A.ym(0,"hue")
D.Il=new A.ym(1,"hueSat")
D.bv4=new A.ym(4,"sat")
D.bv5=new A.ym(5,"satLum")
D.bv6=new A.ym(7,"lum")
D.Im=new A.ym(9,"alpha")
D.bv7=new A.Cv(I.mI,16,2)})()};
(a=>{a["3V/zzdVIWTPNqZ+XHoR/XkoSiPs="]=a.current})($__dart_deferred_initializers__);