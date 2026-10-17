((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var C,E,F,A={
bp6(d,e){var x=e?B.cu:B.d8,w=e?B.d8:B.cu
switch(d.a){case 0:return new C.lw([B.a0,x,B.a0,B.a0])
case 1:return new C.lw([B.a0,x,B.a0,w])
case 2:return new C.lw([B.a0,x,w,B.a0])
case 3:return new C.lw([w,x,B.a0,B.a0])
case 4:return new C.lw([B.a0,B.a0,B.a0,x])
case 5:return new C.lw([B.a0,B.a0,w,x])
case 6:return new C.lw([w,B.a0,B.a0,x])
case 7:return new C.lw([B.a0,B.a0,x,B.a0])
case 8:return new C.lw([w,B.a0,x,B.a0])
case 9:return new C.lw([x,B.a0,B.a0,B.a0])}},
c_x(d){var x
A:{x=D.t1===d||D.bkb===d||D.bkd===d||D.En===d
break A}return x},
N5(d,e,f,g,h,i,j){return new A.EB(d,j,g,f,i,h,e,null)},
vO:function vO(d,e){this.a=d
this.b=e},
EB:function EB(d,e,f,g,h,i,j,k){var _=this
_.c=d
_.d=e
_.e=f
_.f=g
_.r=h
_.w=i
_.y=j
_.a=k},
Vd:function Vd(d,e,f){var _=this
_.d=null
_.dz$=d
_.hs$=e
_.bt$=f
_.c=_.a=null},
b6w:function b6w(d,e,f){this.a=d
this.b=e
this.c=f},
b6x:function b6x(d,e){this.a=d
this.b=e},
b6y:function b6y(){},
a4y:function a4y(d,e,f,g,h,i){var _=this
_.b=d
_.c=e
_.d=f
_.e=g
_.f=h
_.a=i},
aqv:function aqv(){},
zu:function zu(d,e,f){this.a=d
this.b=e
this.c=f}},D,B,G,H,I
C=c[0]
E=c[2]
F=c[391]
A=a.updateHolder(c[186],A)
D=c[440]
B=c[414]
G=c[201]
H=c[477]
I=c[198]
A.vO.prototype={
K(){return"HSLColorSliderType."+this.b}}
A.EB.prototype={
t(){return new A.Vd(null,0,null)}}
A.Vd.prototype={
gVQ(){var x=this.d
return x==null?this.a.c:x},
an(d){this.aw(d)
if(!this.a.c.h(0,d.c))this.d=null},
HI(d){var x=this.a,w=A.bp6(x.d,x.r),v=this.gVQ()
x=w.a
if(x[1]===d)return E.f.I(v.b/360,0,1)
if(x[3]===d)return E.f.I(v.c,0,1)
if(x[2]===d)return E.f.I(v.d,0,1)
if(x[0]===d)return E.f.I(v.a,0,1)
return 0},
VR(d){var x=this.a
x=A.bp6(x.d,x.r).a
return x[1]===d||x[3]===d||x[2]===d||x[0]===d},
aoc(d,e){var x,w=this.a,v=A.bp6(w.d,w.r),u=w.c,t=new C.wY()
w=new A.b6w(this,d,e)
x=v.a
return new C.e2(t.lr(w.$3(x[0],u.a,1),0,1),t.lr(w.$3(x[1],u.b,360),0,360),t.lr(w.$3(x[3],u.c,1),0,1),t.lr(w.$3(x[2],u.d,1),0,1))},
aog(d,e){var x,w=this,v=w.aoc(d,e)
w.p(new A.b6x(w,v))
w.scW(v)
x=w.a.e
if(x!=null)x.$1(v)},
aoe(){var x=this,w=x.d
if(w==null)w=x.a.c
x.scW(w)
x.a.f.$1(w)},
j(d){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j=this,i=null
j.scW(j.a.c)
C.h(d)
j.a.toString
x=C.aF(d,D.bke,new A.b6y(),i,y.d,y.m)
w=x.a.a
v=j.VR(B.cu)?j.HI(B.cu):j.HI(B.d8)
u=j.VR(B.d8)?j.HI(B.d8):v
t=j.a
s=A.bp6(t.d,t.r)
r=j.gVQ()
t=r.br()
q=j.a
p=q.w
o=A.c_x(q.d)
n=q.r
q=q.y
m=s.a
l=m[0]
k=l===B.a0?new C.e2(1,r.b,r.c,r.d):r
return G.bDl(!1,C.cd(E.a2,C.a([F.k5,C.eb(i,i,!1,i,new A.a4y(k,m[1],m[3],m[2],l,i),E.ac,!1)],y.e),E.T,E.ji),t,w,x.b,x.c,q,i,j.gaod(),j.gaof(),E.Q,p,n,o,v,u)}}
A.a4y.prototype={
aC(d,e){var x=this
I.bLg(d,e,x.f,x.b,x.c,x.e,x.d)},
e7(d){var x=this
return!d.b.h(0,x.b)||d.c!==x.c||d.d!==x.d||d.e!==x.e||d.f!==x.f}}
A.aqv.prototype={
aY(){var x,w,v=this
v.bs()
x=v.c
x.toString
w=C.bH(x,y.f)
if(w!=v.bt$){v.bt$=w
x=v.dz$
x=x==null?null:x.a
v.h3(y.o.a(x))}}}
A.zu.prototype={
F(d){var x=this
return new A.zu(x.a,x.b,x.c)}}
var z=a.updateTypes(["~(C,C)","~()","C(ru,C,C)","zu?(byT)"])
A.b6w.prototype={
$3(d,e,f){var x,w
if(d===B.a0)x=e
else{x=this.b
w=this.c
x=(d===B.cu?x:w)*f}return x},
$S:z+2}
A.b6x.prototype={
$0(){return this.a.d=this.b},
$S:0}
A.b6y.prototype={
$1(d){return d.d},
$S:z+3};(function installTearOffs(){var x=a._instance_2u,w=a._instance_0u
var v
x(v=A.Vd.prototype,"gaof","aog",0)
w(v,"gaod","aoe",1)})();(function inheritance(){var x=a.mixinHard,w=a.inherit,v=a.inheritMany
w(A.vO,C.dW)
w(A.EB,C.r)
w(A.aqv,C.t)
w(A.Vd,A.aqv)
v(C.ap,[A.b6w,A.b6y])
w(A.b6x,C.aA)
w(A.a4y,C.j9)
w(A.zu,C.J)
x(A.aqv,C.cq)})()
C.ag(b.typeUniverse,JSON.parse('{"EB":{"r":[],"b":[]},"Vd":{"cq":["e2","EB"],"t":["EB"],"cq.T":"e2"},"a4y":{"as":[]},"byT":{"ao":[]}}'))
var y={f:C.e("jH"),m:C.e("zu"),d:C.e("byT"),e:C.e("f<b>"),o:C.e("e2?")};(function constants(){D.t1=new A.vO(0,"hue")
D.Em=new A.vO(1,"hueSat")
D.bkb=new A.vO(4,"sat")
D.bkc=new A.vO(5,"satLum")
D.bkd=new A.vO(7,"lum")
D.En=new A.vO(9,"alpha")
D.bke=new A.zu(H.GJ,16,2)})()};
(a=>{a["stUOGwYL8K9ePgmo6Ym0olJ0vKY="]=a.current})($__dart_deferred_initializers__);