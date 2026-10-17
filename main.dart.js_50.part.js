((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var C,E,F,G,B,H,I,A={
bp7(d,e){var x=e?B.cu:B.d8,w=e?B.d8:B.cu
switch(d.a){case 0:return new C.lx([B.a0,x,B.a0,B.a0])
case 1:return new C.lx([B.a0,x,w,B.a0])
case 2:return new C.lx([B.a0,x,B.a0,w])
case 3:return new C.lx([w,x,B.a0,B.a0])
case 4:return new C.lx([B.a0,B.a0,x,B.a0])
case 5:return new C.lx([B.a0,B.a0,x,w])
case 6:return new C.lx([w,B.a0,x,B.a0])
case 7:return new C.lx([B.a0,B.a0,B.a0,x])
case 8:return new C.lx([w,B.a0,B.a0,x])
case 9:return new C.lx([x,B.a0,B.a0,B.a0])}},
c_y(d){var x
A:{x=D.kw===d||D.bkf===d||D.bkh===d||D.t2===d
break A}return x},
ED(d,e,f,g,h,i,j){return new A.EC(d,j,g,f,i,h,e,null)},
vQ:function vQ(d,e){this.a=d
this.b=e},
EC:function EC(d,e,f,g,h,i,j,k){var _=this
_.c=d
_.d=e
_.e=f
_.f=g
_.r=h
_.w=i
_.y=j
_.a=k},
Ve:function Ve(d,e,f){var _=this
_.d=null
_.dz$=d
_.hs$=e
_.bt$=f
_.c=_.a=null},
b6I:function b6I(d,e,f){this.a=d
this.b=e
this.c=f},
b6J:function b6J(d,e){this.a=d
this.b=e},
b6K:function b6K(){},
a4z:function a4z(d,e,f,g,h,i){var _=this
_.b=d
_.c=e
_.d=f
_.e=g
_.f=h
_.a=i},
aqw:function aqw(){},
zw:function zw(d,e,f){this.a=d
this.b=e
this.c=f}},D,K
C=c[0]
E=c[2]
F=c[206]
G=c[391]
B=c[414]
H=c[201]
I=c[477]
A=a.updateHolder(c[187],A)
D=c[442]
K=c[199]
A.vQ.prototype={
K(){return"HSVColorSliderType."+this.b}}
A.EC.prototype={
t(){return new A.Ve(null,0,null)}}
A.Ve.prototype={
gVS(){var x=this.d
return x==null?this.a.c:x},
an(d){this.aw(d)
if(!this.a.c.h(0,d.c))this.d=null},
Kb(d){var x=this.a,w=A.bp7(x.d,x.r),v=this.gVS()
x=w.a
if(x[1]===d)return E.f.I(v.b/360,0,1)
if(x[2]===d)return E.f.I(v.c,0,1)
if(x[3]===d)return E.f.I(v.d,0,1)
if(x[0]===d)return E.f.I(v.a,0,1)
return 0},
VI(d){var x=this.a
x=A.bp7(x.d,x.r).a
return x[1]===d||x[2]===d||x[3]===d||x[0]===d},
agL(d,e){var x,w=this.a,v=A.bp7(w.d,w.r),u=w.c,t=new C.wY()
w=new A.b6I(this,d,e)
x=v.a
return new F.ff(t.lr(w.$3(x[0],u.a,1),0,1),t.lr(w.$3(x[1],u.b,360),0,360),t.lr(w.$3(x[2],u.c,1),0,1),t.lr(w.$3(x[3],u.d,1),0,1))},
aru(d,e){var x,w=this,v=w.agL(d,e)
w.p(new A.b6J(w,v))
w.scW(v)
x=w.a.e
if(x!=null)x.$1(v)},
aqt(){var x=this,w=x.d
if(w==null)w=x.a.c
x.scW(w)
x.a.f.$1(w)},
j(d){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j=this,i=null
j.scW(j.a.c)
C.h(d)
j.a.toString
x=C.aF(d,D.bki,new A.b6K(),i,y.o,y.n)
w=x.a.a
v=j.VI(B.cu)?j.Kb(B.cu):j.Kb(B.d8)
u=j.VI(B.d8)?j.Kb(B.d8):v
t=j.a
s=A.bp7(t.d,t.r)
r=j.gVS()
t=r.br()
q=j.a
p=q.w
o=A.c_y(q.d)
n=q.r
q=q.y
m=s.a
l=m[0]
k=l===B.a0?new F.ff(1,r.b,r.c,r.d):r
return H.bDl(!1,C.cd(E.a2,C.a([G.k5,C.eb(i,i,!1,i,new A.a4z(k,m[1],m[2],m[3],l,i),E.ac,!1)],y.e),E.T,E.ji),t,w,x.b,x.c,q,i,j.gaqs(),j.gart(),E.Q,p,n,o,v,u)}}
A.a4z.prototype={
aC(d,e){var x=this
K.bLh(d,e,x.f,x.b,x.c,x.d,x.e)},
e7(d){var x=this
return!d.b.h(0,x.b)||d.c!==x.c||d.d!==x.d||d.e!==x.e||d.f!==x.f}}
A.aqw.prototype={
aY(){var x,w,v=this
v.bs()
x=v.c
x.toString
w=C.bH(x,y.f)
if(w!=v.bt$){v.bt$=w
x=v.dz$
x=x==null?null:x.a
v.h3(y.i.a(x))}}}
A.zw.prototype={
F(d){var x=this
return new A.zw(x.a,x.b,x.c)}}
var z=a.updateTypes(["~(C,C)","~()","C(ru,C,C)","zw?(byU)"])
A.b6I.prototype={
$3(d,e,f){var x,w
if(d===B.a0)x=e
else{x=this.b
w=this.c
x=(d===B.cu?x:w)*f}return x},
$S:z+2}
A.b6J.prototype={
$0(){return this.a.d=this.b},
$S:0}
A.b6K.prototype={
$1(d){return d.d},
$S:z+3};(function installTearOffs(){var x=a._instance_2u,w=a._instance_0u
var v
x(v=A.Ve.prototype,"gart","aru",0)
w(v,"gaqs","aqt",1)})();(function inheritance(){var x=a.mixinHard,w=a.inherit,v=a.inheritMany
w(A.vQ,C.dW)
w(A.EC,C.r)
w(A.aqw,C.t)
w(A.Ve,A.aqw)
v(C.ap,[A.b6I,A.b6K])
w(A.b6J,C.aA)
w(A.a4z,C.j9)
w(A.zw,C.J)
x(A.aqw,C.cq)})()
C.ag(b.typeUniverse,JSON.parse('{"EC":{"r":[],"b":[]},"Ve":{"cq":["ff","EC"],"t":["EC"],"cq.T":"ff"},"a4z":{"as":[]},"byU":{"ao":[]}}'))
var y={f:C.e("jH"),n:C.e("zw"),o:C.e("byU"),e:C.e("f<b>"),i:C.e("ff?")};(function constants(){D.kw=new A.vQ(0,"hue")
D.Eo=new A.vQ(1,"hueSat")
D.bkf=new A.vQ(4,"sat")
D.bkg=new A.vQ(5,"satVal")
D.bkh=new A.vQ(7,"val")
D.t2=new A.vQ(9,"alpha")
D.bki=new A.zw(I.GJ,16,2)})()};
(a=>{a["qpAf44GXqXX38anwt8eJ2gzHoeE="]=a.current})($__dart_deferred_initializers__);