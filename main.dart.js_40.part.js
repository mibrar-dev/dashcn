((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var C,E,F,G,B,H,I,A={
bNW(d,e){var x=e?B.df:B.dY,w=e?B.dY:B.df
switch(d.a){case 0:return new C.n2([B.aa,x,B.aa,B.aa])
case 1:return new C.n2([B.aa,x,w,B.aa])
case 2:return new C.n2([B.aa,x,B.aa,w])
case 3:return new C.n2([w,x,B.aa,B.aa])
case 4:return new C.n2([B.aa,B.aa,x,B.aa])
case 5:return new C.n2([B.aa,B.aa,x,w])
case 6:return new C.n2([w,B.aa,x,B.aa])
case 7:return new C.n2([B.aa,B.aa,B.aa,x])
case 8:return new C.n2([w,B.aa,B.aa,x])
case 9:return new C.n2([x,B.aa,B.aa,B.aa])}},
cx4(d){var x
A:{x=D.mr===d||D.bv8===d||D.bva===d||D.vU===d
break A}return x},
Iy(d,e,f,g,h,i,j){return new A.Ix(d,j,g,f,i,h,e,null)},
yp:function yp(d,e){this.a=d
this.b=e},
Ix:function Ix(d,e,f,g,h,i,j,k){var _=this
_.c=d
_.d=e
_.e=f
_.f=g
_.r=h
_.w=i
_.y=j
_.a=k},
a0U:function a0U(d,e,f){var _=this
_.d=null
_.e7$=d
_.j2$=e
_.bF$=f
_.c=_.a=null},
bqb:function bqb(d,e,f){this.a=d
this.b=e
this.c=f},
bqc:function bqc(d,e){this.a=d
this.b=e},
bqd:function bqd(){},
ad7:function ad7(d,e,f,g,h,i){var _=this
_.b=d
_.c=e
_.d=f
_.e=g
_.f=h
_.a=i},
aCg:function aCg(){},
Cw:function Cw(d,e,f){this.a=d
this.b=e
this.c=f}},D,K
C=c[0]
E=c[2]
F=c[226]
G=c[309]
B=c[349]
H=c[221]
I=c[491]
A=a.updateHolder(c[204],A)
D=c[394]
K=c[219]
A.yp.prototype={
J(){return"HSVColorSliderType."+this.b}}
A.Ix.prototype={
q(){return new A.a0U(null,0,null)}}
A.a0U.prototype={
ga5m(){var x=this.d
return x==null?this.a.c:x},
al(d){this.ar(d)
if(!this.a.c.h(0,d.c))this.d=null},
Ts(d){var x=this.a,w=A.bNW(x.d,x.r),v=this.ga5m()
x=w.a
if(x[1]===d)return E.f.A(v.b/360,0,1)
if(x[2]===d)return E.f.A(v.c,0,1)
if(x[3]===d)return E.f.A(v.d,0,1)
if(x[0]===d)return E.f.A(v.a,0,1)
return 0},
a5b(d){var x=this.a
x=A.bNW(x.d,x.r).a
return x[1]===d||x[2]===d||x[3]===d||x[0]===d},
av6(d,e){var x,w=this.a,v=A.bNW(w.d,w.r),u=w.c,t=new C.zA()
w=new A.bqb(this,d,e)
x=v.a
return new F.h9(t.rg(w.$3(x[0],u.a,1),0,1),t.rg(w.$3(x[1],u.b,360),0,360),t.rg(w.$3(x[2],u.c,1),0,1),t.rg(w.$3(x[3],u.d,1),0,1))},
aHu(d,e){var x,w=this,v=w.av6(d,e)
w.n(new A.bqc(w,v))
w.sdm(v)
x=w.a.e
if(x!=null)x.$1(v)},
aGp(){var x=this,w=x.d
if(w==null)w=x.a.c
x.sdm(w)
x.a.f.$1(w)},
k(d){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j=this,i=null
j.sdm(j.a.c)
C.h(d)
j.a.toString
x=C.aL(d,D.bvb,new A.bqd(),i,y.o,y.n)
w=x.a.a
v=j.a5b(B.df)?j.Ts(B.df):j.Ts(B.dY)
u=j.a5b(B.dY)?j.Ts(B.dY):v
t=j.a
s=A.bNW(t.d,t.r)
r=j.ga5m()
t=r.bD()
q=j.a
p=q.w
o=A.cx4(q.d)
n=q.r
q=q.y
m=s.a
l=m[0]
k=l===B.aa?new F.h9(1,r.b,r.c,r.d):r
return H.c4H(!1,C.bT(E.W,C.a([G.lX,C.dF(i,i,!1,i,new A.ad7(k,m[1],m[2],m[3],l,i),E.ae,!1)],y.e),E.N,E.dA),t,w,x.b,x.c,q,i,j.gaGo(),j.gaHt(),E.U,p,n,o,v,u)}}
A.ad7.prototype={
au(d,e){var x=this
K.cdt(d,e,x.f,x.b,x.c,x.d,x.e)},
cf(d){var x=this
return!d.b.h(0,x.b)||d.c!==x.c||d.d!==x.d||d.e!==x.e||d.f!==x.f}}
A.aCg.prototype={
aW(){var x,w,v=this
v.bg()
x=v.c
x.toString
w=C.bQ(x,y.f)
if(w!=v.bF$){v.bF$=w
x=v.e7$
x=x==null?null:x.a
v.i_(y.i.a(x))}}}
A.Cw.prototype={
F(d){var x=this
return new A.Cw(x.a,x.b,x.c)}}
var z=a.updateTypes(["~(G,G)","~()","G(uZ,G,G)","Cw?(c_j)"])
A.bqb.prototype={
$3(d,e,f){var x,w
if(d===B.aa)x=e
else{x=this.b
w=this.c
x=(d===B.df?x:w)*f}return x},
$S:z+2}
A.bqc.prototype={
$0(){return this.a.d=this.b},
$S:0}
A.bqd.prototype={
$1(d){return d.e},
$S:z+3};(function installTearOffs(){var x=a._instance_2u,w=a._instance_0u
var v
x(v=A.a0U.prototype,"gaHt","aHu",0)
w(v,"gaGo","aGp",1)})();(function inheritance(){var x=a.mixinHard,w=a.inherit,v=a.inheritMany
w(A.yp,C.dA)
w(A.Ix,C.q)
w(A.aCg,C.t)
w(A.a0U,A.aCg)
v(C.ax,[A.bqb,A.bqd])
w(A.bqc,C.aM)
w(A.ad7,C.iz)
w(A.Cw,C.I)
x(A.aCg,C.cT)})()
C.ao(b.typeUniverse,JSON.parse('{"Ix":{"q":[],"b":[]},"a0U":{"cT":["h9","Ix"],"t":["Ix"],"cT.T":"h9"},"ad7":{"az":[]},"c_j":{"av":[]}}'))
var y={f:C.j("l6"),n:C.j("Cw"),o:C.j("c_j"),e:C.j("i<b>"),i:C.j("h9?")};(function constants(){D.mr=new A.yp(0,"hue")
D.In=new A.yp(1,"hueSat")
D.bv8=new A.yp(4,"sat")
D.bv9=new A.yp(5,"satVal")
D.bva=new A.yp(7,"val")
D.vU=new A.yp(9,"alpha")
D.bvb=new A.Cw(I.mI,16,2)})()};
(a=>{a["WWrAwHs0YhKYsoK71sfAcgziWF0="]=a.current})($__dart_deferred_initializers__);