((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,C,B={
a6c(d,e,f,g){var x=new B.Oo(g,f,A.a([],y.i),A.a([],y.c),A.a([],y.b))
x.adT(null,d,e,f,g)
return x},
iW:function iW(d,e,f){this.a=d
this.b=e
this.c=f},
Oo:function Oo(d,e,f,g,h){var _=this
_.Q=_.z=null
_.as=d
_.at=e
_.ax=null
_.ay=$
_.ch=null
_.CW=0
_.cx=null
_.cy=!1
_.a=f
_.b=g
_.e=_.d=_.c=null
_.r=_.f=!1
_.w=0
_.x=!1
_.y=h},
aHF:function aHF(d,e){this.a=d
this.b=e},
aHE:function aHE(d){this.a=d}}
J=c[1]
A=c[0]
C=c[2]
B=a.updateHolder(c[193],B)
B.iW.prototype={
lx(){return new B.iW(this.a.lx(),this.b,this.c)},
gQk(){var x=this.a
return x.d*x.c*4},
m(){this.a.m()},
l(d){var x=this.c
x=x!=null?x+" ":""
return x+this.a.l(0)+" @ "+A.k9(this.b)+"x"},
gq(d){return A.P(this.a,this.b,this.c,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a)},
h(d,e){var x=this
if(e==null)return!1
if(J.bb(e)!==A.ac(x))return!1
return y.l.b(e)&&e.gfz()===x.a&&e.goF()===x.b&&e.gjf()==x.c},
gfz(){return this.a},
goF(){return this.b},
gjf(){return this.c}}
B.Oo.prototype={
adT(d,e,f,g,h){this.e=f
e.dk(this.gakR(),new B.aHF(this,g),y.f)},
akS(d){this.Q=d
if(this.a.length!==0)this.qK()},
akC(d){var x,w,v,u=this
u.cy=!1
if(u.a.length===0)return
x=u.ch
if(x!=null){w=u.ay
w===$&&A.d()
w=d.a-w.a>=x.a}else w=!0
if(w){u.U1(new B.iW(u.ax.gfz().lx(),u.as,u.e))
u.ay=d
u.ch=u.ax.gi8()
u.ax.gfz().m()
u.ax=null
x=u.Q
if(x==null)return
v=C.l.j7(u.CW,x.gpS())
if(u.Q.gtI()===-1||v<=u.Q.gtI()){u.qK()
return}u.Q.m()
u.Q=null
return}w=u.ay
w===$&&A.d()
u.cx=A.df(new A.aZ(C.l.am(x.a-(d.a-w.a))),new B.aHE(u))},
qK(){var x=0,w=A.a_(y.f),v,u=2,t=[],s=this,r,q,p,o,n
var $async$qK=A.W(function(d,e){if(d===1){t.push(e)
x=u}for(;;)switch(x){case 0:o=s.ax
if(o!=null)o.gfz().m()
s.ax=null
u=4
x=7
return A.V(s.Q.hR(),$async$qK)
case 7:s.ax=e
u=2
x=6
break
case 4:u=3
n=t.pop()
r=A.aG(n)
q=A.bf(n)
s.qf(A.bC("resolving an image frame"),r,s.at,!0,q)
x=1
break
x=6
break
case 3:x=2
break
case 6:o=s.Q
if(o==null){x=1
break}if(o.gpS()===1){if(s.a.length===0){x=1
break}s.U1(new B.iW(s.ax.gfz().lx(),s.as,s.e))
s.ax.gfz().m()
s.ax=null
o=s.Q
if(o!=null)o.m()
s.Q=null
x=1
break}s.YQ()
case 1:return A.Y(v,w)
case 2:return A.X(t.at(-1),w)}})
return A.Z($async$qK,w)},
YQ(){if(this.cy)return
this.cy=!0
$.cB.yp(this.gakB())},
U1(d){this.F_(d);++this.CW},
a_(d){var x,w=this,v=!1
if(w.a.length===0){x=w.Q
if(x!=null)v=w.c==null||x.gpS()>1}if(v)w.qK()
w.aan(d)},
P(d){var x,w=this
w.aap(d)
if(w.a.length===0){x=w.cx
if(x!=null)x.aA()
w.cx=null}},
vl(){var x,w=this
w.aam()
if(w.x){w.z=null
x=w.Q
if(x!=null)x.m()
w.Q=null}}}
var z=a.updateTypes(["~(hV)","~(aZ)","~(i_)"])
B.aHF.prototype={
$2(d,e){this.a.qf(A.bC("resolving an image codec"),d,this.b,!0,e)},
$S:21}
B.aHE.prototype={
$0(){this.a.YQ()},
$S:0};(function installTearOffs(){var x=a._instance_1u
var w
x(w=B.Oo.prototype,"gakR","akS",0)
x(w,"gakB","akC",1)
x(w,"gBy","a_",2)})();(function inheritance(){var x=a.inherit
x(B.iW,A.J)
x(B.Oo,A.hZ)
x(B.aHF,A.bG)
x(B.aHE,A.aA)})()
A.ag(b.typeUniverse,JSON.parse('{"Oo":{"hZ":[]}}'))
var y={l:A.e("iW"),i:A.e("f<i_>"),b:A.e("f<~()>"),c:A.e("f<~(J,dy?)>"),f:A.e("~")}};
(a=>{a["I/FsFDISq4RbTmmFGKrSfRttxjA="]=a.current})($__dart_deferred_initializers__);