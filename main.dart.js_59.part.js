((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,C,B={
cnQ(){return new B.zX(null)},
zX:function zX(d){this.a=d},
aAR:function aAR(d,e){var _=this
_.f=_.e=_.d=$
_.cn$=d
_.aE$=e
_.c=_.a=null},
bIy:function bIy(d){this.a=d},
a71:function a71(){},
c0y(d,e,f){var x,w,v,u="keyframes",t=d.length
if(t===0)throw A.w(A.f8(d,u,"No keyframes found"))
for(x=C.B,w=0;w<d.length;d.length===t||(0,A.N)(d),++w){v=d[w]
if(v.gef().a<=0)throw A.w(A.f8(v.gef(),u,"Keyframe durations must be positive"))
x=new A.au(x.a+v.gef().a)}t=e==null?A.aDO(B.cSI(),f.i("0?")):e
return new B.XF(t,x,A.eM(d,f.i("yE<0>")),f.i("XF<0>"))},
c8O(d,e,f,g){if(A.rd(d)&&A.rd(e))return g.a(C.f.ak(d+(e-d)*f))
if(typeof d=="number"&&typeof e=="number")return g.a(d+(e-d)*f)
throw A.w(A.eg("TimelineAnimation<"+A.da(g).m(0)+"> cannot interpolate "+J.bp(d).m(0)+"; pass an explicit `lerp` (see Transformers).",null))},
cnV(d,e,f){return A.hA(d,e,f)},
uy:function uy(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.$ti=g},
DJ:function DJ(d,e){this.a=d
this.$ti=e},
Wz:function Wz(d){this.$ti=d},
XF:function XF(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.$ti=g}},D,E
J=c[1]
A=c[0]
C=c[2]
B=a.updateHolder(c[136],B)
D=c[471]
E=c[249]
B.zX.prototype={
q(){return new B.aAR(null,null)}}
B.aAR.prototype={
aa(){var x,w,v=this,u=null
v.af()
x=B.c0y(A.a([D.YR,D.a1t,D.c8m],y.t),u,y.b)
v.e!==$&&A.bS()
v.e=x
w=B.c0y(A.a([D.YS,D.c8n],y.o),B.cSJ(),y.C)
v.f!==$&&A.bS()
v.f=w
x=A.e4(u,x.b,u,u,v)
x.AZ()
v.d!==$&&A.bS()
v.d=x},
l(){var x=this.d
x===$&&A.f()
x.l()
this.ar0()},
k(d){var x,w=null,v=this.d
v===$&&A.f()
v=A.fr(v,new B.bIy(this),w)
x=this.e
x===$&&A.f()
return A.as(A.u(A.a([v,C.e2,A.d("total "+C.h.aY(x.b.a,1000)+"ms \xb7 segments "+x.c.length+" \xb7 int lerp \u2192 "+B.c0y(A.a([D.YQ],y.A),w,y.e).aG(0.5),w,w,w,w,w,w,w,w,E.WD,C.a1,w,w,w)],y.u),C.l,w,C.c,C.j,0,C.i),w,w)}}
B.a71.prototype={
l(){var x=this,w=x.aE$
if(w!=null)w.O(x.gem())
x.aE$=null
x.P()},
bA(){this.c4()
this.bY()
this.en()}}
B.uy.prototype={
zQ(d,e,f){var x=d.a.$3(this.a,this.b,f)
return x==null?this.$ti.c.a(x):x},
$iyE:1,
gef(){return this.c}}
B.DJ.prototype={
zQ(d,e,f){var x
if(e<=0)return this.a
x=e-1
x=d.a.$3(d.c[x].zQ(d,x,1),this.a,f)
return x==null?this.$ti.c.a(x):x},
$iyE:1,
gef(){return C.p_}}
B.Wz.prototype={
zQ(d,e,f){var x
if(e<=0)throw A.w(A.bw("StillKeyframe without a value needs a previous keyframe to hold, but it is the first segment of the timeline."))
x=e-1
return d.c[x].zQ(d,x,1)},
$iyE:1,
gef(){return C.aJ}}
B.XF.prototype={
aG(d){var x,w,v,u,t,s,r,q,p=this,o=C.f.ak(C.f.A(d,0,1)*p.b.a)
for(x=p.c,w=x.length,v=C.B,u=0;u<w;++u,v=q){t=x[u]
s=v.a
r=s+t.gef().a
q=new A.au(r)
if(o<r)return t.zQ(p,u,(o-s)/t.gef().a)}return C.b.gaq(x).zQ(p,w-1,1)}}
var z=a.updateTypes(["0^(0^,0^,G)<I?>","ae?(ae?,ae?,G)"])
B.bIy.prototype={
$2(d,e){var x,w,v,u=null,t=this.a,s=t.e
s===$&&A.f()
x=t.d
x===$&&A.f()
w=x.x
w===$&&A.f()
v=s.aG(w)
t=t.f
t===$&&A.f()
x=x.x
x===$&&A.f()
return A.ag(u,u,C.n,u,u,new A.V(t.aG(x),u,u,A.a4(12),u,u,u,C.o),u,v,u,u,u,u,u,v)},
$S:955};(function aliases(){var x=B.a71.prototype
x.ar0=x.l})();(function installTearOffs(){var x=a.installStaticTearOff
x(B,"cSI",3,null,["$1$3","$3"],["c8O",function(d,e,f){return B.c8O(d,e,f,y.m)}],0,0)
x(B,"cSJ",3,null,["$3"],["cnV"],1,0)})();(function inheritance(){var x=a.mixinHard,w=a.inherit,v=a.inheritMany
w(B.zX,A.q)
w(B.a71,A.t)
w(B.aAR,B.a71)
w(B.bIy,A.bD)
v(A.I,[B.uy,B.DJ,B.Wz])
w(B.XF,A.cJ)
x(B.a71,A.eu)})()
A.ao(b.typeUniverse,JSON.parse('{"zX":{"q":[],"b":[]},"aAR":{"t":["zX"]},"uy":{"yE":["1"]},"DJ":{"yE":["1"]},"Wz":{"yE":["1"]},"XF":{"cJ":["1"],"cJ.T":"1"}}'))
var y={t:A.j("i<yE<G>>"),A:A.j("i<yE<B>>"),o:A.j("i<yE<ae?>>"),u:A.j("i<b>"),b:A.j("G"),m:A.j("@"),e:A.j("B"),C:A.j("ae?")};(function constants(){D.YQ=new B.uy(0,10,C.k7,A.j("uy<B>"))
D.YR=new B.uy(24,72,C.be,A.j("uy<G>"))
D.YS=new B.uy(C.fA,C.tj,C.me,A.j("uy<ae?>"))
D.a1t=new B.Wz(A.j("Wz<G>"))
D.c8m=new B.DJ(24,A.j("DJ<G>"))
D.c8n=new B.DJ(C.fA,A.j("DJ<ae?>"))})()};
(a=>{a["FmuufJxAE1TgWUxs2T+0AZH9aUA="]=a.current})($__dart_deferred_initializers__);