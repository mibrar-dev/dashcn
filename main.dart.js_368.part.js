((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,C,F,G,B={y6:function y6(d,e,f,g,h,i,j,k,l,m,n,o,p,q){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h
_.f=i
_.r=j
_.w=k
_.x=l
_.y=m
_.Q=n
_.ax=o
_.ay=p
_.CW=q},y5:function y5(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},QM:function QM(d,e){this.a=d
this.b=e},
c6g(d,e,f,g,h,i,j,k,l,m,n){return new B.QN(j,h,k,g,m,d,e,i,n,l,f)},
QN:function QN(d,e,f,g,h,i,j,k,l,m,n){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h
_.w=i
_.x=j
_.y=k
_.z=l
_.Q=m
_.at=n},
aLR:function aLR(){},
Li:function Li(d,e,f){this.a=d
this.b=e
this.c=f},
wB:function wB(d,e,f,g,h){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h},
b72:function b72(d,e,f,g,h){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h},
c9C(d){var x,w,v,u=new B.bMY(d).b1p(),t=u.a
if(t!=="svg")throw A.x(A.cE("Expected a root <svg> element, got <"+t+">",null,null))
x=B.coJ(u)
w=A.S(y.N,y.P)
B.c9D(u,w)
v=A.a([],y.j)
new B.bp_(w,v).aja(u,new B.atG(A.eu(),C.c_,!0,1,D.bQN))
return new B.zQ(x,v)},
coJ(d){var x,w,v,u,t,s=d.JY("viewBox")
if(s!=null){x=B.bPT(s)
if(x.length!==4)throw A.x(A.cE("Expected four numbers in viewBox, got: "+s,null,null))
w=x[0]
v=x[1]
return new A.T(w,v,w+x[2],v+x[3])}u=B.ccF(d.JY("width"))
t=B.ccF(d.JY("height"))
if(u==null||t==null)throw A.x(D.bv_)
return new A.T(0,0,0+u,0+t)},
c9D(d,e){var x,w,v,u,t,s
for(x=d.c,w=x.length,v=0;v<x.length;x.length===w||(0,A.N)(x),++v){u=x[v]
if(u.a==="clipPath"){t=u.b.j(0,"id")
s=t==null||t.length===0?null:t
if(s!=null)e.p(0,s,u.c)}B.c9D(u,e)}},
caG(d){var x,w,v,u,t,s,r=d.JY("style")
if(r==null)return d.b
x=y.N
w=A.ig(d.b,x,x)
for(x=r.split(";"),v=x.length,u=0;u<v;++u){t=x[u]
s=C.d.ce(t,":")
if(s<=0)continue
w.p(0,C.d.ar(C.d.U(t,0,s)),C.d.ar(C.d.aM(t,s+1)))}return w},
iP(d,e){var x=d.j(0,e)
return x==null||x.length===0?null:C.d.ar(x)},
bPT(d){var x,w,v,u,t,s=A.a([],y.n)
for(x=$.chO().tp(0,d),x=new A.wN(x.a,x.b,x.c),w=y.F;x.u();){v=x.d
u=(v==null?w.a(v):v).b[0]
u.toString
t=A.em(u)
if(t!=null)s.push(t)}return s},
ccF(d){if(d==null)return null
return A.em(C.d.ar(C.d.dW(d,"px")?C.d.U(d,0,d.length-2):d))},
cAp(d){var x,w,v,u,t,s,r,q=C.d.ar(d)
if(q.length===0||q==="none"||q==="transparent")return null
if(C.d.ac(q,"#")){x=C.d.aM(q,1)
w=x.length
switch(w){case 3:case 4:for(v=0,u="";v<w;++v,u=t){t=x[v]
t=u+t+t}return B.ccB(u.charCodeAt(0)==0?u:u)
case 6:case 8:return B.ccB(x)
default:return null}}s=$.chQ().h9(q)
if(s!=null){w=s.b[1]
w.toString
r=B.bPT(w)
w=r.length
if(w<3)return null
return A.e4(C.f.ai(C.f.v(w>3?r[3]:1,0,1)*255),C.i.v(C.f.ai(r[0]),0,255),C.i.v(C.f.ai(r[1]),0,255),C.i.v(C.f.ai(r[2]),0,255))}return D.c01.j(0,q.toLowerCase())},
ccB(d){var x=A.fA(d,16)
if(x==null)return null
if(d.length===6)return A.cs((x|4278190080)>>>0)
return A.cs(((x&255)<<24|C.i.eK(x,8))>>>0)},
ccI(d){var x,w,v,u,t,s,r,q,p,o,n,m,l,k=A.eu()
for(x=$.cia().tp(0,d),x=new A.wN(x.a,x.b,x.c),w=y.F;x.u();){v=x.d
u=(v==null?w.a(v):v).b
t=u[1]
t.toString
u=u[2]
u.toString
s=B.bPT(u)
switch(t){case"matrix":if(s.length===6){u=s[0]
t=s[1]
r=s[2]
q=s[3]
p=s[4]
o=s[5]
n=new Float64Array(16)
n[15]=1
n[14]=0
n[13]=o
n[12]=p
n[11]=0
n[10]=1
n[9]=0
n[8]=0
n[7]=0
n[6]=0
n[5]=q
n[4]=r
n[3]=0
n[2]=0
n[1]=t
n[0]=u
k.ek(new A.cg(n))}break
case"translate":u=s.length
if(u!==0){t=s[0]
k.dT(t,u>1?s[1]:0,0,1)}break
case"scale":u=s.length
if(u!==0){t=s[0]
k.qQ(t,u>1?s[1]:t,1,1)}break
case"rotate":u=s.length
if(u!==0){m=s[0]*3.141592653589793/180
if(u>=3){k.dT(s[1],s[2],0,1)
k.yg(m)
k.dT(-s[1],-s[2],0,1)}else k.yg(m)}break
case"skewX":if(s.length!==0){u=s[0]
l=A.eu()
t=l.a
u=Math.tan(u*3.141592653589793/180)
t.$flags&2&&A.aG(t)
t[4]=u
k.ek(l)}break
case"skewY":if(s.length!==0){u=s[0]
l=A.eu()
t=l.a
u=Math.tan(u*3.141592653589793/180)
t.$flags&2&&A.aG(t)
t[1]=u
k.ek(l)}break}}return k},
akh:function akh(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},
zQ:function zQ(d,e){this.a=d
this.b=e},
atG:function atG(d,e,f,g,h){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h},
bp_:function bp_(d,e){this.a=d
this.b=e},
ceR(d,e){var x=new A.ck($.aq().r,C.ai,null,null,A.a([],y.v))
x.stQ(e)
new B.bHn(d,x).aiL()
return x},
bHn:function bHn(d,e){var _=this
_.a=d
_.b=e
_.r=_.f=_.e=_.d=_.c=0
_.z=_.y=_.x=_.w=null},
cqQ(d){if(!C.d.B(d,"&"))return d
return A.c3S(d,$.chb(),new B.bMZ(),null)},
Ma:function Ma(d,e,f){this.a=d
this.b=e
this.c=f},
bMY:function bMY(d){this.a=d
this.b=0},
bMZ:function bMZ(){},
aLO:function aLO(d){var _=this
_.a=d
_.b=null
_.c=!1
_.d=null
_.e=!1},
aLP:function aLP(d){this.a=d},
aLQ:function aLQ(d){this.a=d},
ab8:function ab8(d,e,f){this.e=d
this.c=e
this.a=f},
Vc:function Vc(d,e,f,g,h,i,j){var _=this
_.K=d
_.a5=e
_.X=f
_.b1=_.bt=null
_.bL=g
_.H$=h
_.dy=i
_.b=_.fy=null
_.c=0
_.y=_.d=null
_.z=!0
_.Q=null
_.as=!1
_.at=null
_.ay=$
_.ch=j
_.CW=!1
_.cx=$
_.cy=!0
_.db=!1
_.dx=$},
b73:function b73(d,e){this.a=d
this.b=e},
b74:function b74(d){this.a=d},
GG:function GG(d,e,f){this.c=d
this.d=e
this.a=f},
aF7:function aF7(d){this.a=d},
ay4:function ay4(d,e,f){this.c=d
this.d=e
this.a=f},
vd:function vd(d,e,f,g){var _=this
_.c=d
_.d=e
_.e=f
_.a=g},
arf:function arf(){this.d=$
this.c=this.a=null},
blq:function blq(d){this.a=d},
blp:function blp(d){this.a=d},
bZu(d){var x,w
for(x=0;x<5;++x){w=D.mA[x]
if(w.a===d)return w}return null},
y7:function y7(d,e,f){this.a=d
this.c=e
this.d=f},
aLS:function aLS(){},
acJ:function acJ(d,e,f,g,h,i,j){var _=this
_.c=d
_.d=e
_.e=f
_.f=g
_.r=h
_.w=i
_.a=j},
aQT:function aQT(d,e){this.a=d
this.b=e},
aQV:function aQV(d){this.a=d},
aQU:function aQU(d){this.a=d},
aQX:function aQX(d){this.a=d},
aQW:function aQW(d){this.a=d},
ayd:function ayd(d,e,f,g){var _=this
_.c=d
_.d=e
_.e=f
_.a=g},
aR4(d,e,f,g,h,i,j){return new B.S2(e,g,f,h,j,i,d,null)},
S2:function S2(d,e,f,g,h,i,j,k){var _=this
_.c=d
_.d=e
_.e=f
_.f=g
_.r=h
_.w=i
_.y=j
_.a=k},
a0C:function a0C(d,e){var _=this
_.d=d
_.e=e
_.c=_.a=_.f=null},
bpY:function bpY(d,e,f){this.a=d
this.b=e
this.c=f},
bpW:function bpW(d,e){this.a=d
this.b=e},
bpX:function bpX(d,e){this.a=d
this.b=e},
bpZ:function bpZ(d){this.a=d},
aoz:function aoz(d,e,f,g){var _=this
_.c=d
_.d=e
_.e=f
_.a=g},
bdn:function bdn(d,e){this.a=d
this.b=e},
a7j(d){return A.aB(["left",d.a,"top",d.b,"right",d.c,"bottom",d.d],y.N,y.X)}},D,E
J=c[1]
A=c[0]
C=c[2]
F=c[476]
G=c[192]
B=a.updateHolder(c[166],B)
D=c[484]
E=c[485]
B.y6.prototype={
Y4(d){var x,w,v,u,t=this,s=t.y,r=t.r
if(r==null)r=null
if(d===C.j0)return B.c6g(t.CW,t.x,null,t.f,C.j0,s,t.a,t.w,C.V,r,s)
x=t.Q
if(x==null){w=s.b
v=new A.O(w,0,w,s.d)}else v=x
if(x==null){w=s.b
u=new A.O(w,0,w,s.d)}else u=x
w=t.w
return B.c6g(t.CW,t.x,null,t.f,C.mX,v,t.a,new A.a8(w.b,w.a),C.V,r,u)},
b2O(){return this.Y4(C.j0)},
cf(){var x,w=this,v=y.N,u=y.X,t=A.S(v,u)
t.p(0,"id",w.a)
t.p(0,"name",w.b)
t.p(0,"brand",w.c)
x=w.d
if(x!=null)t.p(0,"year",x)
t.p(0,"platform",w.e.b)
t.p(0,"kind",w.CW.b)
x=w.w
t.p(0,"portraitSize",A.aB(["width",x.a,"height",x.b],v,u))
t.p(0,"frame",w.f.cf())
v=w.r
if(v!=null)t.p(0,"systemUi",v.cf())
t.p(0,"devicePixelRatio",w.x)
t.p(0,"portraitPadding",B.a7j(w.y))
v=w.Q
if(v!=null)t.p(0,"landscapePadding",B.a7j(v))
t.p(0,"systemGestureInsets",B.a7j(C.V))
v=w.ax
if(v!=null)t.p(0,"portraitKeyboardHeight",v)
v=w.ay
if(v!=null)t.p(0,"landscapeKeyboardHeight",v)
return t},
h(d,e){var x=this
if(e==null)return!1
if(x===e)return!0
return e instanceof B.y6&&e.a===x.a&&e.b===x.b&&e.c===x.c&&e.d==x.d&&e.e===x.e&&e.f.h(0,x.f)&&J.z(e.r,x.r)&&e.w.h(0,x.w)&&e.x===x.x&&e.y.h(0,x.y)&&J.z(e.Q,x.Q)&&C.V.h(0,C.V)&&e.ax==x.ax&&e.ay==x.ay&&A.cN(D.wD,D.wD)&&e.CW===x.CW},
gt(d){var x=this
return A.X(x.a,x.b,x.c,x.d,x.e,x.f,x.r,x.w,x.x,x.y,null,x.Q,null,C.V,x.ax,x.ay,A.by(D.wD),x.CW,C.a,C.a)},
m(d){return"DevicePreset("+this.a+", "+this.b+")"}}
B.y5.prototype={
aTN(d,e){var x,w,v,u=this.b,t=-u.a
u=-u.b
x=this.a
w=t+x.a
x=u+x.b
if(e===C.j0)return new A.T(t,u,w,x)
v=d.b
return new A.T(u,v-w,x,v-t)},
cf(){var x=this,w=y.N,v=y.X,u=A.S(w,v),t=x.a
u.p(0,"size",A.aB(["width",t.a,"height",t.b],w,v))
t=x.b
if(!t.h(0,C.y))u.p(0,"screenOffset",A.aB(["x",t.a,"y",t.b],w,v))
w=x.c
if(w.length!==0)u.p(0,"screenPath",w)
w=x.d
if(w.length!==0)u.p(0,"body",w)
return u},
h(d,e){var x=this
if(e==null)return!1
if(x===e)return!0
return e instanceof B.y5&&e.a.h(0,x.a)&&e.b.h(0,x.b)&&e.c===x.c&&e.d===x.d},
gt(d){var x=this
return A.X(x.a,x.b,x.c,x.d,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a)},
m(d){var x=this
return"DeviceFrame(size: "+x.a.m(0)+", screenOffset: "+x.b.m(0)+", screenPath: "+x.c.length+" chars, body: "+x.d.length+" chars)"}}
B.QM.prototype={
J(){return"DeviceKind."+this.b}}
B.QN.prototype={
gaUV(){var x=this.c,w=new A.T(0,0,0+x.a,0+x.b),v=this.d,u=v.a.gak(0)
if(u)return w
return w.ia(v.aTN(x,this.b))},
cf(){var x,w=this,v=y.N,u=y.X,t=A.S(v,u)
t.p(0,"presetId",w.a)
t.p(0,"orientation",w.b.b)
x=w.c
t.p(0,"screenSize",A.aB(["width",x.a,"height",x.b],v,u))
t.p(0,"frame",w.d.cf())
v=w.e
if(v!=null)t.p(0,"systemUi",v.cf())
t.p(0,"deviceKind",w.w.b)
t.p(0,"devicePixelRatio",w.x)
t.p(0,"padding",B.a7j(w.y))
t.p(0,"viewPadding",B.a7j(w.z))
t.p(0,"systemGestureInsets",B.a7j(w.Q))
v=w.at
if(v!=null){u=A.at(v).i("aA<1,b8<p,I?>>")
v=A.aj(new A.aA(v,new B.aLR(),u),u.i("bj.E"))
t.p(0,"displayFeatures",v)}return t},
h(d,e){var x,w=this
if(e==null)return!1
if(w===e)return!0
x=!1
if(e instanceof B.QN)if(e.a===w.a)if(e.b===w.b)if(e.c.h(0,w.c))if(e.d.h(0,w.d))if(J.z(e.e,w.e))if(e.w===w.w)if(e.x===w.x)if(e.y.h(0,w.y))if(e.z.h(0,w.z))if(e.Q.h(0,w.Q))if(A.cN(e.at,w.at))x=A.cN(null,null)
return x},
gt(d){var x=this,w=null,v=x.at
v=v==null?w:A.by(v)
return A.X(x.a,x.b,x.c,x.d,x.e,!0,w,x.w,x.x,x.y,x.z,x.Q,w,v,w,w,w,w,w,w)},
m(d){var x,w=this,v=A.a([],y.s)
v.push("presetId: "+w.a)
v.push("orientation: "+w.b.b)
v.push("screenSize: "+w.c.m(0))
v.push("frame: "+w.d.m(0))
x=w.e
if(x!=null)v.push("systemUi: "+x.m(0))
v.push("deviceKind: "+w.w.b)
v.push("devicePixelRatio: "+w.x)
v.push("padding: "+w.y.m(0))
v.push("viewPadding: "+w.z.m(0))
v.push("systemGestureInsets: "+w.Q.m(0))
x=w.at
if(x!=null)v.push("displayFeatures: "+A.F(x))
return"DeviceSimulation("+C.b.aT(v,", ")+")"}}
B.Li.prototype={
cf(){var x=A.S(y.N,y.X),w=this.a,v=w.gak(0)
if(!v)x.p(0,"statusBar",w.cf())
w=this.b
v=w.gak(0)
if(!v)x.p(0,"navigationBar",w.cf())
x.p(0,"platform",this.c.b)
return x},
h(d,e){var x=this
if(e==null)return!1
if(x===e)return!0
return e instanceof B.Li&&e.a.h(0,x.a)&&e.b.h(0,x.b)&&e.c===x.c},
gt(d){return A.X(this.a,this.b,this.c,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a)},
m(d){return"SystemUiSimulation(statusBar: "+this.a.m(0)+", navigationBar: "+this.b.m(0)+", platform: "+this.c.m(0)+")"}}
B.wB.prototype={
gak(d){return this.a.length===0&&this.b.length===0&&this.c.length===0},
cf(){var x=this,w=A.S(y.N,y.X),v=x.a
if(v.length!==0)w.p(0,"leading",v)
v=x.b
if(v.length!==0)w.p(0,"center",v)
v=x.c
if(v.length!==0)w.p(0,"trailing",v)
w.p(0,"inset",x.d)
v=x.e
if(v!=null)w.p(0,"bottomInset",v)
return w},
h(d,e){var x=this
if(e==null)return!1
if(x===e)return!0
return e instanceof B.wB&&e.a===x.a&&e.b===x.b&&e.c===x.c&&e.d===x.d&&e.e==x.e},
gt(d){var x=this
return A.X(x.a,x.b,x.c,x.d,x.e,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a)},
m(d){var x=this
return"SystemUiBar(leading: "+x.a.length+" chars, center: "+x.b.length+" chars, trailing: "+x.c.length+" chars, inset: "+x.d+", bottomInset: "+A.F(x.e)+")"}}
B.b72.prototype={
h(d,e){var x=this
if(e==null)return!1
if(x===e)return!0
return e instanceof B.b72&&e.a.h(0,x.a)&&e.b.h(0,x.b)&&e.c.h(0,x.c)&&e.d.h(0,x.d)&&e.e.h(0,x.e)},
gt(d){var x=this
return A.X(x.a,x.b,x.c,x.d,x.e,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a)},
m(d){return"SystemUiColors(statusBarIcons: "+this.a.m(0)+", navigationBarIcons: "+this.b.m(0)+")"}}
B.akh.prototype={}
B.zQ.prototype={
b1e(d,e){var x,w,v,u,t,s,r,q,p,o,n,m,l,k
$.aq()
x=A.bm()
x.f=!0
for(w=this.b,v=w.length,u=d.a,t=e!=null,s=0;s<w.length;w.length===v||(0,A.N)(w),++s){r=w[s]
q=t&&r.d
p=r.b
if(q)p=e.aG(e.a*p.a)
q=r.c
if(q.length===0){q=r.a
x.r=p.I()
o=x.bk()
n=q.e
u.drawPath((n==null?q.e=new A.km(q.ghf().a.snapshot()):n).a,o)
o.delete()
continue}J.bv(u.save())
for(n=q.length,m=0;m<q.length;q.length===n||(0,A.N)(q),++m){l=q[m]
k=l.e
if(k==null)k=l.e=new A.km(l.ghf().a.snapshot())
u.clipPath(k.a,$.Ou(),!0)}q=r.a
x.r=p.I()
o=x.bk()
n=q.e
u.drawPath((n==null?q.e=new A.km(q.ghf().a.snapshot()):n).a,o)
o.delete()
u.restore()}},
ahK(d,e,f){var x,w,v,u,t,s,r=this
if(r.b.length===0||r.a.gak(0)||e.gak(0))return
x=d.a
J.bv(x.save())
w=e.a
v=e.b
x.translate(w,v)
u=r.a
t=u.a
s=u.b
d.Bl((e.c-w)/(u.c-t),(e.d-v)/(u.d-s))
x.translate(-t,-s)
r.b1e(d,f)
x.restore()},
b1i(d,e){return this.ahK(d,e,null)}}
B.atG.prototype={}
B.bp_.prototype={
aja(d,e){var x,w,v
for(x=d.c,w=x.length,v=0;v<x.length;x.length===w||(0,A.N)(x),++v)this.aSH(x[v],e)},
aSH(d,e){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j=this,i=d.a
if(D.caV.B(0,i))return
x=B.caG(d)
w=new Float64Array(16)
v=new A.cg(w)
v.bu(e.a)
u=B.iP(x,"transform")
if(u!=null)v.ek(B.ccI(u))
t=B.iP(x,"opacity")
t=t==null?null:A.em(t)
if(t==null)t=1
s=e.d*t
r=B.iP(x,"fill")
q=e.c
if(r==="currentColor"){p=e.b
if(p==null)p=C.c_
q=!0}else if(r==null)p=e.b
else if(r==="none"||r==="transparent")p=null
else{o=B.cAp(r)
t=o==null
p=t?e.b:o
q=t&&q}n=j.aMx(x,v,e)
if(D.caI.B(0,i)){j.aja(d,new B.atG(v,p,q,s,n))
return}if(p==null)return
m=j.a1l(d,x)
if(m==null)return
i=B.iP(x,"fill-opacity")
l=i==null?null:A.em(i)
k=C.f.v(s*(l==null?1:l),0,1)
j.b.push(new B.akh(m.aF(w),p.aG(p.a*k),n,q))},
aMx(a0,a1,a2){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e=null,d=B.iP(a0,"clip-path")
if(d==null)return a2.e
x=$.cic().h9(d)
w=x==null?e:x.b[1]
v=w==null?e:this.a.j(0,w)
if(v==null||v.length===0)return a2.e
u=$.aq()
t=A.a([],y.v)
s=new A.ck(u.r,C.ai,e,e,t)
for(u=v.length,r=y.t,q=0;q<v.length;v.length===u||(0,A.N)(v),++q){p=v[q]
o=B.caG(p)
n=this.a1l(p,o)
if(n==null)continue
m=o.j(0,"transform")
l=m==null||m.length===0?e:C.d.ar(m)
if(l==null)k=n
else{k=B.ccI(l)
j=n.b
i=n.a
h=n.c
g=n.d
f=A.hj(n.r,!0,r)
g=new A.ck(i,j,h,g,f)
f.push(new A.XR(new Float64Array(A.n4(k.a))))
k=g}j=k.b
i=k.c
h=A.hj(k.r,!0,r)
k=new A.uG(new A.ck(k.a,j,i,k.d,h),C.y,e)
t.push(k)
j=s.f
if(j!=null)k.bU(j)
k=s.e
if(k!=null)k.a.delete()
s.e=null}u=A.aj(a2.e,y.i)
u.push(s.aF(a1.a))
return u},
a1l(d,e){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i=null,h=B.iP(e,"fill-rule")==="evenodd"?C.xw:C.ai
switch(d.a){case"path":x=B.iP(e,"d")
if(x==null)return i
return B.ceR(x,h)
case"rect":w=B.iP(e,"width")
v=w==null?i:A.em(w)
if(v==null)v=0
w=B.iP(e,"height")
u=w==null?i:A.em(w)
if(u==null)u=0
if(v<=0||u<=0)return i
w=B.iP(e,"x")
t=w==null?i:A.em(w)
if(t==null)t=0
w=B.iP(e,"y")
s=w==null?i:A.em(w)
if(s==null)s=0
w=B.iP(e,"rx")
r=w==null?i:A.em(w)
w=B.iP(e,"ry")
q=w==null?i:A.em(w)
w=t+v
p=s+u
o=new A.ck($.aq().r,C.ai,i,i,A.a([],y.v))
o.stQ(h)
n=r==null
if((n?q:r)==null)o.aH(new A.rs(new A.T(t,s,w,p)))
else{if(n){q.toString
n=q}else n=r
if(q==null){r.toString
m=r}else m=q
o.aH(new A.iw(new A.qh(t,s,w,p,n,m,n,m,n,m,n,m)))}return o
case"circle":w=B.iP(e,"r")
l=w==null?i:A.em(w)
if(l==null)l=0
if(l<=0)return i
w=new A.ck($.aq().r,C.ai,i,i,A.a([],y.v))
w.stQ(h)
p=B.iP(e,"cx")
p=p==null?i:A.em(p)
if(p==null)p=0
n=B.iP(e,"cy")
n=n==null?i:A.em(n)
w.aH(new A.jW(A.jd(new A.y(p,n==null?0:n),l)))
return w
case"ellipse":w=B.iP(e,"rx")
r=w==null?i:A.em(w)
if(r==null)r=0
w=B.iP(e,"ry")
q=w==null?i:A.em(w)
if(q==null)q=0
if(r<=0||q<=0)return i
w=new A.ck($.aq().r,C.ai,i,i,A.a([],y.v))
w.stQ(h)
p=B.iP(e,"cx")
p=p==null?i:A.em(p)
if(p==null)p=0
n=B.iP(e,"cy")
n=n==null?i:A.em(n)
w.aH(new A.jW(A.K6(new A.y(p,n==null?0:n),q*2,r*2)))
return w
case"polygon":w=B.iP(e,"points")
k=B.bPT(w==null?"":w)
if(k.length<6)return i
w=$.aq()
p=A.a([],y.v)
o=new A.ck(w.r,C.ai,i,i,p)
o.stQ(h)
o.aH(new A.fL(k[0],k[1]))
for(j=2;w=j+1,w<k.length;j+=2){w=new A.du(k[j],k[w])
p.push(w)
n=o.f
if(n!=null)w.bU(n)
w=o.e
if(w!=null)w.a.delete()
o.e=null}o.aH(new A.lH())
return o
default:return i}}}
B.bHn.prototype={
aiL(){var x,w,v,u,t=this
for(x=t.a,w=x.length,v=null;;){t.SD()
u=t.c
if(u>=w)return
if(C.d.B("MmZzLlHhVvCcSsQqTtAa",A.dV(x.charCodeAt(u)))){u=t.c
v=x[u]
t.c=u+1}else if(v==null)throw A.x(A.cE("Expected an SVG path command",x,t.c))
else if(v==="Z"||v==="z")throw A.x(A.cE('Unexpected argument after a "close" command',x,t.c))
t.ay1(v)
if(v==="M")v="L"
else if(v==="m")v="l"}},
ay1(d){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h=this,g=d.toUpperCase()!==d
switch(d.toUpperCase()){case"M":x=h.f9()
w=x+(g?h.d:0)
x=h.f9()
v=x+(g?h.e:0)
h.b.aH(new A.fL(w,v))
h.d=h.f=w
h.e=h.r=v
h.GY()
break
case"L":x=h.f9()
u=g?h.d:0
t=h.f9()
s=g?h.e:0
h.I0(x+u,t+s)
break
case"H":x=h.f9()
u=g?h.d:0
h.I0(x+u,h.e)
break
case"V":x=h.d
u=h.f9()
h.I0(x,u+(g?h.e:0))
break
case"C":r=g?h.d:0
q=g?h.e:0
h.a2N(h.f9()+r,h.f9()+q,h.f9()+r,h.f9()+q,h.f9()+r,h.f9()+q)
break
case"S":r=g?h.d:0
q=g?h.e:0
x=h.f9()
u=h.f9()
t=h.f9()
s=h.f9()
p=h.w
o=h.d
o=p==null?o:2*o-p
p=h.x
n=h.e
n=p==null?n:2*n-p
h.a2N(o,n,x+r,u+q,t+r,s+q)
break
case"Q":r=g?h.d:0
q=g?h.e:0
h.a7R(h.f9()+r,h.f9()+q,h.f9()+r,h.f9()+q)
break
case"T":r=g?h.d:0
q=g?h.e:0
x=h.f9()
u=h.f9()
t=h.y
o=h.d
o=t==null?o:2*o-t
t=h.z
n=h.e
n=t==null?n:2*n-t
h.a7R(o,n,x+r,u+q)
break
case"A":m=Math.abs(h.f9())
l=Math.abs(h.f9())
k=h.f9()
j=h.a3V()
i=h.a3V()
x=h.f9()
w=x+(g?h.d:0)
x=h.f9()
v=x+(g?h.e:0)
if(m===0||l===0)h.I0(w,v)
else{h.b.aH(new A.a86(new A.y(w,v),new A.b9(m,l),k,j,i))
h.d=w
h.e=v
h.GY()}break
case"Z":h.b.aH(new A.lH())
h.d=h.f
h.e=h.r
h.GY()
break
default:throw A.x(A.cE('Unsupported SVG path command "'+d+'"',h.a,h.c))}},
I0(d,e){var x=this
x.b.aH(new A.du(d,e))
x.d=d
x.e=e
x.GY()},
a2N(d,e,f,g,h,i){var x=this
x.b.aH(new A.Qz(d,e,f,g,h,i))
x.d=h
x.e=i
x.z=x.y=null
x.w=f
x.x=g},
a7R(d,e,f,g){var x=this
x.b.aH(new A.tE(d,e,f,g))
x.d=f
x.e=g
x.x=x.w=null
x.y=d
x.z=e},
GY(){var x=this
x.z=x.y=x.x=x.w=null},
SD(){var x,w,v,u
for(x=this.a,w=x.length;v=this.c,v<w;){u=x.charCodeAt(v)
if(u===32||u===9||u===10||u===13||u===12||u===44)this.c=v+1
else return}},
f9(){var x,w,v,u,t,s,r,q,p,o=this
o.SD()
x=o.c
w=o.a
v=w.length
if(x<v){u=w.charCodeAt(x)
if(u===43||u===45){t=x+1
o.c=t}else t=x}else t=x
for(;;){s=t<v
if(s){r=w.charCodeAt(t)
r=r>=48&&r<=57}else r=!1
if(!r)break;++t
o.c=t}if(s&&w.charCodeAt(t)===46){++t
o.c=t
for(;;){if(t<v){s=w.charCodeAt(t)
s=s>=48&&s<=57}else s=!1
if(!s)break;++t
o.c=t}}if(t<v){u=w.charCodeAt(t)
if(u===101||u===69){s=o.c=t+1
if(s<v){q=w.charCodeAt(s)
if(q===43||q===45){++s
o.c=s}}if(s<v){r=w.charCodeAt(s)
r=r>=48&&r<=57}else r=!1
if(r){t=s
for(;;){if(t<v){s=w.charCodeAt(t)
s=s>=48&&s<=57}else s=!1
if(!s)break;++t
o.c=t}v=t}else{o.c=t
v=t}}else v=t}else v=t
p=A.em(C.d.U(w,x,v))
if(p==null)throw A.x(A.cE("Expected a number",w,x))
return p},
a3V(){var x,w,v,u=this
u.SD()
x=u.c
w=u.a
if(x>=w.length)throw A.x(A.cE("Expected an arc flag",w,x))
v=w.charCodeAt(x)
if(v!==48&&v!==49)throw A.x(A.cE('Expected an arc flag ("0" or "1")',w,x))
u.c=x+1
return v===49}}
B.Ma.prototype={
JY(d){var x=this.b.j(0,d)
return x==null||x.length===0?null:x},
m(d){var x=this.b
return"<"+this.a+" "+new A.co(x,A.R(x).i("co<1>")).aT(0," ")+">"}}
B.bMY.prototype={
b1p(){var x,w,v,u=this
for(x=u.a,w=x.length;;){u.Dp()
v=u.b
if(v>=w)throw A.x(A.cE("No XML element found",x,v))
if(!C.d.c3(x,"<",v))throw A.x(A.cE("Expected an element",x,v))
if(C.d.c3(x,"<?",v))u.zn("?>")
else if(C.d.c3(x,"<!--",v))u.zn("-->")
else if(C.d.c3(x,"<!",v))u.aa6()
else return u.a7j()}},
a7j(){var x,w,v,u,t,s,r,q,p,o,n=this
n.aya("<")
x=n.RS()
w=y.N
v=A.S(w,w)
for(w=n.a;;){n.Dp()
u=n.b
if(C.d.c3(w,"/>",u)){n.b=u+2
t=C.d.ce(x,":")
return new B.Ma(t===-1?x:C.d.aM(x,t+1),v,D.bQO)}if(C.d.c3(w,">",u)){n.b=u+1
break}s=n.RS()
n.Dp()
u=n.b
if(!C.d.c3(w,"=",u))A.aH(A.cE('Expected "="',w,u))
n.b=u+1
n.Dp()
v.p(0,s,n.aLI())}r=A.a([],y.y)
for(u=w.length;;){q=n.b
n.aPq(60)
p=n.b
if(p>=u)throw A.x(A.cE('Unterminated element "<'+x+'>"',w,q))
if(C.d.c3(w,"</",p)){n.b=p+2
o=n.RS()
n.Dp()
u=n.b
if(!C.d.c3(w,">",u))A.aH(A.cE('Expected ">"',w,u));++u
n.b=u
if(o!==x)throw A.x(A.cE('Closing tag "</'+o+'>" does not match "<'+x+'>"',w,u))
t=C.d.ce(x,":")
return new B.Ma(t===-1?x:C.d.aM(x,t+1),v,r)}if(C.d.c3(w,"<!--",p))n.zn("-->")
else if(C.d.c3(w,"<![CDATA[",p))n.zn("]]>")
else if(C.d.c3(w,"<?",p))n.zn("?>")
else if(C.d.c3(w,"<!",p))n.aa6()
else r.push(n.a7j())}},
aya(d){var x=this.a,w=this.b
if(!C.d.c3(x,d,w))throw A.x(A.cE('Expected "'+d+'"',x,w))
this.b=w+d.length},
zn(d){var x=this.a,w=this.b,v=C.d.ii(x,d,w)
if(v===-1)throw A.x(A.cE('Expected "'+d+'"',x,w))
this.b=v+d.length},
aPq(d){var x,w=this.a,v=w.length
for(;;){x=this.b
if(!(x<v&&w.charCodeAt(x)!==d))break
this.b=x+1}},
aa6(){var x,w,v,u,t,s=this
s.b+=2
x=s.a
w=x.length
v=1
for(;;){u=s.b
if(!(u<w&&v>0))break
A:{t=x.charCodeAt(u)
if(t===91){s.zn("]")
break A}if(t===62)--v
s.b=u+1}}if(v>0)throw A.x(A.cE("Unterminated declaration",x,u))},
Dp(){var x,w,v,u
for(x=this.a,w=x.length;v=this.b,v<w;){u=x.charCodeAt(v)
if(u===32||u===9||u===10||u===13)this.b=v+1
else return}},
RS(){var x,w,v,u,t,s,r=this.b
for(x=this.a,w=x.length,v=r;v<w;){u=x.charCodeAt(v)
t=!0
if(!(u>=65&&u<=90))if(!(u>=97&&u<=122)){s=u>=48&&u<=57||u===45||u===95||u===46||u===58
t=s}if(!t)break;++v
this.b=v}if(v===r)throw A.x(A.cE("Expected a name",x,r))
return C.d.U(x,r,v)},
aLI(){var x,w,v,u=this,t=u.b,s=u.a,r=s.length
if(t>=r)throw A.x(A.cE("Expected an attribute value",s,t))
x=s.charCodeAt(t)
if(x!==34&&x!==39)throw A.x(A.cE("Attribute values must be quoted",s,t))
t=u.b=t+1
w=t
for(;;){if(!(w<r&&s.charCodeAt(w)!==x))break;++w
u.b=w}if(w>=r)throw A.x(A.cE("Unterminated attribute value",s,t))
v=C.d.U(s,t,w)
u.b=w+1
return B.cqQ(v)}}
B.aLO.prototype={
gadg(){var x=this
if(!x.c){x.c=!0
if(x.a.d.length!==0)x.b=x.a4L(new B.aLP(x),"body artwork")}return x.b},
gaks(){var x=this
if(!x.e){x.e=!0
if(x.a.c.length!==0)x.d=x.a4L(new B.aLQ(x),"screen outline")}return x.d},
akr(d,e){var x,w=this.gaks()
if(w==null)return null
if(e===C.j0)return w
x=A.eu()
x.dT(0,d.b,0,1)
x.yg(-1.5707963267948966)
return w.aF(x.a)},
b1f(d,e,f){var x,w,v,u,t=this.gadg()
if(t==null||t.b.length===0)return
x=d.a
J.bv(x.save())
if(f===C.mX){x.translate(0,e.b)
d.MJ(-1.5707963267948966)}w=this.a
v=w.b
u=-v.a
v=-v.b
w=w.a
t.b1i(d,new A.T(u,v,u+w.a,v+w.b))
x.restore()},
azS(d,e){var x,w,v,u
try{v=d.$0()
return v}catch(u){x=A.aK(u)
w=A.bh(u)
v=A.bU("while parsing the device frame "+e)
A.dM(new A.cd(x,w,"device_preview",v,null,!1))
return null}},
a4L(d,e){return this.azS(d,e,y.z)}}
B.ab8.prototype={
aN(d){var x=A.ds(d)
if(x==null)x=C.x
x=new B.Vc(this.e,null,x,A.b2(),null,new A.bL(),A.b2())
x.aL()
x.sb3(null)
return x},
aR(d,e){var x
e.samU(this.e)
e.sb1b(null)
x=A.ds(d)
e.sc1(x==null?C.x:x)}}
B.Vc.prototype={
samU(d){var x,w=this,v=w.K
if(d===v)return
if(w.y!=null){x=w.gQj()
v.P(x)
d.a1(x)}w.K=d
w.aU()},
sb1b(d){return},
sc1(d){if(d===this.X)return
this.X=d
this.aU()},
aA(d){this.wt(d)
this.K.a1(this.gQj())},
ap(){this.K.P(this.gQj())
this.t9()},
l(){this.bL.saQ(null)
this.iA()},
aCF(){return this.aU()},
gas7(){var x=this,w=x.K.a,v=w==null?null:w.d
if(v==null)return x.bt=null
w=x.bt
if(!J.z(w==null?null:w.a,v))x.bt=new B.aLO(v)
return x.bt},
gas8(){var x,w=this,v=w.K.a,u=v==null?null:v.e
if(u!=null){x=u.a.gak(0)
if(x)x=u.b.gak(0)
else x=!1
if(!x)v.toString}else x=!0
if(x)return w.b1=null
x=w.b1
if(!J.z(x==null?null:x.a,u))w.b1=new B.b73(u,A.S(y.N,y.B))
return w.b1},
aJr(d,e){var x,w,v,u,t,s,r,q,p,o,n=this,m=n.gas8(),l=n.K.a
if(m==null||l==null)return
x=d.geo()
w=x.a
J.bv(w.save())
w.translate(e.a,e.b)
v=n.gD()
u=l.y
t=$.bW().c
s=l.e
s=s==null?null:s.c
if((s==null?null:s)==null)A.b5()
r=t.d===C.aq?C.ct:C.aq
t=r===C.ct
s=t?C.aA:D.Bf
t=t?C.aA:D.Bf
q=n.X
p=m.a
o=u.b
if(o>0)m.a75(x,C.aJ,p.a,C.aJ,!1,new A.T(0,0,0+v.a,0+o),q,s)
u=u.d
if(u>0){s=v.b-u
m.a75(x,C.aJ,p.b,C.aJ,!0,new A.T(0,s,0+v.a,s+u),q,t)}w.restore()},
aJg(d,e){return},
Rm(d,e){this.qY(d,e)
this.aJg(d,e)
this.aJr(d,e)},
av(d,e){var x,w,v,u,t,s,r=this,q=r.gas7()
if(q==null){r.bL.saQ(null)
r.Rm(d,e)
return}x=r.K.a
w=x==null?null:x.b
if(w==null)w=C.j0
v=r.gD()
if(q.gadg()!=null){u=d.geo()
x=u.a
J.bv(x.save())
x.translate(e.a,e.b)
q.b1f(u,v,w)
x.restore()}t=q.akr(v,w)
if(t==null){r.bL.saQ(null)
r.Rm(d,e)
return}x=r.bL
s=r.cx
s===$&&A.f()
x.saQ(d.b1U(s,e,new A.T(0,0,0+v.a,0+v.b),t,r.gaJb(),x.a))}}
B.b73.prototype={
a75(d,e,f,g,h,i,j,k){var x,w,v,u
if(e.a>0){$.aq()
x=A.bm()
x.r=e.I()
d.fB(i,x)}if(g.a>0){x=i.a
w=h?i.b:i.d-1
$.aq()
v=A.bm()
v.r=g.I()
d.fB(new A.T(x,w,x+(i.c-x),w+1),v)}u=j===C.a_
this.Rk(d,-1,f,i,u?f.c:f.a,k)
this.Rk(d,0,f,i,f.b,k)
this.Rk(d,1,f,i,u?f.a:f.c,k)},
Rk(d,e,f,g,h,i){var x,w,v,u,t,s,r
if(h.length===0)return
x=this.axr(h)
w=!0
if(x!=null)if(x.b.length!==0){w=x.a
w=new A.a8(w.c-w.a,w.d-w.b).gak(0)}if(w)return
w=x.a
v=w.c-w.a
w=w.d-w.b
A:{if(e<0){u=g.a+f.d
break A}if(0===e){u=g.gb0().a-v/2
break A}u=g.c-f.d-v
break A}t=f.e
s=t==null?g.gb0().b-w/2:g.d-t-w
r=Math.max(g.b,Math.min(s,g.d-w))
x.ahK(d,new A.T(u,r,u+v,r+w),i)},
axr(d){return this.b.bs(d,new B.b74(d))}}
B.GG.prototype={
b03(){var x,w,v,u,t,s
for(x=this.d,w=0,v=0,u=0;u<5;++u){t=D.mA[u].B7(x)
w+=t.a
s=t.b
if(s>v)v=s}return new A.a8(w+96,v)},
k(d){return A.bG(new B.aF7(this))}}
B.ay4.prototype={
k(d){var x,w,v,u,t,s,r,q,p=null
for(x=this.d,w=0,v=0;v<5;++v){u=D.mA[v].B7(x).b
if(u>w)w=u}t=A.a([],y.p)
for(s=y.O,r=this.c,v=0;v<5;++v){q=D.mA[v]
t.push(new A.P(C.bt,new A.RH(C.i5,C.D,new B.vd(q,r,x,new A.ak("all-page-"+q.a.c,s)),p),p))}x=new A.a64(0)
return new A.w(p,w,new G.JF(x,p,p,A.c9v(t,!0,!0,!0),p),p)}}
B.vd.prototype={
q(){return new B.arf()}}
B.arf.prototype={
a9(){var x,w,v=this
v.af()
x=v.a
x=x.c.NF(x.e)
w=$.a3()
v.d!==$&&A.bJ()
v.d=new A.bI(x,w,y.T)},
al(d){var x,w=this
w.au(d)
x=w.a
if(d.c!==x.c||d.e!==x.e)w.n(new B.blq(w))},
l(){var x=this.d
x===$&&A.f()
x.k1$=$.a3()
x.id$=0
this.O()},
k(d){var x,w,v=null,u=A.h(d),t=this.a,s=t.c,r=t.e,q=s.a_d(r),p=s.b1d(r),o=s.agS(r),n=s.B7(r),m=A.d7(d,v)
t=m==null?D.c43:m
x=t.aWe(s.c.x,p,q,C.V,p)
t=this.d
t===$&&A.f()
w=u.aVG(new B.blp(s))
return A.bb(v,v,new A.w(n.a,n.b,new A.P(o,new B.ab8(t,new A.w(q.a,q.b,A.bt(A.qU(A.Tx(this.a.d,x),w),u.a.b,!0),v),v),v),v),!0,v,v,!1,v,!0,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v)}}
B.y7.prototype={
a_d(d){var x
if(!this.d||d===C.dF)return this.c.w
x=this.c.Y4(C.mX)
return x.c},
b1d(d){var x,w
if(!this.d||d===C.dF)return this.c.y
x=this.c
w=x.Q
if(w==null){x=x.y
w=x.b
x=new A.O(w,0,w,x.d)}else x=w
return x},
NF(d){if(!this.d||d===C.dF)return this.c.b2O()
return this.c.Y4(C.mX)},
agS(d){var x=this.NF(d),w=x.c,v=x.gaUV(),u=v.gak(0)
if(u)return C.V
u=new B.aLS()
return new A.O(u.$1(-v.a),u.$1(-v.b),u.$1(v.c-w.a),u.$1(v.d-w.b))},
B7(d){var x=this.a_d(d),w=this.agS(d)
return new A.a8(x.a+w.a+w.c,x.b+w.b+w.d)}}
B.acJ.prototype={
k(d){var x,w,v,u,t=this,s=null,r=t.r,q=r!=null&&t.w!=null,p=t.c,o=!0
if(p!==C.f_)if(p!==C.lV){x=B.bZu(p)
x=x==null?s:x.d
x=x===!0
o=x}x=A.a([],y.p)
for(w=y.O,v=0;v<7;++v){u=C.Ky[v]
x.push(new B.ayd(u.d,u===p,new B.aQT(t,u),new A.ak("frame-bar-"+u.c,w)))}x.push(C.a3)
if(o)x.push(A.iN(new A.w(28,28,A.U(!1,D.byg,s,s,s,s,D.clA,s,s,s,new B.aQU(t),s,s,C.ek,s,s,C.hi,s,C.X),s),s,new B.aQV(t),C.bb))
if(q)x.push(A.iN(new A.w(28,28,A.U(!1,A.ao(r===C.aq?C.pu:C.pr,s,s,s,14),s,s,s,s,D.clu,s,s,s,new B.aQW(t),s,s,C.ek,s,s,C.hi,s,C.X),s),s,new B.aQX(t),C.bb))
return A.bd(C.v,x,C.aN,s,C.v,4,4)}}
B.ayd.prototype={
k(d){var x=null,w=this.d?C.aG:C.X
return A.U(!1,A.d(this.c,x,x,x,x,x,x,x,x,x,x,x,x,x),x,x,x,x,x,x,x,x,this.e,x,x,C.ek,x,x,x,x,w)}}
B.S2.prototype={
q(){return new B.a0C(C.f_,C.dF)}}
B.a0C.prototype={
aW(){var x,w,v=this
v.bg()
x=v.c
x.toString
x=A.aM(x)
w=x==null?null:x.a
x=v.f
if(w!=x){if(x!=null)x.P(v.gSU())
v.f=w
if(w!=null)w.a1(v.gSU())
v.aaF()}},
l(){var x=this.f
if(x!=null)x.P(this.gSU())
this.O()},
aaF(){var x,w,v,u=this
if(u.a.e!=null||u.f==null)return
x=u.f
w=x.d
v=x.e
if(w!==u.d||v!==u.e)u.n(new B.bpY(u,w,v))},
aH5(d){var x=this,w=x.a
if(w.e!=null){w=w.f
if(w!=null)w.$1(d)
return}x.n(new B.bpW(x,d))
w=x.f
if(w!=null)w.ZR(d)},
aHr(d){var x=this,w=x.a
if(w.r!=null){w=w.w
if(w!=null)w.$1(d)
return}x.n(new B.bpX(x,d))
w=x.f
if(w!=null)w.ZV(d)},
k(d){var x,w,v,u,t,s=this,r=null,q=s.a,p=q.e
if(p==null)p=s.d
x=q.r
if(x==null)x=s.e
w=q.y
q=q.c
v=w!=null?w.$3(p,x,q):new B.aoz(p,x,q,r)
u=new A.hI(v,new A.ak("framed-preview-"+s.a.d,y.O))
q=s.f
w=q==null
if(w)q=r
else{t=q.b
q=t==null?q.c:t}w=w?r:new B.bpZ(s)
return A.u(A.a([new B.acJ(p,s.gaH4(),x,s.gaHq(),q,w,r),C.Z,u],y.p),C.q,r,C.c,C.j,0,C.h)}}
B.aoz.prototype={
k(d){var x=this,w=x.c
if(w===C.f_)return x.e
if(w===C.lV)return new B.GG(x.e,x.d,null)
w=B.bZu(w)
w.toString
return A.bG(new B.bdn(x,w))}}
var z=a.updateTypes(["~()","b8<p,I?>(c9k)","zQ()","~(lW,y)","zQ?()","~(ks)","~(pk)"])
B.aLR.prototype={
$1(d){return d.cf()},
$S:z+1}
B.bMZ.prototype={
$1(d){var x,w=d.t2(1)
w.toString
switch(w){case"amp":return"&"
case"lt":return"<"
case"gt":return">"
case"quot":return'"'
case"apos":return"'"}if(C.d.ac(w,"#x")||C.d.ac(w,"#X")){x=A.fA(C.d.aM(w,2),16)
if(x==null){w=d.t2(0)
w.toString}else w=A.dV(x)
return w}if(C.d.ac(w,"#")){x=A.fA(C.d.aM(w,1),null)
if(x==null){w=d.t2(0)
w.toString}else w=A.dV(x)
return w}w=d.t2(0)
w.toString
return w},
$S:198}
B.aLP.prototype={
$0(){return B.c9C(this.a.a.d)},
$S:z+2}
B.aLQ.prototype={
$0(){return B.ceR(this.a.a.c,C.ai)},
$S:825}
B.b74.prototype={
$0(){var x,w,v,u
try{v=B.c9C(this.a)
return v}catch(u){x=A.aK(u)
w=A.bh(u)
v=A.bU("while parsing simulated system UI")
A.dM(new A.cd(x,w,"device_preview",v,null,!1))
return null}},
$S:z+4}
B.aF7.prototype={
$2(d,e){var x,w,v,u,t,s,r,q=null
if(e.b<700){x=this.a
return new B.ay4(x.c,x.d,q)}x=this.a
w=x.b03()
v=A.a([],y.p)
for(u=y.O,t=x.d,x=x.c,s=0;s<5;++s){r=D.mA[s]
v.push(new B.vd(r,x,t,new A.ak("all-frame-"+r.a.c,u)))}return new A.bi(C.aI,q,q,A.Cl(C.aI,new A.w(w.a,w.b,A.bd(C.be,v,C.a8,q,C.v,24,24),q),C.i5),q)},
$S:16}
B.blq.prototype={
$0(){var x=this.a,w=x.d
w===$&&A.f()
x=x.a
w.sA(x.c.NF(x.e))},
$S:0}
B.blp.prototype={
$0(){return this.a.c.e},
$S:826}
B.aLS.prototype={
$1(d){return isNaN(d)?0:C.f.v(d,0,1/0)},
$S:1}
B.aQT.prototype={
$0(){return this.a.d.$1(this.b)},
$S:0}
B.aQV.prototype={
$1(d){var x=null
return A.d(this.a.e===C.dF?"Rotate to landscape":"Rotate to portrait",x,x,x,x,x,x,x,x,x,x,x,x,x)},
$S:20}
B.aQU.prototype={
$0(){var x=this.a,w=x.e===C.dF?C.CQ:C.dF
return x.f.$1(w)},
$S:0}
B.aQX.prototype={
$1(d){var x=null
return A.d(this.a.r===C.aq?"Switch to light":"Switch to dark",x,x,x,x,x,x,x,x,x,x,x,x,x)},
$S:20}
B.aQW.prototype={
$0(){var x=this.a,w=x.w
w.toString
return w.$1(x.r===C.aq?C.ct:C.aq)},
$S:0}
B.bpY.prototype={
$0(){var x=this.a
x.d=this.b
x.e=this.c},
$S:0}
B.bpW.prototype={
$0(){return this.a.d=this.b},
$S:0}
B.bpX.prototype={
$0(){return this.a.e=this.b},
$S:0}
B.bpZ.prototype={
$1(d){return this.a.f.ZM(d)},
$S:827}
B.bdn.prototype={
$2(d,e){var x=null,w=this.b,v=this.a,u=v.d,t=w.B7(u),s=new B.vd(w,v.e,u,new A.ak("framed-"+w.a.c,y.O))
w=e.b
if(isFinite(w)&&w<t.a)return A.b6(s,x,x,x,x,C.I)
return new A.bi(C.aI,x,x,s,x)},
$S:16};(function installTearOffs(){var x=a._instance_0u,w=a._instance_2u,v=a._instance_1u
var u
x(u=B.Vc.prototype,"gQj","aCF",0)
w(u,"gaJb","Rm",3)
x(u=B.a0C.prototype,"gSU","aaF",0)
v(u,"gaH4","aH5",5)
v(u,"gaHq","aHr",6)})();(function inheritance(){var x=a.inheritMany,w=a.inherit
x(A.I,[B.y6,B.y5,B.QN,B.Li,B.wB,B.b72,B.akh,B.zQ,B.atG,B.bp_,B.bHn,B.Ma,B.bMY,B.aLO,B.b73,B.y7])
w(B.QM,A.dz)
x(A.ax,[B.aLR,B.bMZ,B.aLS,B.aQV,B.aQX,B.bpZ])
x(A.aN,[B.aLP,B.aLQ,B.b74,B.blq,B.blp,B.aQT,B.aQU,B.aQW,B.bpY,B.bpW,B.bpX])
w(B.ab8,A.bB)
w(B.Vc,A.lY)
x(A.m,[B.GG,B.ay4,B.acJ,B.ayd,B.aoz])
x(A.bF,[B.aF7,B.bdn])
x(A.q,[B.vd,B.S2])
x(A.t,[B.arf,B.a0C])})()
A.ap(b.typeUniverse,JSON.parse('{"ab8":{"bB":[],"ba":[],"b":[]},"Vc":{"Z":[],"bO":["Z"],"Y":[],"b7":[]},"GG":{"m":[],"b":[]},"ay4":{"m":[],"b":[]},"vd":{"q":[],"b":[]},"arf":{"t":["vd"]},"acJ":{"m":[],"b":[]},"ayd":{"m":[],"b":[]},"S2":{"q":[],"b":[]},"a0C":{"t":["S2"]},"aoz":{"m":[],"b":[]}}'))
var y=(function rtii(){var x=A.j
return{M:x("eK<p>"),v:x("i<e1>"),s:x("i<p>"),j:x("i<akh>"),p:x("i<b>"),y:x("i<Ma>"),n:x("i<G>"),P:x("a2<Ma>"),i:x("z9"),t:x("e1"),F:x("zn"),N:x("p"),O:x("ak<p>"),T:x("bI<QN?>"),z:x("@"),X:x("I?"),B:x("zQ?")}})();(function constants(){var x=a.makeConstList
D.Bf=new A.ae(1,0.08627450980392157,0.09411764705882353,0.10980392156862745,C.L)
D.bv_=new A.fs("The root <svg> element needs a viewBox or width/height attributes",null,null)
D.byg=new A.bC(F.pt,14,null,null,null)
D.bQN=x([],A.j("i<z9>"))
D.wD=x([],A.j("i<c9k>"))
D.bQO=x([],y.y)
D.ccf=new A.a8(436,908)
D.c5r=new A.y(17,17)
D.aob=new B.y5(D.ccf,D.c5r,"M 317.34,0 C 322.68,0 328.02,0.02 333.37,0.21 C 339.49,0.44 345.54,0.9 351.58,2.03 C 363.77,4.3 374.86,9.23 383.81,18.19 C 392.77,27.14 397.7,38.23 399.97,50.43 C 401.1,56.46 401.56,62.51 401.79,68.62 C 401.98,73.92 402,79.21 402,84.5 L 402,789.5 C 402,794.79 401.98,800.08 401.79,805.38 C 401.56,811.49 401.1,817.54 399.97,823.57 C 397.7,835.77 392.77,846.86 383.81,855.81 C 374.86,864.77 363.77,869.7 351.58,871.97 C 345.54,873.1 339.49,873.56 333.37,873.79 C 328.02,873.98 322.68,874 317.34,874 L 84.66,874 C 79.32,874 73.98,873.98 68.63,873.79 C 62.51,873.56 56.46,873.1 50.42,871.97 C 38.23,869.7 27.14,864.77 18.19,855.81 C 9.23,846.86 4.3,835.77 2.03,823.57 C 0.9,817.54 0.44,811.49 0.21,805.38 C 0.02,800.08 0,794.79 0,789.5 L 0,84.5 C 0,79.21 0.02,73.92 0.21,68.62 C 0.44,62.51 0.9,56.46 2.03,50.43 C 4.3,38.23 9.23,27.14 18.19,18.19 C 27.14,9.23 38.23,4.3 50.42,2.03 C 56.46,0.9 62.51,0.44 68.63,0.21 C 73.98,0.02 79.32,0 84.66,0 L 317.34,0 Z M 245,11 H 157 A 18.5,18.5 0 0 0 157,48 H 245 A 18.5,18.5 0 0 0 245,11 Z",'<svg viewBox="0 0 436 908">\n  <rect x="1" y="1" width="434" height="906" rx="79" fill="#000000"/>\n  <rect x="2" y="2" width="432" height="904" rx="78" fill="#7e7e7e"/>\n  <rect x="16" y="16" width="404" height="876" rx="64" fill="#7e7e7e"/>\n  <rect x="3" y="3" width="430" height="902" rx="77" fill="#2c2c2c"/>\n  <rect x="16" y="16" width="404" height="876" rx="64" fill="#2c2c2c"/>\n  <rect x="8" y="8" width="420" height="892" rx="72" fill="#000000"/>\n  <rect x="16" y="16" width="404" height="876" rx="64" fill="#000000"/>\n</svg>')
D.cf1=new B.wB('<svg viewBox="0 0 30.75 11.62">\n  <g transform="scale(0.36) translate(-118.17, -47.03)" fill="currentColor">\n    <path d="M129.206 79.3125C126.038 79.3125 123.439 78.446 121.408 76.7131C119.376 74.9801 118.297 72.75 118.169 70.0227H123.325C123.496 71.429 124.128 72.5653 125.222 73.4318C126.315 74.2983 127.658 74.7315 129.249 74.7315C131.053 74.7315 132.509 74.1776 133.616 73.0696C134.739 71.9474 135.3 70.4702 135.3 68.6378C135.3 66.8054 134.739 65.321 133.616 64.1847C132.509 63.0341 131.067 62.4588 129.291 62.4588C128.041 62.4588 126.926 62.7216 125.946 63.2472C124.98 63.7727 124.213 64.5185 123.645 65.4844H118.659L120.257 47.7997H138.773V52.4446H124.518L123.773 61.0739H124.135C125.555 59.1562 127.722 58.1974 130.634 58.1974C133.545 58.1974 135.932 59.1634 137.793 61.0952C139.668 63.027 140.605 65.4986 140.605 68.5099C140.605 71.7202 139.554 74.3267 137.452 76.3295C135.364 78.3182 132.615 79.3125 129.206 79.3125Z"/>\n    <path d="M149.862 75.2855C148.868 75.2855 148.051 74.9659 147.412 74.3267C146.773 73.6875 146.453 72.8849 146.453 71.919C146.453 70.9389 146.773 70.1364 147.412 69.5114C148.051 68.8722 148.868 68.5526 149.862 68.5526C150.871 68.5526 151.688 68.8722 152.313 69.5114C152.952 70.1364 153.271 70.9389 153.271 71.919C153.271 72.8849 152.952 73.6875 152.313 74.3267C151.688 74.9659 150.871 75.2855 149.862 75.2855ZM149.862 59.3054C148.868 59.3054 148.051 58.9929 147.412 58.3679C146.773 57.7287 146.453 56.9261 146.453 55.9602C146.453 54.9801 146.773 54.1776 147.412 53.5526C148.051 52.9134 148.868 52.5937 149.862 52.5937C150.871 52.5937 151.688 52.9134 152.313 53.5526C152.952 54.1776 153.271 54.9801 153.271 55.9602C153.271 56.9261 152.952 57.7287 152.313 58.3679C151.688 58.9929 150.871 59.3054 149.862 59.3054Z"/>\n    <path d="M167.195 78.5455V53.3395H166.833L159.183 58.7088V53.4247L167.216 47.7997H172.692V78.5455H167.195Z"/>\n    <path d="M188 64.9091V60.6477H191.75C193.313 60.6477 194.584 60.2216 195.564 59.3693C196.544 58.5028 197.034 57.3807 197.034 56.0028C197.034 54.6392 196.551 53.5526 195.586 52.7429C194.634 51.919 193.355 51.5071 191.75 51.5071C190.159 51.5071 188.867 51.9261 187.872 52.7642C186.892 53.6023 186.353 54.7457 186.253 56.1946H181.118C181.26 53.3679 182.297 51.1378 184.229 49.5043C186.161 47.8565 188.725 47.0327 191.921 47.0327C194.904 47.0327 197.382 47.8139 199.357 49.3764C201.346 50.9247 202.34 52.8778 202.34 55.2358C202.34 57.0398 201.836 58.581 200.827 59.8594C199.833 61.1378 198.483 61.9545 196.779 62.3097V62.6719C198.881 62.9134 200.536 63.7017 201.743 65.0369C202.965 66.3722 203.576 68.0625 203.576 70.108C203.576 72.75 202.468 74.9446 200.252 76.6918C198.05 78.4389 195.28 79.3125 191.942 79.3125C188.632 79.3125 185.934 78.4673 183.846 76.777C181.772 75.0866 180.664 72.8352 180.522 70.0227H185.784C185.898 71.4432 186.516 72.5795 187.638 73.4318C188.76 74.2699 190.209 74.6889 191.985 74.6889C193.746 74.6889 195.181 74.2344 196.289 73.3253C197.411 72.402 197.972 71.2159 197.972 69.767C197.972 68.2614 197.425 67.0753 196.331 66.2088C195.238 65.3423 193.746 64.9091 191.857 64.9091H188Z"/>\n  </g>\n</svg>',"",'<svg viewBox="0 0 70.53 13.62">\n  <g transform="scale(0.36) translate(-826.18, -43.64)" fill="currentColor">\n    <path d="M826.182 68.8112C826.182 67.2663 827.434 66.014 828.979 66.014H831.776C833.321 66.014 834.573 67.2663 834.573 68.8112V74.4056C834.573 75.9505 833.321 77.2028 831.776 77.2028H828.979C827.434 77.2028 826.182 75.9505 826.182 74.4056V68.8112Z"/>\n    <path d="M840.168 61.8182C840.168 60.2733 841.42 59.021 842.965 59.021H845.762C847.307 59.021 848.559 60.2733 848.559 61.8182V74.4056C848.559 75.9505 847.307 77.2028 845.762 77.2028H842.965C841.42 77.2028 840.168 75.9505 840.168 74.4056V61.8182Z"/>\n    <path d="M854.154 52.028C854.154 50.4831 855.406 49.2308 856.951 49.2308H859.748C861.293 49.2308 862.545 50.4831 862.545 52.028V74.4056C862.545 75.9505 861.293 77.2028 859.748 77.2028H856.951C855.406 77.2028 854.154 75.9505 854.154 74.4056V52.028Z"/>\n    <path d="M868.14 46.4336C868.14 44.8887 869.392 43.6364 870.937 43.6364H873.734C875.279 43.6364 876.531 44.8887 876.531 46.4336V74.4056C876.531 75.9505 875.279 77.2028 873.734 77.2028H870.937C869.392 77.2028 868.14 75.9505 868.14 74.4056V46.4336Z"/>\n    <path d="M913.959 50.8742C920.859 50.8745 927.494 53.5806 932.495 58.4331C932.871 58.8077 933.473 58.803 933.844 58.4225L937.443 54.7146C937.631 54.5216 937.736 54.2601 937.734 53.9882C937.733 53.7162 937.625 53.456 937.435 53.2653C924.311 40.4267 903.606 40.4267 890.482 53.2653C890.291 53.4559 890.184 53.7159 890.182 53.9879C890.18 54.2599 890.285 54.5214 890.472 54.7146L894.073 58.4225C894.443 58.8035 895.046 58.8083 895.422 58.4331C900.423 53.5802 907.059 50.8742 913.959 50.8742ZM914.059 62.0682C917.849 62.068 921.505 63.5062 924.315 66.1035C924.695 66.4721 925.294 66.4641 925.664 66.0855L929.259 62.3775C929.449 62.1831 929.554 61.9192 929.551 61.645C929.548 61.3709 929.438 61.1093 929.245 60.9187C920.688 52.794 907.436 52.794 898.88 60.9187C898.686 61.1093 898.576 61.371 898.573 61.6453C898.571 61.9195 898.676 62.1833 898.866 62.3775L902.46 66.0855C902.831 66.4641 903.429 66.4721 903.809 66.1035C906.618 63.5079 910.27 62.0698 914.059 62.0682ZM921.369 69.3055C921.375 69.5805 921.269 69.8455 921.077 70.0381L914.858 76.4444C914.675 76.6326 914.427 76.7386 914.168 76.7386C913.908 76.7386 913.66 76.6326 913.477 76.4444L907.257 70.0381C907.065 69.8454 906.96 69.5802 906.965 69.3053C906.971 69.0303 907.088 68.77 907.288 68.5857C911.259 65.1568 917.076 65.1568 921.048 68.5857C921.247 68.7701 921.364 69.0306 921.369 69.3055Z" fill-rule="evenodd"/>\n    <path d="M951.27 55.2766C951.27 48.8499 956.48 43.64 962.907 43.64H1003.63C1010.06 43.64 1015.27 48.8499 1015.27 55.2766V69.8224C1015.27 76.2491 1010.06 81.459 1003.63 81.459H962.907C956.48 81.459 951.27 76.2491 951.27 69.8224V55.2766Z M966.132 72.7316L974.868 56.0124V55.7568H964.527V52.2197H979.186V55.7994L970.621 72.7316H966.132Z M990.824 73.2571C989.337 73.2571 988.011 72.9399 986.847 72.3054C985.691 71.6709 984.763 70.7523 984.062 69.5497C982.917 67.7883 982.344 65.4823 982.344 62.6319C982.344 59.2322 983.101 56.5617 984.616 54.6204C986.132 52.679 988.224 51.7084 990.895 51.7084C992.846 51.7084 994.508 52.234 995.881 53.2851C997.263 54.3363 998.102 55.7189 998.395 57.4329H994.148C993.949 56.7606 993.551 56.2255 992.955 55.8278C992.368 55.43 991.671 55.2312 990.867 55.2312C989.465 55.2312 988.362 55.8609 987.557 57.1204C986.761 58.3704 986.387 60.0608 986.435 62.1916H986.69C987.154 61.2256 987.841 60.4822 988.75 59.9614C989.669 59.4311 990.725 59.1659 991.918 59.1659C993.859 59.1659 995.469 59.8099 996.747 61.0978C998.026 62.3857 998.665 64.0098 998.665 65.97C998.665 68.1008 997.931 69.848 996.463 71.2116C994.995 72.5753 993.116 73.2571 990.824 73.2571ZM988.139 68.6832C988.849 69.3839 989.73 69.7343 990.781 69.7343C991.832 69.7343 992.713 69.3887 993.423 68.6974C994.143 67.9966 994.503 67.1301 994.503 66.0979C994.503 65.0562 994.153 64.1944 993.452 63.5126C992.751 62.8213 991.866 62.4756 990.796 62.4756C989.725 62.4756 988.835 62.8166 988.125 63.4984C987.424 64.1802 987.074 65.0325 987.074 66.0553C987.074 67.097 987.429 67.9729 988.139 68.6832Z" fill-rule="evenodd" fill-opacity="0.4"/>\n    <path d="M951.27 55.2766C951.27 48.8499 956.48 43.64 962.907 43.64H997.816V81.459H962.907C956.48 81.459 951.27 76.2491 951.27 69.8224V55.2766Z M966.132 72.7316L974.868 56.0124V55.7568H964.527V52.2197H979.186V55.7994L970.621 72.7316H966.132Z M990.824 73.2571C989.337 73.2571 988.011 72.9399 986.847 72.3054C985.691 71.6709 984.763 70.7523 984.062 69.5497C982.917 67.7883 982.344 65.4823 982.344 62.6319C982.344 59.2322 983.101 56.5617 984.616 54.6204C986.132 52.679 988.224 51.7084 990.895 51.7084C992.846 51.7084 994.508 52.234 995.881 53.2851C997.263 54.3363 998.102 55.7189 998.395 57.4329H994.148C993.949 56.7606 993.551 56.2255 992.955 55.8278C992.368 55.43 991.671 55.2312 990.867 55.2312C989.465 55.2312 988.362 55.8609 987.557 57.1204C986.761 58.3704 986.387 60.0608 986.435 62.1916H986.69C987.154 61.2256 987.841 60.4822 988.75 59.9614C989.669 59.4311 990.725 59.1659 991.918 59.1659C993.859 59.1659 995.469 59.8099 996.747 61.0978C998.026 62.3857 998.665 64.0098 998.665 65.97C998.665 68.1008 997.931 69.848 996.463 71.2116C994.995 72.5753 993.116 73.2571 990.824 73.2571ZM988.139 68.6832C988.849 69.3839 989.73 69.7343 990.781 69.7343C991.832 69.7343 992.713 69.3887 993.423 68.6974C994.143 67.9966 994.503 67.1301 994.503 66.0979C994.503 65.0562 994.153 64.1944 993.452 63.5126C992.751 62.8213 991.866 62.4756 990.796 62.4756C989.725 62.4756 988.835 62.8166 988.125 63.4984C987.424 64.1802 987.074 65.0325 987.074 66.0553C987.074 67.097 987.429 67.9729 988.139 68.6832Z" fill-rule="evenodd"/>\n    <path d="M1018.18 57.6263V69.4317C1020.56 68.4318 1022.1 66.1059 1022.1 63.529C1022.1 60.9521 1020.56 58.6261 1018.18 57.6263Z" fill-opacity="0.4"/>\n  </g>\n</svg>',30,null)
D.cf4=new B.wB("",'<svg viewBox="0 0 145 5">\n  <path d="M 2.5,0 H 142.5 A 2.5,2.5 0 0 1 145,2.5 V 2.5 A 2.5,2.5 0 0 1 142.5,5 H 2.5 A 2.5,2.5 0 0 1 0,2.5 V 2.5 A 2.5,2.5 0 0 1 2.5,0 Z" fill="currentColor"/>\n</svg>',"",16,8)
D.cf8=new B.Li(D.cf1,D.cf4,C.aK)
D.cce=new A.a8(402,874)
D.bt3=new A.O(0,62,0,34)
D.btu=new A.O(62,0,62,20)
D.CO=new B.QM(0,"phone")
D.aoh=new B.y6("apple-iphone-16-pro","iPhone 16 Pro","Apple",2024,C.aK,D.aob,D.cf8,D.cce,3,D.bt3,D.btu,335,208,D.CO)
D.aoo=new B.y7(C.u1,D.aoh,!0)
D.ccd=new A.a8(384,796)
D.c5q=new A.y(12,8)
D.aoa=new B.y5(D.ccd,D.c5q,"M 20,0 H 340 A 20,20 0 0 1 360,20 V 760 A 20,20 0 0 1 340,780 H 20 A 20,20 0 0 1 0,760 V 20 A 20,20 0 0 1 20,0 Z",'<svg viewBox="0 0 384 796">\n  <defs><clipPath id="shell">\n    <path d="M 32,0 H 352 A 28,28 0 0 1 380,28 V 768 A 28,28 0 0 1 352,796 H 32 A 28,28 0 0 1 4,768 V 28 A 28,28 0 0 1 32,0 Z"/>\n  </clipPath></defs>\n  <g fill="#3d4149">\n    <rect x="0" y="159.2" width="6" height="43.78" rx="2"/>\n    <rect x="0" y="214.92" width="6" height="43.78" rx="2"/>\n    <rect x="378" y="191.04" width="6" height="63.68" rx="2"/>\n  </g>\n  <path d="M 32,0 H 352 A 28,28 0 0 1 380,28 V 768 A 28,28 0 0 1 352,796 H 32 A 28,28 0 0 1 4,768 V 28 A 28,28 0 0 1 32,0 Z" fill="#1f2126"/>\n  <path d="M 32,2 H 352 A 26,26 0 0 1 378,28 V 768 A 26,26 0 0 1 352,794 H 32 A 26,26 0 0 1 6,768 V 28 A 26,26 0 0 1 32,2 Z" fill="#3d4149"/>\n  <g clip-path="url(#shell)">\n    <path d="M -796,0 L -477.6,0 L 96,796 L -222.4,796 Z" fill="#ffffff" fill-opacity="0.18"/>\n  </g>\n  <path d="M 32,3.5 H 352 A 24.5,24.5 0 0 1 376.5,28 V 768 A 24.5,24.5 0 0 1 352,792.5 H 32 A 24.5,24.5 0 0 1 7.5,768 V 28 A 24.5,24.5 0 0 1 32,3.5 Z" fill="#08090b"/>\n</svg>')
D.cf2=new B.wB('<svg viewBox="0 0 26.48 10.01">\n  <g transform="scale(0.31) translate(-118.17, -47.03)" fill="currentColor">\n    <path d="M129.206 79.3125C126.038 79.3125 123.439 78.446 121.408 76.7131C119.376 74.9801 118.297 72.75 118.169 70.0227H123.325C123.496 71.429 124.128 72.5653 125.222 73.4318C126.315 74.2983 127.658 74.7315 129.249 74.7315C131.053 74.7315 132.509 74.1776 133.616 73.0696C134.739 71.9474 135.3 70.4702 135.3 68.6378C135.3 66.8054 134.739 65.321 133.616 64.1847C132.509 63.0341 131.067 62.4588 129.291 62.4588C128.041 62.4588 126.926 62.7216 125.946 63.2472C124.98 63.7727 124.213 64.5185 123.645 65.4844H118.659L120.257 47.7997H138.773V52.4446H124.518L123.773 61.0739H124.135C125.555 59.1562 127.722 58.1974 130.634 58.1974C133.545 58.1974 135.932 59.1634 137.793 61.0952C139.668 63.027 140.605 65.4986 140.605 68.5099C140.605 71.7202 139.554 74.3267 137.452 76.3295C135.364 78.3182 132.615 79.3125 129.206 79.3125Z"/>\n    <path d="M149.862 75.2855C148.868 75.2855 148.051 74.9659 147.412 74.3267C146.773 73.6875 146.453 72.8849 146.453 71.919C146.453 70.9389 146.773 70.1364 147.412 69.5114C148.051 68.8722 148.868 68.5526 149.862 68.5526C150.871 68.5526 151.688 68.8722 152.313 69.5114C152.952 70.1364 153.271 70.9389 153.271 71.919C153.271 72.8849 152.952 73.6875 152.313 74.3267C151.688 74.9659 150.871 75.2855 149.862 75.2855ZM149.862 59.3054C148.868 59.3054 148.051 58.9929 147.412 58.3679C146.773 57.7287 146.453 56.9261 146.453 55.9602C146.453 54.9801 146.773 54.1776 147.412 53.5526C148.051 52.9134 148.868 52.5937 149.862 52.5937C150.871 52.5937 151.688 52.9134 152.313 53.5526C152.952 54.1776 153.271 54.9801 153.271 55.9602C153.271 56.9261 152.952 57.7287 152.313 58.3679C151.688 58.9929 150.871 59.3054 149.862 59.3054Z"/>\n    <path d="M167.195 78.5455V53.3395H166.833L159.183 58.7088V53.4247L167.216 47.7997H172.692V78.5455H167.195Z"/>\n    <path d="M188 64.9091V60.6477H191.75C193.313 60.6477 194.584 60.2216 195.564 59.3693C196.544 58.5028 197.034 57.3807 197.034 56.0028C197.034 54.6392 196.551 53.5526 195.586 52.7429C194.634 51.919 193.355 51.5071 191.75 51.5071C190.159 51.5071 188.867 51.9261 187.872 52.7642C186.892 53.6023 186.353 54.7457 186.253 56.1946H181.118C181.26 53.3679 182.297 51.1378 184.229 49.5043C186.161 47.8565 188.725 47.0327 191.921 47.0327C194.904 47.0327 197.382 47.8139 199.357 49.3764C201.346 50.9247 202.34 52.8778 202.34 55.2358C202.34 57.0398 201.836 58.581 200.827 59.8594C199.833 61.1378 198.483 61.9545 196.779 62.3097V62.6719C198.881 62.9134 200.536 63.7017 201.743 65.0369C202.965 66.3722 203.576 68.0625 203.576 70.108C203.576 72.75 202.468 74.9446 200.252 76.6918C198.05 78.4389 195.28 79.3125 191.942 79.3125C188.632 79.3125 185.934 78.4673 183.846 76.777C181.772 75.0866 180.664 72.8352 180.522 70.0227H185.784C185.898 71.4432 186.516 72.5795 187.638 73.4318C188.76 74.2699 190.209 74.6889 191.985 74.6889C193.746 74.6889 195.181 74.2344 196.289 73.3253C197.411 72.402 197.972 71.2159 197.972 69.767C197.972 68.2614 197.425 67.0753 196.331 66.2088C195.238 65.3423 193.746 64.9091 191.857 64.9091H188Z"/>\n  </g>\n</svg>',"",'<svg viewBox="0 0 63.16 11">\n  <g transform="translate(0, 0)">\n    <path d="M 7.79,10.63 L 0.55,3.85 A 10.54,10.54 0 0 1 15.03,3.85 Z" fill="currentColor"/>\n  </g>\n  <g transform="translate(20.58, 0)">\n    <path d="M 12.83,0 L 12.83,11 L 0,11 Z" fill="currentColor"/>\n  </g>\n  <g transform="translate(38.41, 0)">\n    <path d="M 3.12,0 H 18.88 A 3.12,3.12 0 0 1 22,3.12 V 7.88 A 3.12,3.12 0 0 1 18.88,11 H 3.12 A 3.12,3.12 0 0 1 0,7.88 V 3.12 A 3.12,3.12 0 0 1 3.12,0 Z M 3.3,1.28 H 18.7 A 2.02,2.02 0 0 1 20.72,3.3 V 7.7 A 2.02,2.02 0 0 1 18.7,9.72 H 3.3 A 2.02,2.02 0 0 1 1.28,7.7 V 3.3 A 2.02,2.02 0 0 1 3.3,1.28 Z" fill-rule="evenodd" fill="currentColor" fill-opacity="0.45"/>\n    <path d="M 3.12,1.83 H 13.75 A 1.28,1.28 0 0 1 15.03,3.12 V 7.88 A 1.28,1.28 0 0 1 13.75,9.17 H 3.12 A 1.28,1.28 0 0 1 1.83,7.88 V 3.12 A 1.28,1.28 0 0 1 3.12,1.83 Z" fill="currentColor"/>\n    <path d="M 22.55,3.67 L 22.55,7.33 A 1.47,1.47 0 0 0 22.55,3.67 Z" fill="currentColor" fill-opacity="0.45"/>\n  </g>\n</svg>',16,null)
D.cf5=new B.wB("",'<svg viewBox="0 0 96 4">\n  <path d="M 2,0 H 94 A 2,2 0 0 1 96,2 V 2 A 2,2 0 0 1 94,4 H 2 A 2,2 0 0 1 0,2 V 2 A 2,2 0 0 1 2,0 Z" fill="currentColor"/>\n</svg>',"",16,9)
D.cf6=new B.Li(D.cf2,D.cf5,C.ca)
D.ccc=new A.a8(360,780)
D.aog=new B.y6("samsung-galaxy-s25","Galaxy S25","Samsung",2025,C.ca,D.aoa,D.cf6,D.ccc,3,C.md,C.md,336,252,D.CO)
D.aol=new B.y7(C.CJ,D.aog,!0)
D.cci=new A.a8(938,1298)
D.c5w=new A.y(59,59)
D.ao8=new B.y5(D.cci,D.c5w,"M 25.55,0 C 281.85,0 538.15,0 794.45,0 C 796.52,0 798.71,-0.01 800.29,0.04 C 802.03,0.09 803.72,0.21 805.4,0.53 C 808.83,1.19 812.01,2.69 814.66,5.34 C 817.31,7.99 818.81,11.17 819.46,14.6 C 819.79,16.28 819.91,17.97 819.96,19.71 C 820.01,21.29 820,23.48 820,25.55 L 820,1154.45 C 820,1156.52 820.01,1158.71 819.96,1160.29 C 819.91,1162.03 819.79,1163.72 819.46,1165.4 C 818.81,1168.83 817.31,1172.01 814.66,1174.66 C 812.01,1177.31 808.83,1178.81 805.4,1179.47 C 803.72,1179.79 802.03,1179.91 800.29,1179.96 C 798.71,1180.01 796.52,1180 794.45,1180 L 25.55,1180 C 23.47,1180 21.29,1180.01 19.71,1179.96 C 17.97,1179.91 16.28,1179.79 14.6,1179.47 C 11.17,1178.81 7.99,1177.31 5.34,1174.66 C 2.69,1172.01 1.19,1168.83 0.53,1165.4 C 0.21,1163.72 0.09,1162.03 0.04,1160.29 C -0.01,1158.71 0,1156.52 0,1154.45 L 0,25.55 C 0,23.48 -0.01,21.29 0.04,19.71 C 0.09,17.97 0.21,16.28 0.53,14.6 C 1.19,11.17 2.69,7.99 5.34,5.34 C 7.99,2.69 11.17,1.19 14.6,0.53 C 16.28,0.21 17.97,0.09 19.71,0.04 C 21.29,-0.01 23.48,0 25.55,0 Z",'<svg viewBox="0 0 938 1298">\n  <rect x="0" y="0" width="938" height="1298" rx="81" fill="#7e7e7e"/>\n  <rect x="1" y="1" width="936" height="1296" rx="80" fill="#2c2c2c"/>\n  <rect x="6" y="6" width="926" height="1286" rx="75" fill="#010101"/>\n</svg>')
D.cf3=new B.wB('<svg viewBox="0 0 29.04 10.98">\n  <g transform="scale(0.34) translate(-118.17, -47.03)" fill="currentColor">\n    <path d="M129.206 79.3125C126.038 79.3125 123.439 78.446 121.408 76.7131C119.376 74.9801 118.297 72.75 118.169 70.0227H123.325C123.496 71.429 124.128 72.5653 125.222 73.4318C126.315 74.2983 127.658 74.7315 129.249 74.7315C131.053 74.7315 132.509 74.1776 133.616 73.0696C134.739 71.9474 135.3 70.4702 135.3 68.6378C135.3 66.8054 134.739 65.321 133.616 64.1847C132.509 63.0341 131.067 62.4588 129.291 62.4588C128.041 62.4588 126.926 62.7216 125.946 63.2472C124.98 63.7727 124.213 64.5185 123.645 65.4844H118.659L120.257 47.7997H138.773V52.4446H124.518L123.773 61.0739H124.135C125.555 59.1562 127.722 58.1974 130.634 58.1974C133.545 58.1974 135.932 59.1634 137.793 61.0952C139.668 63.027 140.605 65.4986 140.605 68.5099C140.605 71.7202 139.554 74.3267 137.452 76.3295C135.364 78.3182 132.615 79.3125 129.206 79.3125Z"/>\n    <path d="M149.862 75.2855C148.868 75.2855 148.051 74.9659 147.412 74.3267C146.773 73.6875 146.453 72.8849 146.453 71.919C146.453 70.9389 146.773 70.1364 147.412 69.5114C148.051 68.8722 148.868 68.5526 149.862 68.5526C150.871 68.5526 151.688 68.8722 152.313 69.5114C152.952 70.1364 153.271 70.9389 153.271 71.919C153.271 72.8849 152.952 73.6875 152.313 74.3267C151.688 74.9659 150.871 75.2855 149.862 75.2855ZM149.862 59.3054C148.868 59.3054 148.051 58.9929 147.412 58.3679C146.773 57.7287 146.453 56.9261 146.453 55.9602C146.453 54.9801 146.773 54.1776 147.412 53.5526C148.051 52.9134 148.868 52.5937 149.862 52.5937C150.871 52.5937 151.688 52.9134 152.313 53.5526C152.952 54.1776 153.271 54.9801 153.271 55.9602C153.271 56.9261 152.952 57.7287 152.313 58.3679C151.688 58.9929 150.871 59.3054 149.862 59.3054Z"/>\n    <path d="M167.195 78.5455V53.3395H166.833L159.183 58.7088V53.4247L167.216 47.7997H172.692V78.5455H167.195Z"/>\n    <path d="M188 64.9091V60.6477H191.75C193.313 60.6477 194.584 60.2216 195.564 59.3693C196.544 58.5028 197.034 57.3807 197.034 56.0028C197.034 54.6392 196.551 53.5526 195.586 52.7429C194.634 51.919 193.355 51.5071 191.75 51.5071C190.159 51.5071 188.867 51.9261 187.872 52.7642C186.892 53.6023 186.353 54.7457 186.253 56.1946H181.118C181.26 53.3679 182.297 51.1378 184.229 49.5043C186.161 47.8565 188.725 47.0327 191.921 47.0327C194.904 47.0327 197.382 47.8139 199.357 49.3764C201.346 50.9247 202.34 52.8778 202.34 55.2358C202.34 57.0398 201.836 58.581 200.827 59.8594C199.833 61.1378 198.483 61.9545 196.779 62.3097V62.6719C198.881 62.9134 200.536 63.7017 201.743 65.0369C202.965 66.3722 203.576 68.0625 203.576 70.108C203.576 72.75 202.468 74.9446 200.252 76.6918C198.05 78.4389 195.28 79.3125 191.942 79.3125C188.632 79.3125 185.934 78.4673 183.846 76.777C181.772 75.0866 180.664 72.8352 180.522 70.0227H185.784C185.898 71.4432 186.516 72.5795 187.638 73.4318C188.76 74.2699 190.209 74.6889 191.985 74.6889C193.746 74.6889 195.181 74.2344 196.289 73.3253C197.411 72.402 197.972 71.2159 197.972 69.767C197.972 68.2614 197.425 67.0753 196.331 66.2088C195.238 65.3423 193.746 64.9091 191.857 64.9091H188Z"/>\n  </g>\n</svg>',"",'<svg viewBox="0 0 66.61 12.86">\n  <g transform="scale(0.34) translate(-826.18, -43.64)" fill="currentColor">\n    <path d="M826.182 68.8112C826.182 67.2663 827.434 66.014 828.979 66.014H831.776C833.321 66.014 834.573 67.2663 834.573 68.8112V74.4056C834.573 75.9505 833.321 77.2028 831.776 77.2028H828.979C827.434 77.2028 826.182 75.9505 826.182 74.4056V68.8112Z"/>\n    <path d="M840.168 61.8182C840.168 60.2733 841.42 59.021 842.965 59.021H845.762C847.307 59.021 848.559 60.2733 848.559 61.8182V74.4056C848.559 75.9505 847.307 77.2028 845.762 77.2028H842.965C841.42 77.2028 840.168 75.9505 840.168 74.4056V61.8182Z"/>\n    <path d="M854.154 52.028C854.154 50.4831 855.406 49.2308 856.951 49.2308H859.748C861.293 49.2308 862.545 50.4831 862.545 52.028V74.4056C862.545 75.9505 861.293 77.2028 859.748 77.2028H856.951C855.406 77.2028 854.154 75.9505 854.154 74.4056V52.028Z"/>\n    <path d="M868.14 46.4336C868.14 44.8887 869.392 43.6364 870.937 43.6364H873.734C875.279 43.6364 876.531 44.8887 876.531 46.4336V74.4056C876.531 75.9505 875.279 77.2028 873.734 77.2028H870.937C869.392 77.2028 868.14 75.9505 868.14 74.4056V46.4336Z"/>\n    <path d="M913.959 50.8742C920.859 50.8745 927.494 53.5806 932.495 58.4331C932.871 58.8077 933.473 58.803 933.844 58.4225L937.443 54.7146C937.631 54.5216 937.736 54.2601 937.734 53.9882C937.733 53.7162 937.625 53.456 937.435 53.2653C924.311 40.4267 903.606 40.4267 890.482 53.2653C890.291 53.4559 890.184 53.7159 890.182 53.9879C890.18 54.2599 890.285 54.5214 890.472 54.7146L894.073 58.4225C894.443 58.8035 895.046 58.8083 895.422 58.4331C900.423 53.5802 907.059 50.8742 913.959 50.8742ZM914.059 62.0682C917.849 62.068 921.505 63.5062 924.315 66.1035C924.695 66.4721 925.294 66.4641 925.664 66.0855L929.259 62.3775C929.449 62.1831 929.554 61.9192 929.551 61.645C929.548 61.3709 929.438 61.1093 929.245 60.9187C920.688 52.794 907.436 52.794 898.88 60.9187C898.686 61.1093 898.576 61.371 898.573 61.6453C898.571 61.9195 898.676 62.1833 898.866 62.3775L902.46 66.0855C902.831 66.4641 903.429 66.4721 903.809 66.1035C906.618 63.5079 910.27 62.0698 914.059 62.0682ZM921.369 69.3055C921.375 69.5805 921.269 69.8455 921.077 70.0381L914.858 76.4444C914.675 76.6326 914.427 76.7386 914.168 76.7386C913.908 76.7386 913.66 76.6326 913.477 76.4444L907.257 70.0381C907.065 69.8454 906.96 69.5802 906.965 69.3053C906.971 69.0303 907.088 68.77 907.288 68.5857C911.259 65.1568 917.076 65.1568 921.048 68.5857C921.247 68.7701 921.364 69.0306 921.369 69.3055Z" fill-rule="evenodd"/>\n    <path d="M951.27 55.2766C951.27 48.8499 956.48 43.64 962.907 43.64H1003.63C1010.06 43.64 1015.27 48.8499 1015.27 55.2766V69.8224C1015.27 76.2491 1010.06 81.459 1003.63 81.459H962.907C956.48 81.459 951.27 76.2491 951.27 69.8224V55.2766Z M966.132 72.7316L974.868 56.0124V55.7568H964.527V52.2197H979.186V55.7994L970.621 72.7316H966.132Z M990.824 73.2571C989.337 73.2571 988.011 72.9399 986.847 72.3054C985.691 71.6709 984.763 70.7523 984.062 69.5497C982.917 67.7883 982.344 65.4823 982.344 62.6319C982.344 59.2322 983.101 56.5617 984.616 54.6204C986.132 52.679 988.224 51.7084 990.895 51.7084C992.846 51.7084 994.508 52.234 995.881 53.2851C997.263 54.3363 998.102 55.7189 998.395 57.4329H994.148C993.949 56.7606 993.551 56.2255 992.955 55.8278C992.368 55.43 991.671 55.2312 990.867 55.2312C989.465 55.2312 988.362 55.8609 987.557 57.1204C986.761 58.3704 986.387 60.0608 986.435 62.1916H986.69C987.154 61.2256 987.841 60.4822 988.75 59.9614C989.669 59.4311 990.725 59.1659 991.918 59.1659C993.859 59.1659 995.469 59.8099 996.747 61.0978C998.026 62.3857 998.665 64.0098 998.665 65.97C998.665 68.1008 997.931 69.848 996.463 71.2116C994.995 72.5753 993.116 73.2571 990.824 73.2571ZM988.139 68.6832C988.849 69.3839 989.73 69.7343 990.781 69.7343C991.832 69.7343 992.713 69.3887 993.423 68.6974C994.143 67.9966 994.503 67.1301 994.503 66.0979C994.503 65.0562 994.153 64.1944 993.452 63.5126C992.751 62.8213 991.866 62.4756 990.796 62.4756C989.725 62.4756 988.835 62.8166 988.125 63.4984C987.424 64.1802 987.074 65.0325 987.074 66.0553C987.074 67.097 987.429 67.9729 988.139 68.6832Z" fill-rule="evenodd" fill-opacity="0.4"/>\n    <path d="M951.27 55.2766C951.27 48.8499 956.48 43.64 962.907 43.64H997.816V81.459H962.907C956.48 81.459 951.27 76.2491 951.27 69.8224V55.2766Z M966.132 72.7316L974.868 56.0124V55.7568H964.527V52.2197H979.186V55.7994L970.621 72.7316H966.132Z M990.824 73.2571C989.337 73.2571 988.011 72.9399 986.847 72.3054C985.691 71.6709 984.763 70.7523 984.062 69.5497C982.917 67.7883 982.344 65.4823 982.344 62.6319C982.344 59.2322 983.101 56.5617 984.616 54.6204C986.132 52.679 988.224 51.7084 990.895 51.7084C992.846 51.7084 994.508 52.234 995.881 53.2851C997.263 54.3363 998.102 55.7189 998.395 57.4329H994.148C993.949 56.7606 993.551 56.2255 992.955 55.8278C992.368 55.43 991.671 55.2312 990.867 55.2312C989.465 55.2312 988.362 55.8609 987.557 57.1204C986.761 58.3704 986.387 60.0608 986.435 62.1916H986.69C987.154 61.2256 987.841 60.4822 988.75 59.9614C989.669 59.4311 990.725 59.1659 991.918 59.1659C993.859 59.1659 995.469 59.8099 996.747 61.0978C998.026 62.3857 998.665 64.0098 998.665 65.97C998.665 68.1008 997.931 69.848 996.463 71.2116C994.995 72.5753 993.116 73.2571 990.824 73.2571ZM988.139 68.6832C988.849 69.3839 989.73 69.7343 990.781 69.7343C991.832 69.7343 992.713 69.3887 993.423 68.6974C994.143 67.9966 994.503 67.1301 994.503 66.0979C994.503 65.0562 994.153 64.1944 993.452 63.5126C992.751 62.8213 991.866 62.4756 990.796 62.4756C989.725 62.4756 988.835 62.8166 988.125 63.4984C987.424 64.1802 987.074 65.0325 987.074 66.0553C987.074 67.097 987.429 67.9729 988.139 68.6832Z" fill-rule="evenodd"/>\n    <path d="M1018.18 57.6263V69.4317C1020.56 68.4318 1022.1 66.1059 1022.1 63.529C1022.1 60.9521 1020.56 58.6261 1018.18 57.6263Z" fill-opacity="0.4"/>\n  </g>\n</svg>',42,null)
D.cf0=new B.wB("",'<svg viewBox="0 0 320 5">\n  <path d="M 2.5,0 H 317.5 A 2.5,2.5 0 0 1 320,2.5 V 2.5 A 2.5,2.5 0 0 1 317.5,5 H 2.5 A 2.5,2.5 0 0 1 0,2.5 V 2.5 A 2.5,2.5 0 0 1 2.5,0 Z" fill="currentColor"/>\n</svg>',"",16,8)
D.cf7=new B.Li(D.cf3,D.cf0,C.aK)
D.cch=new A.a8(820,1180)
D.Hp=new A.O(0,32,0,25)
D.aof=new B.QM(1,"tablet")
D.aok=new B.y6("apple-ipad-air-11-m4",'iPad Air 11" (M4)',"Apple",2026,C.aK,D.ao8,D.cf7,D.cch,2,D.Hp,D.Hp,337,422,D.aof)
D.aop=new B.y7(C.CL,D.aok,!0)
D.ccb=new A.a8(1922,1109)
D.c5s=new A.y(1,28)
D.aoc=new B.y5(D.ccb,D.c5s,"M 0,0 H 1920 V 1068 A 12,12 0 0 1 1908,1080 H 12 A 12,12 0 0 1 0,1068 Z",'<svg viewBox="0 0 1922 1109">\n  <path d="M 12,0 H 1910 A 12,12 0 0 1 1922,12 V 1097 A 12,12 0 0 1 1910,1109 H 12 A 12,12 0 0 1 0,1097 V 12 A 12,12 0 0 1 12,0 Z" fill="#26282c"/>\n  <circle cx="16" cy="14" r="6" fill="#ff5f57"/>\n  <circle cx="36" cy="14" r="6" fill="#febc2e"/>\n  <circle cx="56" cy="14" r="6" fill="#28c840"/>\n  <rect x="891" y="9" width="140" height="10" rx="5" fill="#c9ccd1" fill-opacity="0.35"/>\n</svg>')
D.cca=new A.a8(1920,1080)
D.CP=new B.QM(3,"desktop")
D.aoj=new B.y6("desktop-large","Large Desktop Window","Generic",null,C.hX,D.aoc,null,D.cca,2,C.V,null,null,null,D.CP)
D.aon=new B.y7(C.CK,D.aoj,!1)
D.cc8=new A.a8(1026,673)
D.c5t=new A.y(1,32)
D.ao9=new B.y5(D.cc8,D.c5t,"M 0,0 H 1024 V 632 A 8,8 0 0 1 1016,640 H 8 A 8,8 0 0 1 0,632 Z",'<svg viewBox="0 0 1026 673">\n  <path d="M 8,0 H 1018 A 8,8 0 0 1 1026,8 V 665 A 8,8 0 0 1 1018,673 H 8 A 8,8 0 0 1 0,665 V 8 A 8,8 0 0 1 8,0 Z" fill="#202226"/>\n  <rect x="980" y="15" width="10" height="2" fill="#c9ccd1"/>\n  <rect x="994" y="15" width="10" height="2" fill="#c9ccd1"/>\n  <rect x="1008" y="15" width="10" height="2" fill="#c9ccd1"/>\n  <rect x="443" y="11" width="140" height="10" rx="5" fill="#c9ccd1" fill-opacity="0.35"/>\n</svg>')
D.cc7=new A.a8(1024,640)
D.aoi=new B.y6("desktop-small","Small Desktop Window","Generic",null,C.yK,D.ao9,null,D.cc7,1,C.V,null,null,null,D.CP)
D.aom=new B.y7(C.CM,D.aoi,!1)
D.mA=x([D.aoo,D.aol,D.aop,D.aon,D.aom],A.j("i<y7>"))
D.c4N={black:0,white:1,gray:2,grey:3,silver:4,red:5,green:6,blue:7,yellow:8,orange:9,navy:10}
D.B7=new A.ae(1,0.5019607843137255,0.5019607843137255,0.5019607843137255,C.L)
D.a3Z=new A.ae(1,0.7529411764705882,0.7529411764705882,0.7529411764705882,C.L)
D.a3L=new A.ae(1,0,0.5019607843137255,0,C.L)
D.a4h=new A.ae(1,1,0.6470588235294118,0,C.L)
D.a4L=new A.ae(1,0,0,0.5019607843137255,C.L)
D.c01=new A.a1(D.c4N,[C.c_,C.aA,D.B7,D.B7,D.a3Z,E.tg,D.a3L,E.B5,E.B9,D.a4h,D.a4L],A.j("a1<p,ae>"))
D.c43=new A.Ja(C.ag,1,C.rX,C.ct,C.V,C.V,C.V,C.V,!1,!1,!1,!1,!1,!1,!1,!1,C.mT,C.CN,C.wA,!1,null,null,null,null,null)
D.c5g={g:0,a:1,svg:2,switch:3}
D.caI=new A.eK(D.c5g,4,y.M)
D.c4C={defs:0,clipPath:1,mask:2,title:3,desc:4,metadata:5,style:6,symbol:7,linearGradient:8,radialGradient:9,filter:10}
D.caV=new A.eK(D.c4C,11,y.M)
D.clu=new A.ak("frame-bar-brightness",y.O)
D.clA=new A.ak("frame-bar-rotate",y.O)})();(function lazyInitializers(){var x=a.lazyFinal
x($,"cYR","chO",()=>A.ab("[-+]?(\\d*\\.\\d+|\\d+\\.?)([eE][-+]?\\d+)?",!0,!1,!1,!1))
x($,"cZz","cic",()=>A.ab("url\\(\\s*#([^)\\s]+)\\s*\\)",!0,!1,!1,!1))
x($,"cZ_","chQ",()=>A.ab("rgba?\\(([^)]*)\\)",!0,!1,!1,!1))
x($,"cZx","cia",()=>A.ab("(\\w+)\\s*\\(([^)]*)\\)",!0,!1,!1,!1))
x($,"cXQ","chb",()=>A.ab("&([a-zA-Z]+|#[xX]?[0-9a-fA-F]+);",!0,!1,!1,!1))})()};
(a=>{a["iLZLnGQCzNPtQO2itra8oTQn/HA="]=a.current})($__dart_deferred_initializers__);