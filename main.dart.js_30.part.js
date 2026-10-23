((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var C,E,F,A={
bP0(d,e){var x=e?B.dc:B.dV,w=e?B.dV:B.dc
switch(d.a){case 0:return new C.n2([B.ab,x,B.ab,B.ab])
case 1:return new C.n2([B.ab,x,B.ab,w])
case 2:return new C.n2([B.ab,x,w,B.ab])
case 3:return new C.n2([w,x,B.ab,B.ab])
case 4:return new C.n2([B.ab,B.ab,B.ab,x])
case 5:return new C.n2([B.ab,B.ab,w,x])
case 6:return new C.n2([w,B.ab,B.ab,x])
case 7:return new C.n2([B.ab,B.ab,x,B.ab])
case 8:return new C.n2([w,B.ab,x,B.ab])
case 9:return new C.n2([x,B.ab,B.ab,B.ab])}},
cyn(d){var x
A:{x=D.vT===d||D.bvv===d||D.bvx===d||D.Iv===d
break A}return x},
Si(d,e,f,g,h,i,j){return new A.IE(d,j,g,f,i,h,e,null)},
yt:function yt(d,e){this.a=d
this.b=e},
IE:function IE(d,e,f,g,h,i,j,k){var _=this
_.c=d
_.d=e
_.e=f
_.f=g
_.r=h
_.w=i
_.y=j
_.a=k},
a0R:function a0R(d,e,f){var _=this
_.d=null
_.e8$=d
_.j2$=e
_.bG$=f
_.c=_.a=null},
bqI:function bqI(d,e,f){this.a=d
this.b=e
this.c=f},
bqJ:function bqJ(d,e){this.a=d
this.b=e},
bqK:function bqK(){},
ada:function ada(d,e,f,g,h,i){var _=this
_.b=d
_.c=e
_.d=f
_.e=g
_.f=h
_.a=i},
aCw:function aCw(){},
CD:function CD(d,e,f){this.a=d
this.b=e
this.c=f}},D,B,G,H,I
C=c[0]
E=c[2]
F=c[308]
A=a.updateHolder(c[203],A)
D=c[392]
B=c[348]
G=c[221]
H=c[218]
I=c[492]
A.yt.prototype={
J(){return"HSLColorSliderType."+this.b}}
A.IE.prototype={
q(){return new A.a0R(null,0,null)}}
A.a0R.prototype={
ga5s(){var x=this.d
return x==null?this.a.c:x},
al(d){this.au(d)
if(!this.a.c.h(0,d.c))this.d=null},
Qu(d){var x=this.a,w=A.bP0(x.d,x.r),v=this.ga5s()
x=w.a
if(x[1]===d)return E.f.v(v.b/360,0,1)
if(x[3]===d)return E.f.v(v.c,0,1)
if(x[2]===d)return E.f.v(v.d,0,1)
if(x[0]===d)return E.f.v(v.a,0,1)
return 0},
a5t(d){var x=this.a
x=A.bP0(x.d,x.r).a
return x[1]===d||x[3]===d||x[2]===d||x[0]===d},
aDP(d,e){var x,w=this.a,v=A.bP0(w.d,w.r),u=w.c,t=new C.zI()
w=new A.bqI(this,d,e)
x=v.a
return new C.eP(t.rh(w.$3(x[0],u.a,1),0,1),t.rh(w.$3(x[1],u.b,360),0,360),t.rh(w.$3(x[3],u.c,1),0,1),t.rh(w.$3(x[2],u.d,1),0,1))},
aDT(d,e){var x,w=this,v=w.aDP(d,e)
w.n(new A.bqJ(w,v))
w.sdm(v)
x=w.a.e
if(x!=null)x.$1(v)},
aDR(){var x=this,w=x.d
if(w==null)w=x.a.c
x.sdm(w)
x.a.f.$1(w)},
k(d){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j=this,i=null
j.sdm(j.a.c)
C.h(d)
j.a.toString
x=C.aL(d,D.bvy,new A.bqK(),i,y.d,y.m)
w=x.a.a
v=j.a5t(B.dc)?j.Qu(B.dc):j.Qu(B.dV)
u=j.a5t(B.dV)?j.Qu(B.dV):v
t=j.a
s=A.bP0(t.d,t.r)
r=j.ga5s()
t=r.bD()
q=j.a
p=q.w
o=A.cyn(q.d)
n=q.r
q=q.y
m=s.a
l=m[0]
k=l===B.ab?new C.eP(1,r.b,r.c,r.d):r
return G.c5Z(!1,C.bV(E.W,C.a([F.lS,C.dF(i,i,!1,i,new A.ada(k,m[1],m[3],m[2],l,i),E.ag,!1)],y.e),E.O,E.dz),t,w,x.b,x.c,q,i,j.gaDQ(),j.gaDS(),E.V,p,n,o,v,u)}}
A.ada.prototype={
av(d,e){var x=this
H.ceO(d,e,x.f,x.b,x.c,x.e,x.d)},
cd(d){var x=this
return!d.b.h(0,x.b)||d.c!==x.c||d.d!==x.d||d.e!==x.e||d.f!==x.f}}
A.aCw.prototype={
aW(){var x,w,v=this
v.bg()
x=v.c
x.toString
w=C.bR(x,y.f)
if(w!=v.bG$){v.bG$=w
x=v.e8$
x=x==null?null:x.a
v.i0(y.o.a(x))}}}
A.CD.prototype={
G(d){var x=this
return new A.CD(x.a,x.b,x.c)}}
var z=a.updateTypes(["~(G,G)","~()","G(v5,G,G)","CD?(c0w)"])
A.bqI.prototype={
$3(d,e,f){var x,w
if(d===B.ab)x=e
else{x=this.b
w=this.c
x=(d===B.dc?x:w)*f}return x},
$S:z+2}
A.bqJ.prototype={
$0(){return this.a.d=this.b},
$S:0}
A.bqK.prototype={
$1(d){return d.e},
$S:z+3};(function installTearOffs(){var x=a._instance_2u,w=a._instance_0u
var v
x(v=A.a0R.prototype,"gaDS","aDT",0)
w(v,"gaDQ","aDR",1)})();(function inheritance(){var x=a.mixinHard,w=a.inherit,v=a.inheritMany
w(A.yt,C.dz)
w(A.IE,C.q)
w(A.aCw,C.t)
w(A.a0R,A.aCw)
v(C.ax,[A.bqI,A.bqK])
w(A.bqJ,C.aN)
w(A.ada,C.iB)
w(A.CD,C.I)
x(A.aCw,C.cT)})()
C.ap(b.typeUniverse,JSON.parse('{"IE":{"q":[],"b":[]},"a0R":{"cT":["eP","IE"],"t":["IE"],"cT.T":"eP"},"ada":{"az":[]},"c0w":{"av":[]}}'))
var y={f:C.j("l8"),m:C.j("CD"),d:C.j("c0w"),e:C.j("i<b>"),o:C.j("eP?")};(function constants(){D.vT=new A.yt(0,"hue")
D.Iu=new A.yt(1,"hueSat")
D.bvv=new A.yt(4,"sat")
D.bvw=new A.yt(5,"satLum")
D.bvx=new A.yt(7,"lum")
D.Iv=new A.yt(9,"alpha")
D.bvy=new A.CD(I.mG,16,2)})()};
(a=>{a["ltahcl9tr1GPYzWUAU7JZGjdKTI="]=a.current})($__dart_deferred_initializers__);