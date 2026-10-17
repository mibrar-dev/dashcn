((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,C,B={
bU3(){return new B.Bn(null)},
Bn:function Bn(d){this.a=d},
apl:function apl(d,e){var _=this
_.f=_.e=_.d=$
_.e4$=d
_.aU$=e
_.c=_.a=null},
bm2:function bm2(d){this.a=d},
a_f:function a_f(){},
bA2(d,e,f){var x,w,v,u="keyframes",t=d.length
if(t===0)throw A.w(A.hp(d,u,"No keyframes found"))
for(x=C.O,w=0;w<d.length;d.length===t||(0,A.F)(d),++w){v=d[w]
if(v.gi8().a<=0)throw A.w(A.hp(v.gi8(),u,"Keyframe durations must be positive"))
x=new A.aZ(x.a+v.gi8().a)}t=e==null?A.arT(B.cdF(),f.i("0?")):e
return new B.RS(t,x,A.f5(d,f.i("w_<0>")),f.i("RS<0>"))},
bHb(d,e,f,g){if(A.p8(d)&&A.p8(e))return g.a(C.f.am(d+(e-d)*f))
if(typeof d=="number"&&typeof e=="number")return g.a(d+(e-d)*f)
throw A.w(A.e_("TimelineAnimation<"+A.cM(g).l(0)+"> cannot interpolate "+J.bb(d).l(0)+"; pass an explicit `lerp` (see Transformers).",null))},
bU7(d,e,f){return A.fD(d,e,f)},
r9:function r9(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.$ti=g},
AA:function AA(d,e){this.a=d
this.$ti=e},
QO:function QO(d){this.$ti=d},
RS:function RS(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.$ti=g}},D
J=c[1]
A=c[0]
C=c[2]
B=a.updateHolder(c[135],B)
D=c[464]
B.Bn.prototype={
t(){return new B.apl(null,null)}}
B.apl.prototype={
ad(){var x,w,v=this
v.ah()
x=B.bA2(A.a([D.Vy,D.a0d,D.bUB],y.t),null,y.b)
v.e!==$&&A.bz()
v.e=x
w=B.bA2(A.a([D.Vz,D.bUC],y.o),B.cdG(),y.C)
v.f!==$&&A.bz()
v.f=w
x=A.fj(null,x.b,null,v)
x.Ed()
v.d!==$&&A.bz()
v.d=x},
m(){var x=this.d
x===$&&A.d()
x.m()
this.adz()},
j(d){var x,w=null,v=this.d
v===$&&A.d()
v=A.ir(v,new B.bm2(this),w)
x=this.e
x===$&&A.d()
return A.aQ(A.u(A.a([v,C.dc,A.j("total "+C.l.bw(x.b.a,1000)+"ms \xb7 segments "+x.c.length+" \xb7 int lerp \u2192 "+B.bA2(A.a([D.Vx],y.A),w,y.e).aE(0.5),w,w,w,w,w,w,w,w,D.c37,C.ad,w,w,w)],y.u),C.m,C.c,C.i,0,C.h),w,w)}}
B.a_f.prototype={
m(){var x=this,w=x.aU$
if(w!=null)w.P(x.geV())
x.aU$=null
x.T()},
bP(){this.dR()
this.dO()
this.eW()}}
B.r9.prototype={
rO(d,e,f){var x=d.a.$3(this.a,this.b,f)
return x==null?this.$ti.c.a(x):x},
$iw_:1,
gi8(){return this.c}}
B.AA.prototype={
rO(d,e,f){var x
if(e<=0)return this.a
x=e-1
x=d.a.$3(d.c[x].rO(d,x,1),this.a,f)
return x==null?this.$ti.c.a(x):x},
$iw_:1,
gi8(){return C.mG}}
B.QO.prototype={
rO(d,e,f){var x
if(e<=0)throw A.w(A.bn("StillKeyframe without a value needs a previous keyframe to hold, but it is the first segment of the timeline."))
x=e-1
return d.c[x].rO(d,x,1)},
$iw_:1,
gi8(){return C.aO}}
B.RS.prototype={
aE(d){var x,w,v,u,t,s,r,q,p=this,o=C.f.am(C.f.I(d,0,1)*p.b.a)
for(x=p.c,w=x.length,v=C.O,u=0;u<w;++u,v=q){t=x[u]
s=v.a
r=s+t.gi8().a
q=new A.aZ(r)
if(o<r)return t.rO(p,u,(o-s)/t.gi8().a)}return C.b.gal(x).rO(p,w-1,1)}}
var z=a.updateTypes(["0^(0^,0^,C)<J?>","ad?(ad?,ad?,C)"])
B.bm2.prototype={
$2(d,e){var x,w,v,u=null,t=this.a,s=t.e
s===$&&A.d()
x=t.d
x===$&&A.d()
w=x.x
w===$&&A.d()
v=s.aE(w)
t=t.f
t===$&&A.d()
x=x.x
x===$&&A.d()
return A.aq(u,u,C.n,u,u,new A.a2(t.aE(x),u,u,A.ab(12),u,u,C.q),u,v,u,u,u,u,u,v)},
$S:837};(function aliases(){var x=B.a_f.prototype
x.adz=x.m})();(function installTearOffs(){var x=a.installStaticTearOff
x(B,"cdF",3,null,["$1$3","$3"],["bHb",function(d,e,f){return B.bHb(d,e,f,y.m)}],0,0)
x(B,"cdG",3,null,["$3"],["bU7"],1,0)})();(function inheritance(){var x=a.mixinHard,w=a.inherit,v=a.inheritMany
w(B.Bn,A.r)
w(B.a_f,A.t)
w(B.apl,B.a_f)
w(B.bm2,A.bG)
v(A.J,[B.r9,B.AA,B.QO])
w(B.RS,A.cT)
x(B.a_f,A.fa)})()
A.ag(b.typeUniverse,JSON.parse('{"Bn":{"r":[],"b":[]},"apl":{"t":["Bn"]},"r9":{"w_":["1"]},"AA":{"w_":["1"]},"QO":{"w_":["1"]},"RS":{"cT":["1"],"cT.T":"1"}}'))
var y={t:A.e("f<w_<C>>"),A:A.e("f<w_<E>>"),o:A.e("f<w_<ad?>>"),u:A.e("f<b>"),b:A.e("C"),m:A.e("@"),e:A.e("E"),C:A.e("ad?")};(function constants(){D.Vx=new B.r9(0,10,C.it,A.e("r9<E>"))
D.Vy=new B.r9(24,72,C.aY,A.e("r9<C>"))
D.Vz=new B.r9(C.d9,C.pI,C.kj,A.e("r9<ad?>"))
D.a0d=new B.QO(A.e("QO<C>"))
D.bUB=new B.AA(24,A.e("AA<C>"))
D.bUC=new B.AA(C.d9,A.e("AA<ad?>"))
D.c37=new A.bj(!0,null,null,null,null,null,13,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)})()};
(a=>{a["O9AcT2WrDGiF1MPyi1oiFKsG/3Q="]=a.current})($__dart_deferred_initializers__);