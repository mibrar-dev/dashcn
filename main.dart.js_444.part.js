((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,A,C,B={vo:function vo(d,e,f,g,h,i,j,k,l,m,n,o,p,q){var _=this
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
_.CW=q},vn:function vn(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},LN:function LN(d,e){this.a=d
this.b=e},
bDD(d,e,f,g,h,i,j,k,l,m,n){return new B.LO(j,h,k,g,m,d,e,i,n,l,f)},
LO:function LO(d,e,f,g,h,i,j,k,l,m,n){var _=this
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
ay6:function ay6(){},
H_:function H_(d,e,f){this.a=d
this.b=e
this.c=f},
tX:function tX(d,e,f,g,h){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h},
aRD:function aRD(d,e,f,g,h){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h},
bGJ(d){var x,w,v,u=new B.bnX(d).aJm(),t=u.a
if(t!=="svg")throw A.w(A.cr("Expected a root <svg> element, got <"+t+">",null,null))
x=B.bTF(u)
w=A.H(y.N,y.P)
B.bGK(u,w)
v=A.a([],y.j)
new B.b4S(w,v).a6Z(u,new B.aiS(A.eN(),C.cl,!0,1,D.bED))
return new B.x5(x,v)},
bTF(d){var x,w,v,u,t,s=d.BJ("viewBox")
if(s!=null){x=B.bpT(s)
if(x.length!==4)throw A.w(A.cr("Expected four numbers in viewBox, got: "+s,null,null))
w=x[0]
v=x[1]
return new A.O(w,v,w+x[2],v+x[3])}u=B.bJy(d.BJ("width"))
t=B.bJy(d.BJ("height"))
if(u==null||t==null)throw A.w(D.bjG)
return new A.O(0,0,0+u,0+t)},
bGK(d,e){var x,w,v,u,t,s
for(x=d.c,w=x.length,v=0;v<x.length;x.length===w||(0,A.F)(x),++v){u=x[v]
if(u.a==="clipPath"){t=u.b.k(0,"id")
s=t==null||t.length===0?null:t
if(s!=null)e.n(0,s,u.c)}B.bGK(u,e)}},
bHJ(d){var x,w,v,u,t,s,r=d.BJ("style")
if(r==null)return d.b
x=y.N
w=A.hf(d.b,x,x)
for(x=r.split(";"),v=x.length,u=0;u<v;++u){t=x[u]
s=C.d.dt(t,":")
if(s<=0)continue
w.n(0,C.d.au(C.d.S(t,0,s)),C.d.au(C.d.aL(t,s+1)))}return w},
hK(d,e){var x=d.k(0,e)
return x==null||x.length===0?null:C.d.au(x)},
bpT(d){var x,w,v,u,t,s=A.a([],y.n)
for(x=$.bNk().mv(0,d),x=new A.ud(x.a,x.b,x.c),w=y.F;x.u();){v=x.d
u=(v==null?w.a(v):v).b[0]
u.toString
t=A.ew(u)
if(t!=null)s.push(t)}return s},
bJy(d){if(d==null)return null
return A.ew(C.d.au(C.d.dG(d,"px")?C.d.S(d,0,d.length-2):d))},
c10(d){var x,w,v,u,t,s,r,q=C.d.au(d)
if(q.length===0||q==="none"||q==="transparent")return null
if(C.d.ac(q,"#")){x=C.d.aL(q,1)
w=x.length
switch(w){case 3:case 4:for(v=0,u="";v<w;++v,u=t){t=x[v]
t=u+t+t}return B.bJu(u.charCodeAt(0)==0?u:u)
case 6:case 8:return B.bJu(x)
default:return null}}s=$.bNl().fG(q)
if(s!=null){w=s.b[1]
w.toString
r=B.bpT(w)
w=r.length
if(w<3)return null
return A.fl(C.f.am(C.f.I(w>3?r[3]:1,0,1)*255),C.l.I(C.f.am(r[0]),0,255),C.l.I(C.f.am(r[1]),0,255),C.l.I(C.f.am(r[2]),0,255))}return D.bOi.k(0,q.toLowerCase())},
bJu(d){var x=A.eQ(d,16)
if(x==null)return null
if(d.length===6)return A.ci((x|4278190080)>>>0)
return A.ci(((x&255)<<24|C.l.f5(x,8))>>>0)},
bJB(d){var x,w,v,u,t,s,r,q,p,o,n,m,l,k=A.eN()
for(x=$.bNF().mv(0,d),x=new A.ud(x.a,x.b,x.c),w=y.F;x.u();){v=x.d
u=(v==null?w.a(v):v).b
t=u[1]
t.toString
u=u[2]
u.toString
s=B.bpT(u)
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
k.ei(new A.cg(n))}break
case"translate":u=s.length
if(u!==0){t=s[0]
k.eu(t,u>1?s[1]:0,0,1)}break
case"scale":u=s.length
if(u!==0){t=s[0]
k.ne(t,u>1?s[1]:t,1,1)}break
case"rotate":u=s.length
if(u!==0){m=s[0]*3.141592653589793/180
if(u>=3){k.eu(s[1],s[2],0,1)
k.xS(m)
k.eu(-s[1],-s[2],0,1)}else k.xS(m)}break
case"skewX":if(s.length!==0){u=s[0]
l=A.eN()
t=l.a
u=Math.tan(u*3.141592653589793/180)
t.$flags&2&&A.bk(t)
t[4]=u
k.ei(l)}break
case"skewY":if(s.length!==0){u=s[0]
l=A.eN()
t=l.a
u=Math.tan(u*3.141592653589793/180)
t.$flags&2&&A.bk(t)
t[1]=u
k.ei(l)}break}}return k},
aax:function aax(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},
x5:function x5(d,e){this.a=d
this.b=e},
aiS:function aiS(d,e,f,g,h){var _=this
_.a=d
_.b=e
_.c=f
_.d=g
_.e=h},
b4S:function b4S(d,e){this.a=d
this.b=e},
bLj(d,e){var x=new A.cD($.an().r,C.aj,null,null,A.a([],y.v))
x.smN(e)
new B.bkc(d,x).a6x()
return x},
bkc:function bkc(d,e){var _=this
_.a=d
_.b=e
_.r=_.f=_.e=_.d=_.c=0
_.z=_.y=_.x=_.w=null},
bVE(d){if(!C.d.v(d,"&"))return d
return A.bBN(d,$.bMM(),new B.bnY(),null)},
HT:function HT(d,e,f){this.a=d
this.b=e
this.c=f},
bnX:function bnX(d){this.a=d
this.b=0},
bnY:function bnY(){},
ay3:function ay3(d){var _=this
_.a=d
_.b=null
_.c=!1
_.d=null
_.e=!1},
ay4:function ay4(d){this.a=d},
ay5:function ay5(d){this.a=d},
a2E:function a2E(d,e,f){this.e=d
this.c=e
this.a=f},
PE:function PE(d,e,f,g,h,i,j){var _=this
_.E=d
_.a3=e
_.U=f
_.aT=_.bd=null
_.bF=g
_.D$=h
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
aRE:function aRE(d,e){this.a=d
this.b=e},
aRF:function aRF(d){this.a=d},
pF:function pF(d,e,f,g){var _=this
_.c=d
_.d=e
_.e=f
_.a=g},
agC:function agC(){this.d=$
this.c=this.a=null},
b1M:function b1M(d){this.a=d},
b1L:function b1L(d){this.a=d},
as4(d){var x,w
for(x=0;x<5;++x){w=D.kH[x]
if(w.a===d)return w}return null},
vp:function vp(d,e,f){this.a=d
this.c=e
this.d=f},
ay7:function ay7(){},
a_u(d){return A.au(["left",d.a,"top",d.b,"right",d.c,"bottom",d.d],y.N,y.X)}},D,E
J=c[1]
A=c[0]
C=c[2]
B=a.updateHolder(c[174],B)
D=c[467]
E=c[473]
B.vo.prototype={
Oj(d){var x,w,v,u,t=this,s=t.y,r=t.r
if(r==null)r=null
if(d===C.hB)return B.bDD(t.CW,t.x,null,t.f,C.hB,s,t.a,t.w,C.Q,r,s)
x=t.Q
if(x==null){w=s.b
v=new A.K(w,0,w,s.d)}else v=x
if(x==null){w=s.b
u=new A.K(w,0,w,s.d)}else u=x
w=t.w
return B.bDD(t.CW,t.x,null,t.f,C.kY,v,t.a,new A.a1(w.b,w.a),C.Q,r,u)},
aKy(){return this.Oj(C.hB)},
dB(){var x,w=this,v=y.N,u=y.X,t=A.H(v,u)
t.n(0,"id",w.a)
t.n(0,"name",w.b)
t.n(0,"brand",w.c)
x=w.d
if(x!=null)t.n(0,"year",x)
t.n(0,"platform",w.e.b)
t.n(0,"kind",w.CW.b)
x=w.w
t.n(0,"portraitSize",A.au(["width",x.a,"height",x.b],v,u))
t.n(0,"frame",w.f.dB())
v=w.r
if(v!=null)t.n(0,"systemUi",v.dB())
t.n(0,"devicePixelRatio",w.x)
t.n(0,"portraitPadding",B.a_u(w.y))
v=w.Q
if(v!=null)t.n(0,"landscapePadding",B.a_u(v))
t.n(0,"systemGestureInsets",B.a_u(C.Q))
v=w.ax
if(v!=null)t.n(0,"portraitKeyboardHeight",v)
v=w.ay
if(v!=null)t.n(0,"landscapeKeyboardHeight",v)
return t},
h(d,e){var x=this
if(e==null)return!1
if(x===e)return!0
return e instanceof B.vo&&e.a===x.a&&e.b===x.b&&e.c===x.c&&e.d==x.d&&e.e===x.e&&e.f.h(0,x.f)&&J.x(e.r,x.r)&&e.w.h(0,x.w)&&e.x===x.x&&e.y.h(0,x.y)&&J.x(e.Q,x.Q)&&C.Q.h(0,C.Q)&&e.ax==x.ax&&e.ay==x.ay&&A.cu(D.tC,D.tC)&&e.CW===x.CW},
gq(d){var x=this
return A.P(x.a,x.b,x.c,x.d,x.e,x.f,x.r,x.w,x.x,x.y,null,x.Q,null,C.Q,x.ax,x.ay,A.bo(D.tC),x.CW,C.a,C.a)},
l(d){return"DevicePreset("+this.a+", "+this.b+")"}}
B.vn.prototype={
aBH(d,e){var x,w,v,u=this.b,t=-u.a
u=-u.b
x=this.a
w=t+x.a
x=u+x.b
if(e===C.hB)return new A.O(t,u,w,x)
v=d.b
return new A.O(u,v-w,x,v-t)},
dB(){var x=this,w=y.N,v=y.X,u=A.H(w,v),t=x.a
u.n(0,"size",A.au(["width",t.a,"height",t.b],w,v))
t=x.b
if(!t.h(0,C.x))u.n(0,"screenOffset",A.au(["x",t.a,"y",t.b],w,v))
w=x.c
if(w.length!==0)u.n(0,"screenPath",w)
w=x.d
if(w.length!==0)u.n(0,"body",w)
return u},
h(d,e){var x=this
if(e==null)return!1
if(x===e)return!0
return e instanceof B.vn&&e.a.h(0,x.a)&&e.b.h(0,x.b)&&e.c===x.c&&e.d===x.d},
gq(d){var x=this
return A.P(x.a,x.b,x.c,x.d,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a)},
l(d){var x=this
return"DeviceFrame(size: "+x.a.l(0)+", screenOffset: "+x.b.l(0)+", screenPath: "+x.c.length+" chars, body: "+x.d.length+" chars)"}}
B.LN.prototype={
K(){return"DeviceKind."+this.b}}
B.LO.prototype={
gaCL(){var x=this.c,w=new A.O(0,0,0+x.a,0+x.b),v=this.d,u=v.a.gab(0)
if(u)return w
return w.h9(v.aBH(x,this.b))},
dB(){var x,w=this,v=y.N,u=y.X,t=A.H(v,u)
t.n(0,"presetId",w.a)
t.n(0,"orientation",w.b.b)
x=w.c
t.n(0,"screenSize",A.au(["width",x.a,"height",x.b],v,u))
t.n(0,"frame",w.d.dB())
v=w.e
if(v!=null)t.n(0,"systemUi",v.dB())
t.n(0,"deviceKind",w.w.b)
t.n(0,"devicePixelRatio",w.x)
t.n(0,"padding",B.a_u(w.y))
t.n(0,"viewPadding",B.a_u(w.z))
t.n(0,"systemGestureInsets",B.a_u(w.Q))
v=w.at
if(v!=null){u=A.am(v).i("ar<1,b9<q,J?>>")
v=A.af(new A.ar(v,new B.ay6(),u),u.i("b8.E"))
t.n(0,"displayFeatures",v)}return t},
h(d,e){var x,w=this
if(e==null)return!1
if(w===e)return!0
x=!1
if(e instanceof B.LO)if(e.a===w.a)if(e.b===w.b)if(e.c.h(0,w.c))if(e.d.h(0,w.d))if(J.x(e.e,w.e))if(e.w===w.w)if(e.x===w.x)if(e.y.h(0,w.y))if(e.z.h(0,w.z))if(e.Q.h(0,w.Q))if(A.cu(e.at,w.at))x=A.cu(null,null)
return x},
gq(d){var x=this,w=null,v=x.at
v=v==null?w:A.bo(v)
return A.P(x.a,x.b,x.c,x.d,x.e,!0,w,x.w,x.x,x.y,x.z,x.Q,w,v,w,w,w,w,w,w)},
l(d){var x,w=this,v=A.a([],y.s)
v.push("presetId: "+w.a)
v.push("orientation: "+w.b.b)
v.push("screenSize: "+w.c.l(0))
v.push("frame: "+w.d.l(0))
x=w.e
if(x!=null)v.push("systemUi: "+x.l(0))
v.push("deviceKind: "+w.w.b)
v.push("devicePixelRatio: "+w.x)
v.push("padding: "+w.y.l(0))
v.push("viewPadding: "+w.z.l(0))
v.push("systemGestureInsets: "+w.Q.l(0))
x=w.at
if(x!=null)v.push("displayFeatures: "+A.D(x))
return"DeviceSimulation("+C.b.aR(v,", ")+")"}}
B.H_.prototype={
dB(){var x=A.H(y.N,y.X),w=this.a,v=w.gab(0)
if(!v)x.n(0,"statusBar",w.dB())
w=this.b
v=w.gab(0)
if(!v)x.n(0,"navigationBar",w.dB())
x.n(0,"platform",this.c.b)
return x},
h(d,e){var x=this
if(e==null)return!1
if(x===e)return!0
return e instanceof B.H_&&e.a.h(0,x.a)&&e.b.h(0,x.b)&&e.c===x.c},
gq(d){return A.P(this.a,this.b,this.c,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a)},
l(d){return"SystemUiSimulation(statusBar: "+this.a.l(0)+", navigationBar: "+this.b.l(0)+", platform: "+this.c.l(0)+")"}}
B.tX.prototype={
gab(d){return this.a.length===0&&this.b.length===0&&this.c.length===0},
dB(){var x=this,w=A.H(y.N,y.X),v=x.a
if(v.length!==0)w.n(0,"leading",v)
v=x.b
if(v.length!==0)w.n(0,"center",v)
v=x.c
if(v.length!==0)w.n(0,"trailing",v)
w.n(0,"inset",x.d)
v=x.e
if(v!=null)w.n(0,"bottomInset",v)
return w},
h(d,e){var x=this
if(e==null)return!1
if(x===e)return!0
return e instanceof B.tX&&e.a===x.a&&e.b===x.b&&e.c===x.c&&e.d===x.d&&e.e==x.e},
gq(d){var x=this
return A.P(x.a,x.b,x.c,x.d,x.e,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a)},
l(d){var x=this
return"SystemUiBar(leading: "+x.a.length+" chars, center: "+x.b.length+" chars, trailing: "+x.c.length+" chars, inset: "+x.d+", bottomInset: "+A.D(x.e)+")"}}
B.aRD.prototype={
h(d,e){var x=this
if(e==null)return!1
if(x===e)return!0
return e instanceof B.aRD&&e.a.h(0,x.a)&&e.b.h(0,x.b)&&e.c.h(0,x.c)&&e.d.h(0,x.d)&&e.e.h(0,x.e)},
gq(d){var x=this
return A.P(x.a,x.b,x.c,x.d,x.e,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a)},
l(d){return"SystemUiColors(statusBarIcons: "+this.a.l(0)+", navigationBarIcons: "+this.b.l(0)+")"}}
B.aax.prototype={}
B.x5.prototype={
aJc(d,e){var x,w,v,u,t,s,r,q,p,o,n,m,l,k
$.an()
x=A.bA()
x.f=!0
for(w=this.b,v=w.length,u=d.a,t=e!=null,s=0;s<w.length;w.length===v||(0,A.F)(w),++s){r=w[s]
q=t&&r.d
p=r.b
if(q)p=e.aN(e.a*p.a)
q=r.c
if(q.length===0){q=r.a
x.r=p.N()
o=x.du()
n=q.e
u.drawPath((n==null?q.e=new A.n6(q.ghW().a.snapshot()):n).a,o)
o.delete()
continue}J.b7(u.save())
for(n=q.length,m=0;m<q.length;q.length===n||(0,A.F)(q),++m){l=q[m]
k=l.e
if(k==null)k=l.e=new A.n6(l.ghW().a.snapshot())
u.clipPath(k.a,$.JY(),!0)}q=r.a
x.r=p.N()
o=x.du()
n=q.e
u.drawPath((n==null?q.e=new A.n6(q.ghW().a.snapshot()):n).a,o)
o.delete()
u.restore()}},
a5J(d,e,f){var x,w,v,u,t,s,r=this
if(r.b.length===0||r.a.gab(0)||e.gab(0))return
x=d.a
J.b7(x.save())
w=e.a
v=e.b
x.translate(w,v)
u=r.a
t=u.a
s=u.b
d.u_((e.c-w)/(u.c-t),(e.d-v)/(u.d-s))
x.translate(-t,-s)
r.aJc(d,f)
x.restore()},
aJg(d,e){return this.a5J(d,e,null)}}
B.aiS.prototype={}
B.b4S.prototype={
a6Z(d,e){var x,w,v
for(x=d.c,w=x.length,v=0;v<x.length;x.length===w||(0,A.F)(x),++v)this.aAG(x[v],e)},
aAG(d,e){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j=this,i=d.a
if(D.bWc.v(0,i))return
x=B.bHJ(d)
w=new Float64Array(16)
v=new A.cg(w)
v.dF(e.a)
u=B.hK(x,"transform")
if(u!=null)v.ei(B.bJB(u))
t=B.hK(x,"opacity")
t=t==null?null:A.ew(t)
if(t==null)t=1
s=e.d*t
r=B.hK(x,"fill")
q=e.c
if(r==="currentColor"){p=e.b
if(p==null)p=C.cl
q=!0}else if(r==null)p=e.b
else if(r==="none"||r==="transparent")p=null
else{o=B.c10(r)
t=o==null
p=t?e.b:o
q=t&&q}n=j.avy(x,v,e)
if(D.bW0.v(0,i)){j.a6Z(d,new B.aiS(v,p,q,s,n))
return}if(p==null)return
m=j.Sb(d,x)
if(m==null)return
i=B.hK(x,"fill-opacity")
l=i==null?null:A.ew(i)
k=C.f.I(s*(l==null?1:l),0,1)
j.b.push(new B.aax(m.aE(w),p.aN(p.a*k),n,q))},
avy(a0,a1,a2){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e=null,d=B.hK(a0,"clip-path")
if(d==null)return a2.e
x=$.bNH().fG(d)
w=x==null?e:x.b[1]
v=w==null?e:this.a.k(0,w)
if(v==null||v.length===0)return a2.e
u=$.an()
t=A.a([],y.v)
s=new A.cD(u.r,C.aj,e,e,t)
for(u=v.length,r=y.t,q=0;q<v.length;v.length===u||(0,A.F)(v),++q){p=v[q]
o=B.bHJ(p)
n=this.Sb(p,o)
if(n==null)continue
m=o.k(0,"transform")
l=m==null||m.length===0?e:C.d.au(m)
if(l==null)k=n
else{k=B.bJB(l)
j=n.b
i=n.a
h=n.c
g=n.d
f=A.iY(n.r,!0,r)
g=new A.cD(i,j,h,g,f)
f.push(new A.S1(new Float64Array(A.p7(k.a))))
k=g}j=k.b
i=k.c
h=A.iY(k.r,!0,r)
k=new A.yk(new A.cD(k.a,j,i,k.d,h),C.x,e)
t.push(k)
j=s.f
if(j!=null)k.e9(j)
k=s.e
if(k!=null)k.a.delete()
s.e=null}u=A.af(a2.e,y.i)
u.push(s.aE(a1.a))
return u},
Sb(d,e){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i=null,h=B.hK(e,"fill-rule")==="evenodd"?C.uq:C.aj
switch(d.a){case"path":x=B.hK(e,"d")
if(x==null)return i
return B.bLj(x,h)
case"rect":w=B.hK(e,"width")
v=w==null?i:A.ew(w)
if(v==null)v=0
w=B.hK(e,"height")
u=w==null?i:A.ew(w)
if(u==null)u=0
if(v<=0||u<=0)return i
w=B.hK(e,"x")
t=w==null?i:A.ew(w)
if(t==null)t=0
w=B.hK(e,"y")
s=w==null?i:A.ew(w)
if(s==null)s=0
w=B.hK(e,"rx")
r=w==null?i:A.ew(w)
w=B.hK(e,"ry")
q=w==null?i:A.ew(w)
w=t+v
p=s+u
o=new A.cD($.an().r,C.aj,i,i,A.a([],y.v))
o.smN(h)
n=r==null
if((n?q:r)==null)o.aO(new A.rc(new A.O(t,s,w,p)))
else{if(n){q.toString
n=q}else n=r
if(q==null){r.toString
m=r}else m=q
o.aO(new A.hT(new A.qf(t,s,w,p,n,m,n,m,n,m,n,m)))}return o
case"circle":w=B.hK(e,"r")
l=w==null?i:A.ew(w)
if(l==null)l=0
if(l<=0)return i
w=new A.cD($.an().r,C.aj,i,i,A.a([],y.v))
w.smN(h)
p=B.hK(e,"cx")
p=p==null?i:A.ew(p)
if(p==null)p=0
n=B.hK(e,"cy")
n=n==null?i:A.ew(n)
w.aO(new A.kP(A.og(new A.y(p,n==null?0:n),l)))
return w
case"ellipse":w=B.hK(e,"rx")
r=w==null?i:A.ew(w)
if(r==null)r=0
w=B.hK(e,"ry")
q=w==null?i:A.ew(w)
if(q==null)q=0
if(r<=0||q<=0)return i
w=new A.cD($.an().r,C.aj,i,i,A.a([],y.v))
w.smN(h)
p=B.hK(e,"cx")
p=p==null?i:A.ew(p)
if(p==null)p=0
n=B.hK(e,"cy")
n=n==null?i:A.ew(n)
w.aO(new A.kP(A.a7F(new A.y(p,n==null?0:n),q*2,r*2)))
return w
case"polygon":w=B.hK(e,"points")
k=B.bpT(w==null?"":w)
if(k.length<6)return i
w=$.an()
p=A.a([],y.v)
o=new A.cD(w.r,C.aj,i,i,p)
o.smN(h)
o.aO(new A.i4(k[0],k[1]))
for(j=2;w=j+1,w<k.length;j+=2){w=new A.dT(k[j],k[w])
p.push(w)
n=o.f
if(n!=null)w.e9(n)
w=o.e
if(w!=null)w.a.delete()
o.e=null}o.aO(new A.rt())
return o
default:return i}}}
B.bkc.prototype={
a6x(){var x,w,v,u,t=this
for(x=t.a,w=x.length,v=null;;){t.Jn()
u=t.c
if(u>=w)return
if(C.d.v("MmZzLlHhVvCcSsQqTtAa",A.dN(x.charCodeAt(u)))){u=t.c
v=x[u]
t.c=u+1}else if(v==null)throw A.w(A.cr("Expected an SVG path command",x,t.c))
else if(v==="Z"||v==="z")throw A.w(A.cr('Unexpected argument after a "close" command',x,t.c))
t.aj5(v)
if(v==="M")v="L"
else if(v==="m")v="l"}},
aj5(d){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h=this,g=d.toUpperCase()!==d
switch(d.toUpperCase()){case"M":x=h.eE()
w=x+(g?h.d:0)
x=h.eE()
v=x+(g?h.e:0)
h.b.aO(new A.i4(w,v))
h.d=h.f=w
h.e=h.r=v
h.zd()
break
case"L":x=h.eE()
u=g?h.d:0
t=h.eE()
s=g?h.e:0
h.A5(x+u,t+s)
break
case"H":x=h.eE()
u=g?h.d:0
h.A5(x+u,h.e)
break
case"V":x=h.d
u=h.eE()
h.A5(x,u+(g?h.e:0))
break
case"C":r=g?h.d:0
q=g?h.e:0
h.Tu(h.eE()+r,h.eE()+q,h.eE()+r,h.eE()+q,h.eE()+r,h.eE()+q)
break
case"S":r=g?h.d:0
q=g?h.e:0
x=h.eE()
u=h.eE()
t=h.eE()
s=h.eE()
p=h.w
o=h.d
o=p==null?o:2*o-p
p=h.x
n=h.e
n=p==null?n:2*n-p
h.Tu(o,n,x+r,u+q,t+r,s+q)
break
case"Q":r=g?h.d:0
q=g?h.e:0
h.XX(h.eE()+r,h.eE()+q,h.eE()+r,h.eE()+q)
break
case"T":r=g?h.d:0
q=g?h.e:0
x=h.eE()
u=h.eE()
t=h.y
o=h.d
o=t==null?o:2*o-t
t=h.z
n=h.e
n=t==null?n:2*n-t
h.XX(o,n,x+r,u+q)
break
case"A":m=Math.abs(h.eE())
l=Math.abs(h.eE())
k=h.eE()
j=h.Up()
i=h.Up()
x=h.eE()
w=x+(g?h.d:0)
x=h.eE()
v=x+(g?h.e:0)
if(m===0||l===0)h.A5(w,v)
else{h.b.aO(new A.a01(new A.y(w,v),new A.be(m,l),k,j,i))
h.d=w
h.e=v
h.zd()}break
case"Z":h.b.aO(new A.rt())
h.d=h.f
h.e=h.r
h.zd()
break
default:throw A.w(A.cr('Unsupported SVG path command "'+d+'"',h.a,h.c))}},
A5(d,e){var x=this
x.b.aO(new A.dT(d,e))
x.d=d
x.e=e
x.zd()},
Tu(d,e,f,g,h,i){var x=this
x.b.aO(new A.a2j(d,e,f,g,h,i))
x.d=h
x.e=i
x.z=x.y=null
x.w=f
x.x=g},
XX(d,e,f,g){var x=this
x.b.aO(new A.tw(d,e,f,g))
x.d=f
x.e=g
x.x=x.w=null
x.y=d
x.z=e},
zd(){var x=this
x.z=x.y=x.x=x.w=null},
Jn(){var x,w,v,u
for(x=this.a,w=x.length;v=this.c,v<w;){u=x.charCodeAt(v)
if(u===32||u===9||u===10||u===13||u===12||u===44)this.c=v+1
else return}},
eE(){var x,w,v,u,t,s,r,q,p,o=this
o.Jn()
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
p=A.ew(C.d.S(w,x,v))
if(p==null)throw A.w(A.cr("Expected a number",w,x))
return p},
Up(){var x,w,v,u=this
u.Jn()
x=u.c
w=u.a
if(x>=w.length)throw A.w(A.cr("Expected an arc flag",w,x))
v=w.charCodeAt(x)
if(v!==48&&v!==49)throw A.w(A.cr('Expected an arc flag ("0" or "1")',w,x))
u.c=x+1
return v===49}}
B.HT.prototype={
BJ(d){var x=this.b.k(0,d)
return x==null||x.length===0?null:x},
l(d){var x=this.b
return"<"+this.a+" "+new A.c3(x,A.G(x).i("c3<1>")).aR(0," ")+">"}}
B.bnX.prototype={
aJm(){var x,w,v,u=this
for(x=u.a,w=x.length;;){u.vW()
v=u.b
if(v>=w)throw A.w(A.cr("No XML element found",x,v))
if(!C.d.bO(x,"<",v))throw A.w(A.cr("Expected an element",x,v))
if(C.d.bO(x,"<?",v))u.rg("?>")
else if(C.d.bO(x,"<!--",v))u.rg("-->")
else if(C.d.bO(x,"<!",v))u.ZH()
else return u.Xs()}},
Xs(){var x,w,v,u,t,s,r,q,p,o,n=this
n.aja("<")
x=n.II()
w=y.N
v=A.H(w,w)
for(w=n.a;;){n.vW()
u=n.b
if(C.d.bO(w,"/>",u)){n.b=u+2
t=C.d.dt(x,":")
return new B.HT(t===-1?x:C.d.aL(x,t+1),v,D.bEE)}if(C.d.bO(w,">",u)){n.b=u+1
break}s=n.II()
n.vW()
u=n.b
if(!C.d.bO(w,"=",u))A.az(A.cr('Expected "="',w,u))
n.b=u+1
n.vW()
v.n(0,s,n.auM())}r=A.a([],y.y)
for(u=w.length;;){q=n.b
n.axV(60)
p=n.b
if(p>=u)throw A.w(A.cr('Unterminated element "<'+x+'>"',w,q))
if(C.d.bO(w,"</",p)){n.b=p+2
o=n.II()
n.vW()
u=n.b
if(!C.d.bO(w,">",u))A.az(A.cr('Expected ">"',w,u));++u
n.b=u
if(o!==x)throw A.w(A.cr('Closing tag "</'+o+'>" does not match "<'+x+'>"',w,u))
t=C.d.dt(x,":")
return new B.HT(t===-1?x:C.d.aL(x,t+1),v,r)}if(C.d.bO(w,"<!--",p))n.rg("-->")
else if(C.d.bO(w,"<![CDATA[",p))n.rg("]]>")
else if(C.d.bO(w,"<?",p))n.rg("?>")
else if(C.d.bO(w,"<!",p))n.ZH()
else r.push(n.Xs())}},
aja(d){var x=this.a,w=this.b
if(!C.d.bO(x,d,w))throw A.w(A.cr('Expected "'+d+'"',x,w))
this.b=w+d.length},
rg(d){var x=this.a,w=this.b,v=C.d.k8(x,d,w)
if(v===-1)throw A.w(A.cr('Expected "'+d+'"',x,w))
this.b=v+d.length},
axV(d){var x,w=this.a,v=w.length
for(;;){x=this.b
if(!(x<v&&w.charCodeAt(x)!==d))break
this.b=x+1}},
ZH(){var x,w,v,u,t,s=this
s.b+=2
x=s.a
w=x.length
v=1
for(;;){u=s.b
if(!(u<w&&v>0))break
A:{t=x.charCodeAt(u)
if(t===91){s.rg("]")
break A}if(t===62)--v
s.b=u+1}}if(v>0)throw A.w(A.cr("Unterminated declaration",x,u))},
vW(){var x,w,v,u
for(x=this.a,w=x.length;v=this.b,v<w;){u=x.charCodeAt(v)
if(u===32||u===9||u===10||u===13)this.b=v+1
else return}},
II(){var x,w,v,u,t,s,r=this.b
for(x=this.a,w=x.length,v=r;v<w;){u=x.charCodeAt(v)
t=!0
if(!(u>=65&&u<=90))if(!(u>=97&&u<=122)){s=u>=48&&u<=57||u===45||u===95||u===46||u===58
t=s}if(!t)break;++v
this.b=v}if(v===r)throw A.w(A.cr("Expected a name",x,r))
return C.d.S(x,r,v)},
auM(){var x,w,v,u=this,t=u.b,s=u.a,r=s.length
if(t>=r)throw A.w(A.cr("Expected an attribute value",s,t))
x=s.charCodeAt(t)
if(x!==34&&x!==39)throw A.w(A.cr("Attribute values must be quoted",s,t))
t=u.b=t+1
w=t
for(;;){if(!(w<r&&s.charCodeAt(w)!==x))break;++w
u.b=w}if(w>=r)throw A.w(A.cr("Unterminated attribute value",s,t))
v=C.d.S(s,t,w)
u.b=w+1
return B.bVE(v)}}
B.ay3.prototype={
ga1m(){var x=this
if(!x.c){x.c=!0
if(x.a.d.length!==0)x.b=x.V8(new B.ay4(x),"body artwork")}return x.b},
ga87(){var x=this
if(!x.e){x.e=!0
if(x.a.c.length!==0)x.d=x.V8(new B.ay5(x),"screen outline")}return x.d},
a86(d,e){var x,w=this.ga87()
if(w==null)return null
if(e===C.hB)return w
x=A.eN()
x.eu(0,d.b,0,1)
x.xS(-1.5707963267948966)
return w.aE(x.a)},
aJd(d,e,f){var x,w,v,u,t=this.ga1m()
if(t==null||t.b.length===0)return
x=d.a
J.b7(x.save())
if(f===C.kY){x.translate(0,e.b)
d.Om(-1.5707963267948966)}w=this.a
v=w.b
u=-v.a
v=-v.b
w=w.a
t.aJg(d,new A.O(u,v,u+w.a,v+w.b))
x.restore()},
aku(d,e){var x,w,v,u
try{v=d.$0()
return v}catch(u){x=A.aG(u)
w=A.bf(u)
v=A.bC("while parsing the device frame "+e)
A.dv(new A.bU(x,w,"device_preview",v,null,!1))
return null}},
V8(d,e){return this.aku(d,e,y.z)}}
B.a2E.prototype={
aI(d){var x=A.eW(d)
if(x==null)x=C.t
x=new B.PE(this.e,null,x,A.aS(),null,new A.bu(),A.aS())
x.aH()
x.sb1(null)
return x},
aM(d,e){var x
e.sa9z(this.e)
e.saJ9(null)
x=A.eW(d)
e.sbM(x==null?C.t:x)}}
B.PE.prototype={
sa9z(d){var x,w=this,v=w.E
if(d===v)return
if(w.y!=null){x=w.gHz()
v.P(x)
d.a_(x)}w.E=d
w.aP()},
saJ9(d){return},
sbM(d){if(d===this.U)return
this.U=d
this.aP()},
ar(d){this.oS(d)
this.E.a_(this.gHz())},
ai(){this.E.P(this.gHz())
this.mi()},
m(){this.bF.saK(null)
this.hB()},
an5(){return this.aP()},
gaeq(){var x=this,w=x.E.a,v=w==null?null:w.d
if(v==null)return x.bd=null
w=x.bd
if(!J.x(w==null?null:w.a,v))x.bd=new B.ay3(v)
return x.bd},
gaer(){var x,w=this,v=w.E.a,u=v==null?null:v.e
if(u!=null){x=u.a.gab(0)
if(x)x=u.b.gab(0)
else x=!1
if(!x)v.toString}else x=!0
if(x)return w.aT=null
x=w.aT
if(!J.x(x==null?null:x.a,u))w.aT=new B.aRE(u,A.H(y.N,y.B))
return w.aT},
asF(d,e){var x,w,v,u,t,s,r,q,p,o,n=this,m=n.gaer(),l=n.E.a
if(m==null||l==null)return
x=d.gdT()
w=x.a
J.b7(w.save())
w.translate(e.a,e.b)
v=n.gA()
u=l.y
t=$.bv().c
s=l.e
s=s==null?null:s.c
if((s==null?null:s)==null)A.b1()
r=t.d===C.ae?C.bU:C.ae
t=r===C.bU
s=t?C.aM:D.xQ
t=t?C.aM:D.xQ
q=n.U
p=m.a
o=u.b
if(o>0)m.Xg(x,C.aB,p.a,C.aB,!1,new A.O(0,0,0+v.a,0+o),q,s)
u=u.d
if(u>0){s=v.b-u
m.Xg(x,C.aB,p.b,C.aB,!0,new A.O(0,s,0+v.a,s+u),q,t)}w.restore()},
asC(d,e){return},
Io(d,e){this.le(d,e)
this.asC(d,e)
this.asF(d,e)},
aC(d,e){var x,w,v,u,t,s,r=this,q=r.gaeq()
if(q==null){r.bF.saK(null)
r.Io(d,e)
return}x=r.E.a
w=x==null?null:x.b
if(w==null)w=C.hB
v=r.gA()
if(q.ga1m()!=null){u=d.gdT()
x=u.a
J.b7(x.save())
x.translate(e.a,e.b)
q.aJd(u,v,w)
x.restore()}t=q.a86(v,w)
if(t==null){r.bF.saK(null)
r.Io(d,e)
return}x=r.bF
s=r.cx
s===$&&A.d()
x.saK(d.aJG(s,e,new A.O(0,0,0+v.a,0+v.b),t,r.gasA(),x.a))}}
B.aRE.prototype={
Xg(d,e,f,g,h,i,j,k){var x,w,v,u
if(e.a>0){$.an()
x=A.bA()
x.r=e.N()
d.fi(i,x)}if(g.a>0){x=i.a
w=h?i.b:i.d-1
$.an()
v=A.bA()
v.r=g.N()
d.fi(new A.O(x,w,x+(i.c-x),w+1),v)}u=j===C.ag
this.In(d,-1,f,i,u?f.c:f.a,k)
this.In(d,0,f,i,f.b,k)
this.In(d,1,f,i,u?f.a:f.c,k)},
In(d,e,f,g,h,i){var x,w,v,u,t,s,r
if(h.length===0)return
x=this.aiG(h)
w=!0
if(x!=null)if(x.b.length!==0){w=x.a
w=new A.a1(w.c-w.a,w.d-w.b).gab(0)}if(w)return
w=x.a
v=w.c-w.a
w=w.d-w.b
A:{if(e<0){u=g.a+f.d
break A}if(0===e){u=g.gb0().a-v/2
break A}u=g.c-f.d-v
break A}t=f.e
s=t==null?g.gb0().b-w/2:g.d-t-w
r=Math.max(g.b,Math.min(s,g.d-w))
x.a5J(d,new A.O(u,r,u+v,r+w),i)},
aiG(d){return this.b.bk(d,new B.aRF(d))}}
B.pF.prototype={
t(){return new B.agC()}}
B.agC.prototype={
ad(){var x,w,v=this
v.ah()
x=v.a
x=x.c.F7(x.e)
w=$.a4()
v.d!==$&&A.bz()
v.d=new A.bq(x,w,y.T)},
an(d){var x,w=this
w.aw(d)
x=w.a
if(d.c!==x.c||d.e!==x.e)w.p(new B.b1M(w))},
m(){var x=this.d
x===$&&A.d()
x.k1$=$.a4()
x.id$=0
this.T()},
j(d){var x,w,v=null,u=A.h(d),t=this.a,s=t.c,r=t.e,q=s.Ql(r),p=s.aJb(r),o=s.a4V(r),n=s.qj(r),m=A.de(d,v)
t=m==null?D.bP6:m
x=t.aDP(s.c.x,p,q,C.Q,p)
t=this.d
t===$&&A.d()
w=u.aDp(new B.b1L(s))
return A.bJ(v,v,new A.A(n.a,n.b,new A.I(o,new B.a2E(t,new A.A(q.a,q.b,A.bm(A.Hf(A.Oj(this.a.d,x),w),u.a.b,!0),v),v),v),v),!0,v,v,!1,v,!0,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v)}}
B.vp.prototype={
Ql(d){var x
if(!this.d||d===C.cx)return this.c.w
x=this.c.Oj(C.kY)
return x.c},
aJb(d){var x,w
if(!this.d||d===C.cx)return this.c.y
x=this.c
w=x.Q
if(w==null){x=x.y
w=x.b
x=new A.K(w,0,w,x.d)}else x=w
return x},
F7(d){if(!this.d||d===C.cx)return this.c.aKy()
return this.c.Oj(C.kY)},
a4V(d){var x=this.F7(d),w=x.c,v=x.gaCL(),u=v.gab(0)
if(u)return C.Q
u=new B.ay7()
return new A.K(u.$1(-v.a),u.$1(-v.b),u.$1(v.c-w.a),u.$1(v.d-w.b))},
qj(d){var x=this.Ql(d),w=this.a4V(d)
return new A.a1(x.a+w.a+w.c,x.b+w.b+w.d)}}
var z=a.updateTypes(["b9<q,J?>(bGr)","x5()","~()","~(ks,y)","x5?()"])
B.ay6.prototype={
$1(d){return d.dB()},
$S:z+0}
B.bnY.prototype={
$1(d){var x,w=d.ma(1)
w.toString
switch(w){case"amp":return"&"
case"lt":return"<"
case"gt":return">"
case"quot":return'"'
case"apos":return"'"}if(C.d.ac(w,"#x")||C.d.ac(w,"#X")){x=A.eQ(C.d.aL(w,2),16)
if(x==null){w=d.ma(0)
w.toString}else w=A.dN(x)
return w}if(C.d.ac(w,"#")){x=A.eQ(C.d.aL(w,1),null)
if(x==null){w=d.ma(0)
w.toString}else w=A.dN(x)
return w}w=d.ma(0)
w.toString
return w},
$S:142}
B.ay4.prototype={
$0(){return B.bGJ(this.a.a.d)},
$S:z+1}
B.ay5.prototype={
$0(){return B.bLj(this.a.a.c,C.aj)},
$S:731}
B.aRF.prototype={
$0(){var x,w,v,u
try{v=B.bGJ(this.a)
return v}catch(u){x=A.aG(u)
w=A.bf(u)
v=A.bC("while parsing simulated system UI")
A.dv(new A.bU(x,w,"device_preview",v,null,!1))
return null}},
$S:z+4}
B.b1M.prototype={
$0(){var x=this.a,w=x.d
w===$&&A.d()
x=x.a
w.sG(x.c.F7(x.e))},
$S:0}
B.b1L.prototype={
$0(){return this.a.c.e},
$S:732}
B.ay7.prototype={
$1(d){return isNaN(d)?0:C.f.I(d,0,1/0)},
$S:1};(function installTearOffs(){var x=a._instance_0u,w=a._instance_2u
var v
x(v=B.PE.prototype,"gHz","an5",2)
w(v,"gasA","Io",3)})();(function inheritance(){var x=a.inheritMany,w=a.inherit
x(A.J,[B.vo,B.vn,B.LO,B.H_,B.tX,B.aRD,B.aax,B.x5,B.aiS,B.b4S,B.bkc,B.HT,B.bnX,B.ay3,B.aRE,B.vp])
w(B.LN,A.dW)
x(A.ap,[B.ay6,B.bnY,B.ay7])
x(A.aA,[B.ay4,B.ay5,B.aRF,B.b1M,B.b1L])
w(B.a2E,A.bp)
w(B.PE,A.oi)
w(B.pF,A.r)
w(B.agC,A.t)})()
A.ag(b.typeUniverse,JSON.parse('{"a2E":{"bp":[],"b_":[],"b":[]},"PE":{"S":[],"bt":["S"],"R":[],"aW":[]},"pF":{"r":[],"b":[]},"agC":{"t":["pF"]}}'))
var y=(function rtii(){var x=A.e
return{M:x("fd<q>"),v:x("f<dM>"),s:x("f<q>"),j:x("f<aax>"),y:x("f<HT>"),n:x("f<C>"),P:x("a5<HT>"),i:x("wq"),t:x("dM"),F:x("wE"),N:x("q"),T:x("bq<LO?>"),z:x("@"),X:x("J?"),B:x("x5?")}})();(function constants(){var x=a.makeConstList
D.xQ=new A.ad(1,0.08627450980392157,0.09411764705882353,0.10980392156862745,C.L)
D.bjG=new A.eM("The root <svg> element needs a viewBox or width/height attributes",null,null)
D.bED=x([],A.e("f<wq>"))
D.tC=x([],A.e("f<bGr>"))
D.bEE=x([],y.y)
D.bXL=new A.a1(436,908)
D.bQC=new A.y(17,17)
D.aoT=new B.vn(D.bXL,D.bQC,"M 317.34,0 C 322.68,0 328.02,0.02 333.37,0.21 C 339.49,0.44 345.54,0.9 351.58,2.03 C 363.77,4.3 374.86,9.23 383.81,18.19 C 392.77,27.14 397.7,38.23 399.97,50.43 C 401.1,56.46 401.56,62.51 401.79,68.62 C 401.98,73.92 402,79.21 402,84.5 L 402,789.5 C 402,794.79 401.98,800.08 401.79,805.38 C 401.56,811.49 401.1,817.54 399.97,823.57 C 397.7,835.77 392.77,846.86 383.81,855.81 C 374.86,864.77 363.77,869.7 351.58,871.97 C 345.54,873.1 339.49,873.56 333.37,873.79 C 328.02,873.98 322.68,874 317.34,874 L 84.66,874 C 79.32,874 73.98,873.98 68.63,873.79 C 62.51,873.56 56.46,873.1 50.42,871.97 C 38.23,869.7 27.14,864.77 18.19,855.81 C 9.23,846.86 4.3,835.77 2.03,823.57 C 0.9,817.54 0.44,811.49 0.21,805.38 C 0.02,800.08 0,794.79 0,789.5 L 0,84.5 C 0,79.21 0.02,73.92 0.21,68.62 C 0.44,62.51 0.9,56.46 2.03,50.43 C 4.3,38.23 9.23,27.14 18.19,18.19 C 27.14,9.23 38.23,4.3 50.42,2.03 C 56.46,0.9 62.51,0.44 68.63,0.21 C 73.98,0.02 79.32,0 84.66,0 L 317.34,0 Z M 245,11 H 157 A 18.5,18.5 0 0 0 157,48 H 245 A 18.5,18.5 0 0 0 245,11 Z",'<svg viewBox="0 0 436 908">\n  <rect x="1" y="1" width="434" height="906" rx="79" fill="#000000"/>\n  <rect x="2" y="2" width="432" height="904" rx="78" fill="#7e7e7e"/>\n  <rect x="16" y="16" width="404" height="876" rx="64" fill="#7e7e7e"/>\n  <rect x="3" y="3" width="430" height="902" rx="77" fill="#2c2c2c"/>\n  <rect x="16" y="16" width="404" height="876" rx="64" fill="#2c2c2c"/>\n  <rect x="8" y="8" width="420" height="892" rx="72" fill="#000000"/>\n  <rect x="16" y="16" width="404" height="876" rx="64" fill="#000000"/>\n</svg>')
D.c0Z=new B.tX('<svg viewBox="0 0 30.75 11.62">\n  <g transform="scale(0.36) translate(-118.17, -47.03)" fill="currentColor">\n    <path d="M129.206 79.3125C126.038 79.3125 123.439 78.446 121.408 76.7131C119.376 74.9801 118.297 72.75 118.169 70.0227H123.325C123.496 71.429 124.128 72.5653 125.222 73.4318C126.315 74.2983 127.658 74.7315 129.249 74.7315C131.053 74.7315 132.509 74.1776 133.616 73.0696C134.739 71.9474 135.3 70.4702 135.3 68.6378C135.3 66.8054 134.739 65.321 133.616 64.1847C132.509 63.0341 131.067 62.4588 129.291 62.4588C128.041 62.4588 126.926 62.7216 125.946 63.2472C124.98 63.7727 124.213 64.5185 123.645 65.4844H118.659L120.257 47.7997H138.773V52.4446H124.518L123.773 61.0739H124.135C125.555 59.1562 127.722 58.1974 130.634 58.1974C133.545 58.1974 135.932 59.1634 137.793 61.0952C139.668 63.027 140.605 65.4986 140.605 68.5099C140.605 71.7202 139.554 74.3267 137.452 76.3295C135.364 78.3182 132.615 79.3125 129.206 79.3125Z"/>\n    <path d="M149.862 75.2855C148.868 75.2855 148.051 74.9659 147.412 74.3267C146.773 73.6875 146.453 72.8849 146.453 71.919C146.453 70.9389 146.773 70.1364 147.412 69.5114C148.051 68.8722 148.868 68.5526 149.862 68.5526C150.871 68.5526 151.688 68.8722 152.313 69.5114C152.952 70.1364 153.271 70.9389 153.271 71.919C153.271 72.8849 152.952 73.6875 152.313 74.3267C151.688 74.9659 150.871 75.2855 149.862 75.2855ZM149.862 59.3054C148.868 59.3054 148.051 58.9929 147.412 58.3679C146.773 57.7287 146.453 56.9261 146.453 55.9602C146.453 54.9801 146.773 54.1776 147.412 53.5526C148.051 52.9134 148.868 52.5937 149.862 52.5937C150.871 52.5937 151.688 52.9134 152.313 53.5526C152.952 54.1776 153.271 54.9801 153.271 55.9602C153.271 56.9261 152.952 57.7287 152.313 58.3679C151.688 58.9929 150.871 59.3054 149.862 59.3054Z"/>\n    <path d="M167.195 78.5455V53.3395H166.833L159.183 58.7088V53.4247L167.216 47.7997H172.692V78.5455H167.195Z"/>\n    <path d="M188 64.9091V60.6477H191.75C193.313 60.6477 194.584 60.2216 195.564 59.3693C196.544 58.5028 197.034 57.3807 197.034 56.0028C197.034 54.6392 196.551 53.5526 195.586 52.7429C194.634 51.919 193.355 51.5071 191.75 51.5071C190.159 51.5071 188.867 51.9261 187.872 52.7642C186.892 53.6023 186.353 54.7457 186.253 56.1946H181.118C181.26 53.3679 182.297 51.1378 184.229 49.5043C186.161 47.8565 188.725 47.0327 191.921 47.0327C194.904 47.0327 197.382 47.8139 199.357 49.3764C201.346 50.9247 202.34 52.8778 202.34 55.2358C202.34 57.0398 201.836 58.581 200.827 59.8594C199.833 61.1378 198.483 61.9545 196.779 62.3097V62.6719C198.881 62.9134 200.536 63.7017 201.743 65.0369C202.965 66.3722 203.576 68.0625 203.576 70.108C203.576 72.75 202.468 74.9446 200.252 76.6918C198.05 78.4389 195.28 79.3125 191.942 79.3125C188.632 79.3125 185.934 78.4673 183.846 76.777C181.772 75.0866 180.664 72.8352 180.522 70.0227H185.784C185.898 71.4432 186.516 72.5795 187.638 73.4318C188.76 74.2699 190.209 74.6889 191.985 74.6889C193.746 74.6889 195.181 74.2344 196.289 73.3253C197.411 72.402 197.972 71.2159 197.972 69.767C197.972 68.2614 197.425 67.0753 196.331 66.2088C195.238 65.3423 193.746 64.9091 191.857 64.9091H188Z"/>\n  </g>\n</svg>',"",'<svg viewBox="0 0 70.53 13.62">\n  <g transform="scale(0.36) translate(-826.18, -43.64)" fill="currentColor">\n    <path d="M826.182 68.8112C826.182 67.2663 827.434 66.014 828.979 66.014H831.776C833.321 66.014 834.573 67.2663 834.573 68.8112V74.4056C834.573 75.9505 833.321 77.2028 831.776 77.2028H828.979C827.434 77.2028 826.182 75.9505 826.182 74.4056V68.8112Z"/>\n    <path d="M840.168 61.8182C840.168 60.2733 841.42 59.021 842.965 59.021H845.762C847.307 59.021 848.559 60.2733 848.559 61.8182V74.4056C848.559 75.9505 847.307 77.2028 845.762 77.2028H842.965C841.42 77.2028 840.168 75.9505 840.168 74.4056V61.8182Z"/>\n    <path d="M854.154 52.028C854.154 50.4831 855.406 49.2308 856.951 49.2308H859.748C861.293 49.2308 862.545 50.4831 862.545 52.028V74.4056C862.545 75.9505 861.293 77.2028 859.748 77.2028H856.951C855.406 77.2028 854.154 75.9505 854.154 74.4056V52.028Z"/>\n    <path d="M868.14 46.4336C868.14 44.8887 869.392 43.6364 870.937 43.6364H873.734C875.279 43.6364 876.531 44.8887 876.531 46.4336V74.4056C876.531 75.9505 875.279 77.2028 873.734 77.2028H870.937C869.392 77.2028 868.14 75.9505 868.14 74.4056V46.4336Z"/>\n    <path d="M913.959 50.8742C920.859 50.8745 927.494 53.5806 932.495 58.4331C932.871 58.8077 933.473 58.803 933.844 58.4225L937.443 54.7146C937.631 54.5216 937.736 54.2601 937.734 53.9882C937.733 53.7162 937.625 53.456 937.435 53.2653C924.311 40.4267 903.606 40.4267 890.482 53.2653C890.291 53.4559 890.184 53.7159 890.182 53.9879C890.18 54.2599 890.285 54.5214 890.472 54.7146L894.073 58.4225C894.443 58.8035 895.046 58.8083 895.422 58.4331C900.423 53.5802 907.059 50.8742 913.959 50.8742ZM914.059 62.0682C917.849 62.068 921.505 63.5062 924.315 66.1035C924.695 66.4721 925.294 66.4641 925.664 66.0855L929.259 62.3775C929.449 62.1831 929.554 61.9192 929.551 61.645C929.548 61.3709 929.438 61.1093 929.245 60.9187C920.688 52.794 907.436 52.794 898.88 60.9187C898.686 61.1093 898.576 61.371 898.573 61.6453C898.571 61.9195 898.676 62.1833 898.866 62.3775L902.46 66.0855C902.831 66.4641 903.429 66.4721 903.809 66.1035C906.618 63.5079 910.27 62.0698 914.059 62.0682ZM921.369 69.3055C921.375 69.5805 921.269 69.8455 921.077 70.0381L914.858 76.4444C914.675 76.6326 914.427 76.7386 914.168 76.7386C913.908 76.7386 913.66 76.6326 913.477 76.4444L907.257 70.0381C907.065 69.8454 906.96 69.5802 906.965 69.3053C906.971 69.0303 907.088 68.77 907.288 68.5857C911.259 65.1568 917.076 65.1568 921.048 68.5857C921.247 68.7701 921.364 69.0306 921.369 69.3055Z" fill-rule="evenodd"/>\n    <path d="M951.27 55.2766C951.27 48.8499 956.48 43.64 962.907 43.64H1003.63C1010.06 43.64 1015.27 48.8499 1015.27 55.2766V69.8224C1015.27 76.2491 1010.06 81.459 1003.63 81.459H962.907C956.48 81.459 951.27 76.2491 951.27 69.8224V55.2766Z M966.132 72.7316L974.868 56.0124V55.7568H964.527V52.2197H979.186V55.7994L970.621 72.7316H966.132Z M990.824 73.2571C989.337 73.2571 988.011 72.9399 986.847 72.3054C985.691 71.6709 984.763 70.7523 984.062 69.5497C982.917 67.7883 982.344 65.4823 982.344 62.6319C982.344 59.2322 983.101 56.5617 984.616 54.6204C986.132 52.679 988.224 51.7084 990.895 51.7084C992.846 51.7084 994.508 52.234 995.881 53.2851C997.263 54.3363 998.102 55.7189 998.395 57.4329H994.148C993.949 56.7606 993.551 56.2255 992.955 55.8278C992.368 55.43 991.671 55.2312 990.867 55.2312C989.465 55.2312 988.362 55.8609 987.557 57.1204C986.761 58.3704 986.387 60.0608 986.435 62.1916H986.69C987.154 61.2256 987.841 60.4822 988.75 59.9614C989.669 59.4311 990.725 59.1659 991.918 59.1659C993.859 59.1659 995.469 59.8099 996.747 61.0978C998.026 62.3857 998.665 64.0098 998.665 65.97C998.665 68.1008 997.931 69.848 996.463 71.2116C994.995 72.5753 993.116 73.2571 990.824 73.2571ZM988.139 68.6832C988.849 69.3839 989.73 69.7343 990.781 69.7343C991.832 69.7343 992.713 69.3887 993.423 68.6974C994.143 67.9966 994.503 67.1301 994.503 66.0979C994.503 65.0562 994.153 64.1944 993.452 63.5126C992.751 62.8213 991.866 62.4756 990.796 62.4756C989.725 62.4756 988.835 62.8166 988.125 63.4984C987.424 64.1802 987.074 65.0325 987.074 66.0553C987.074 67.097 987.429 67.9729 988.139 68.6832Z" fill-rule="evenodd" fill-opacity="0.4"/>\n    <path d="M951.27 55.2766C951.27 48.8499 956.48 43.64 962.907 43.64H997.816V81.459H962.907C956.48 81.459 951.27 76.2491 951.27 69.8224V55.2766Z M966.132 72.7316L974.868 56.0124V55.7568H964.527V52.2197H979.186V55.7994L970.621 72.7316H966.132Z M990.824 73.2571C989.337 73.2571 988.011 72.9399 986.847 72.3054C985.691 71.6709 984.763 70.7523 984.062 69.5497C982.917 67.7883 982.344 65.4823 982.344 62.6319C982.344 59.2322 983.101 56.5617 984.616 54.6204C986.132 52.679 988.224 51.7084 990.895 51.7084C992.846 51.7084 994.508 52.234 995.881 53.2851C997.263 54.3363 998.102 55.7189 998.395 57.4329H994.148C993.949 56.7606 993.551 56.2255 992.955 55.8278C992.368 55.43 991.671 55.2312 990.867 55.2312C989.465 55.2312 988.362 55.8609 987.557 57.1204C986.761 58.3704 986.387 60.0608 986.435 62.1916H986.69C987.154 61.2256 987.841 60.4822 988.75 59.9614C989.669 59.4311 990.725 59.1659 991.918 59.1659C993.859 59.1659 995.469 59.8099 996.747 61.0978C998.026 62.3857 998.665 64.0098 998.665 65.97C998.665 68.1008 997.931 69.848 996.463 71.2116C994.995 72.5753 993.116 73.2571 990.824 73.2571ZM988.139 68.6832C988.849 69.3839 989.73 69.7343 990.781 69.7343C991.832 69.7343 992.713 69.3887 993.423 68.6974C994.143 67.9966 994.503 67.1301 994.503 66.0979C994.503 65.0562 994.153 64.1944 993.452 63.5126C992.751 62.8213 991.866 62.4756 990.796 62.4756C989.725 62.4756 988.835 62.8166 988.125 63.4984C987.424 64.1802 987.074 65.0325 987.074 66.0553C987.074 67.097 987.429 67.9729 988.139 68.6832Z" fill-rule="evenodd"/>\n    <path d="M1018.18 57.6263V69.4317C1020.56 68.4318 1022.1 66.1059 1022.1 63.529C1022.1 60.9521 1020.56 58.6261 1018.18 57.6263Z" fill-opacity="0.4"/>\n  </g>\n</svg>',30,null)
D.c11=new B.tX("",'<svg viewBox="0 0 145 5">\n  <path d="M 2.5,0 H 142.5 A 2.5,2.5 0 0 1 145,2.5 V 2.5 A 2.5,2.5 0 0 1 142.5,5 H 2.5 A 2.5,2.5 0 0 1 0,2.5 V 2.5 A 2.5,2.5 0 0 1 2.5,0 Z" fill="currentColor"/>\n</svg>',"",16,8)
D.c15=new B.H_(D.c0Z,D.c11,C.aF)
D.bXK=new A.a1(402,874)
D.bhp=new A.K(0,62,0,34)
D.bhP=new A.K(62,0,62,20)
D.zc=new B.LN(0,"phone")
D.aoZ=new B.vo("apple-iphone-16-pro","iPhone 16 Pro","Apple",2024,C.aF,D.aoT,D.c15,D.bXK,3,D.bhp,D.bhP,335,208,D.zc)
D.ap5=new B.vp(C.il,D.aoZ,!0)
D.bXJ=new A.a1(384,796)
D.bQB=new A.y(12,8)
D.aoS=new B.vn(D.bXJ,D.bQB,"M 20,0 H 340 A 20,20 0 0 1 360,20 V 760 A 20,20 0 0 1 340,780 H 20 A 20,20 0 0 1 0,760 V 20 A 20,20 0 0 1 20,0 Z",'<svg viewBox="0 0 384 796">\n  <defs><clipPath id="shell">\n    <path d="M 32,0 H 352 A 28,28 0 0 1 380,28 V 768 A 28,28 0 0 1 352,796 H 32 A 28,28 0 0 1 4,768 V 28 A 28,28 0 0 1 32,0 Z"/>\n  </clipPath></defs>\n  <g fill="#3d4149">\n    <rect x="0" y="159.2" width="6" height="43.78" rx="2"/>\n    <rect x="0" y="214.92" width="6" height="43.78" rx="2"/>\n    <rect x="378" y="191.04" width="6" height="63.68" rx="2"/>\n  </g>\n  <path d="M 32,0 H 352 A 28,28 0 0 1 380,28 V 768 A 28,28 0 0 1 352,796 H 32 A 28,28 0 0 1 4,768 V 28 A 28,28 0 0 1 32,0 Z" fill="#1f2126"/>\n  <path d="M 32,2 H 352 A 26,26 0 0 1 378,28 V 768 A 26,26 0 0 1 352,794 H 32 A 26,26 0 0 1 6,768 V 28 A 26,26 0 0 1 32,2 Z" fill="#3d4149"/>\n  <g clip-path="url(#shell)">\n    <path d="M -796,0 L -477.6,0 L 96,796 L -222.4,796 Z" fill="#ffffff" fill-opacity="0.18"/>\n  </g>\n  <path d="M 32,3.5 H 352 A 24.5,24.5 0 0 1 376.5,28 V 768 A 24.5,24.5 0 0 1 352,792.5 H 32 A 24.5,24.5 0 0 1 7.5,768 V 28 A 24.5,24.5 0 0 1 32,3.5 Z" fill="#08090b"/>\n</svg>')
D.c1_=new B.tX('<svg viewBox="0 0 26.48 10.01">\n  <g transform="scale(0.31) translate(-118.17, -47.03)" fill="currentColor">\n    <path d="M129.206 79.3125C126.038 79.3125 123.439 78.446 121.408 76.7131C119.376 74.9801 118.297 72.75 118.169 70.0227H123.325C123.496 71.429 124.128 72.5653 125.222 73.4318C126.315 74.2983 127.658 74.7315 129.249 74.7315C131.053 74.7315 132.509 74.1776 133.616 73.0696C134.739 71.9474 135.3 70.4702 135.3 68.6378C135.3 66.8054 134.739 65.321 133.616 64.1847C132.509 63.0341 131.067 62.4588 129.291 62.4588C128.041 62.4588 126.926 62.7216 125.946 63.2472C124.98 63.7727 124.213 64.5185 123.645 65.4844H118.659L120.257 47.7997H138.773V52.4446H124.518L123.773 61.0739H124.135C125.555 59.1562 127.722 58.1974 130.634 58.1974C133.545 58.1974 135.932 59.1634 137.793 61.0952C139.668 63.027 140.605 65.4986 140.605 68.5099C140.605 71.7202 139.554 74.3267 137.452 76.3295C135.364 78.3182 132.615 79.3125 129.206 79.3125Z"/>\n    <path d="M149.862 75.2855C148.868 75.2855 148.051 74.9659 147.412 74.3267C146.773 73.6875 146.453 72.8849 146.453 71.919C146.453 70.9389 146.773 70.1364 147.412 69.5114C148.051 68.8722 148.868 68.5526 149.862 68.5526C150.871 68.5526 151.688 68.8722 152.313 69.5114C152.952 70.1364 153.271 70.9389 153.271 71.919C153.271 72.8849 152.952 73.6875 152.313 74.3267C151.688 74.9659 150.871 75.2855 149.862 75.2855ZM149.862 59.3054C148.868 59.3054 148.051 58.9929 147.412 58.3679C146.773 57.7287 146.453 56.9261 146.453 55.9602C146.453 54.9801 146.773 54.1776 147.412 53.5526C148.051 52.9134 148.868 52.5937 149.862 52.5937C150.871 52.5937 151.688 52.9134 152.313 53.5526C152.952 54.1776 153.271 54.9801 153.271 55.9602C153.271 56.9261 152.952 57.7287 152.313 58.3679C151.688 58.9929 150.871 59.3054 149.862 59.3054Z"/>\n    <path d="M167.195 78.5455V53.3395H166.833L159.183 58.7088V53.4247L167.216 47.7997H172.692V78.5455H167.195Z"/>\n    <path d="M188 64.9091V60.6477H191.75C193.313 60.6477 194.584 60.2216 195.564 59.3693C196.544 58.5028 197.034 57.3807 197.034 56.0028C197.034 54.6392 196.551 53.5526 195.586 52.7429C194.634 51.919 193.355 51.5071 191.75 51.5071C190.159 51.5071 188.867 51.9261 187.872 52.7642C186.892 53.6023 186.353 54.7457 186.253 56.1946H181.118C181.26 53.3679 182.297 51.1378 184.229 49.5043C186.161 47.8565 188.725 47.0327 191.921 47.0327C194.904 47.0327 197.382 47.8139 199.357 49.3764C201.346 50.9247 202.34 52.8778 202.34 55.2358C202.34 57.0398 201.836 58.581 200.827 59.8594C199.833 61.1378 198.483 61.9545 196.779 62.3097V62.6719C198.881 62.9134 200.536 63.7017 201.743 65.0369C202.965 66.3722 203.576 68.0625 203.576 70.108C203.576 72.75 202.468 74.9446 200.252 76.6918C198.05 78.4389 195.28 79.3125 191.942 79.3125C188.632 79.3125 185.934 78.4673 183.846 76.777C181.772 75.0866 180.664 72.8352 180.522 70.0227H185.784C185.898 71.4432 186.516 72.5795 187.638 73.4318C188.76 74.2699 190.209 74.6889 191.985 74.6889C193.746 74.6889 195.181 74.2344 196.289 73.3253C197.411 72.402 197.972 71.2159 197.972 69.767C197.972 68.2614 197.425 67.0753 196.331 66.2088C195.238 65.3423 193.746 64.9091 191.857 64.9091H188Z"/>\n  </g>\n</svg>',"",'<svg viewBox="0 0 63.16 11">\n  <g transform="translate(0, 0)">\n    <path d="M 7.79,10.63 L 0.55,3.85 A 10.54,10.54 0 0 1 15.03,3.85 Z" fill="currentColor"/>\n  </g>\n  <g transform="translate(20.58, 0)">\n    <path d="M 12.83,0 L 12.83,11 L 0,11 Z" fill="currentColor"/>\n  </g>\n  <g transform="translate(38.41, 0)">\n    <path d="M 3.12,0 H 18.88 A 3.12,3.12 0 0 1 22,3.12 V 7.88 A 3.12,3.12 0 0 1 18.88,11 H 3.12 A 3.12,3.12 0 0 1 0,7.88 V 3.12 A 3.12,3.12 0 0 1 3.12,0 Z M 3.3,1.28 H 18.7 A 2.02,2.02 0 0 1 20.72,3.3 V 7.7 A 2.02,2.02 0 0 1 18.7,9.72 H 3.3 A 2.02,2.02 0 0 1 1.28,7.7 V 3.3 A 2.02,2.02 0 0 1 3.3,1.28 Z" fill-rule="evenodd" fill="currentColor" fill-opacity="0.45"/>\n    <path d="M 3.12,1.83 H 13.75 A 1.28,1.28 0 0 1 15.03,3.12 V 7.88 A 1.28,1.28 0 0 1 13.75,9.17 H 3.12 A 1.28,1.28 0 0 1 1.83,7.88 V 3.12 A 1.28,1.28 0 0 1 3.12,1.83 Z" fill="currentColor"/>\n    <path d="M 22.55,3.67 L 22.55,7.33 A 1.47,1.47 0 0 0 22.55,3.67 Z" fill="currentColor" fill-opacity="0.45"/>\n  </g>\n</svg>',16,null)
D.c12=new B.tX("",'<svg viewBox="0 0 96 4">\n  <path d="M 2,0 H 94 A 2,2 0 0 1 96,2 V 2 A 2,2 0 0 1 94,4 H 2 A 2,2 0 0 1 0,2 V 2 A 2,2 0 0 1 2,0 Z" fill="currentColor"/>\n</svg>',"",16,9)
D.c13=new B.H_(D.c1_,D.c12,C.bA)
D.bXI=new A.a1(360,780)
D.aoY=new B.vo("samsung-galaxy-s25","Galaxy S25","Samsung",2025,C.bA,D.aoS,D.c13,D.bXI,3,C.mK,C.mK,336,252,D.zc)
D.ap2=new B.vp(C.mj,D.aoY,!0)
D.bXO=new A.a1(938,1298)
D.bQH=new A.y(59,59)
D.aoQ=new B.vn(D.bXO,D.bQH,"M 25.55,0 C 281.85,0 538.15,0 794.45,0 C 796.52,0 798.71,-0.01 800.29,0.04 C 802.03,0.09 803.72,0.21 805.4,0.53 C 808.83,1.19 812.01,2.69 814.66,5.34 C 817.31,7.99 818.81,11.17 819.46,14.6 C 819.79,16.28 819.91,17.97 819.96,19.71 C 820.01,21.29 820,23.48 820,25.55 L 820,1154.45 C 820,1156.52 820.01,1158.71 819.96,1160.29 C 819.91,1162.03 819.79,1163.72 819.46,1165.4 C 818.81,1168.83 817.31,1172.01 814.66,1174.66 C 812.01,1177.31 808.83,1178.81 805.4,1179.47 C 803.72,1179.79 802.03,1179.91 800.29,1179.96 C 798.71,1180.01 796.52,1180 794.45,1180 L 25.55,1180 C 23.47,1180 21.29,1180.01 19.71,1179.96 C 17.97,1179.91 16.28,1179.79 14.6,1179.47 C 11.17,1178.81 7.99,1177.31 5.34,1174.66 C 2.69,1172.01 1.19,1168.83 0.53,1165.4 C 0.21,1163.72 0.09,1162.03 0.04,1160.29 C -0.01,1158.71 0,1156.52 0,1154.45 L 0,25.55 C 0,23.48 -0.01,21.29 0.04,19.71 C 0.09,17.97 0.21,16.28 0.53,14.6 C 1.19,11.17 2.69,7.99 5.34,5.34 C 7.99,2.69 11.17,1.19 14.6,0.53 C 16.28,0.21 17.97,0.09 19.71,0.04 C 21.29,-0.01 23.48,0 25.55,0 Z",'<svg viewBox="0 0 938 1298">\n  <rect x="0" y="0" width="938" height="1298" rx="81" fill="#7e7e7e"/>\n  <rect x="1" y="1" width="936" height="1296" rx="80" fill="#2c2c2c"/>\n  <rect x="6" y="6" width="926" height="1286" rx="75" fill="#010101"/>\n</svg>')
D.c10=new B.tX('<svg viewBox="0 0 29.04 10.98">\n  <g transform="scale(0.34) translate(-118.17, -47.03)" fill="currentColor">\n    <path d="M129.206 79.3125C126.038 79.3125 123.439 78.446 121.408 76.7131C119.376 74.9801 118.297 72.75 118.169 70.0227H123.325C123.496 71.429 124.128 72.5653 125.222 73.4318C126.315 74.2983 127.658 74.7315 129.249 74.7315C131.053 74.7315 132.509 74.1776 133.616 73.0696C134.739 71.9474 135.3 70.4702 135.3 68.6378C135.3 66.8054 134.739 65.321 133.616 64.1847C132.509 63.0341 131.067 62.4588 129.291 62.4588C128.041 62.4588 126.926 62.7216 125.946 63.2472C124.98 63.7727 124.213 64.5185 123.645 65.4844H118.659L120.257 47.7997H138.773V52.4446H124.518L123.773 61.0739H124.135C125.555 59.1562 127.722 58.1974 130.634 58.1974C133.545 58.1974 135.932 59.1634 137.793 61.0952C139.668 63.027 140.605 65.4986 140.605 68.5099C140.605 71.7202 139.554 74.3267 137.452 76.3295C135.364 78.3182 132.615 79.3125 129.206 79.3125Z"/>\n    <path d="M149.862 75.2855C148.868 75.2855 148.051 74.9659 147.412 74.3267C146.773 73.6875 146.453 72.8849 146.453 71.919C146.453 70.9389 146.773 70.1364 147.412 69.5114C148.051 68.8722 148.868 68.5526 149.862 68.5526C150.871 68.5526 151.688 68.8722 152.313 69.5114C152.952 70.1364 153.271 70.9389 153.271 71.919C153.271 72.8849 152.952 73.6875 152.313 74.3267C151.688 74.9659 150.871 75.2855 149.862 75.2855ZM149.862 59.3054C148.868 59.3054 148.051 58.9929 147.412 58.3679C146.773 57.7287 146.453 56.9261 146.453 55.9602C146.453 54.9801 146.773 54.1776 147.412 53.5526C148.051 52.9134 148.868 52.5937 149.862 52.5937C150.871 52.5937 151.688 52.9134 152.313 53.5526C152.952 54.1776 153.271 54.9801 153.271 55.9602C153.271 56.9261 152.952 57.7287 152.313 58.3679C151.688 58.9929 150.871 59.3054 149.862 59.3054Z"/>\n    <path d="M167.195 78.5455V53.3395H166.833L159.183 58.7088V53.4247L167.216 47.7997H172.692V78.5455H167.195Z"/>\n    <path d="M188 64.9091V60.6477H191.75C193.313 60.6477 194.584 60.2216 195.564 59.3693C196.544 58.5028 197.034 57.3807 197.034 56.0028C197.034 54.6392 196.551 53.5526 195.586 52.7429C194.634 51.919 193.355 51.5071 191.75 51.5071C190.159 51.5071 188.867 51.9261 187.872 52.7642C186.892 53.6023 186.353 54.7457 186.253 56.1946H181.118C181.26 53.3679 182.297 51.1378 184.229 49.5043C186.161 47.8565 188.725 47.0327 191.921 47.0327C194.904 47.0327 197.382 47.8139 199.357 49.3764C201.346 50.9247 202.34 52.8778 202.34 55.2358C202.34 57.0398 201.836 58.581 200.827 59.8594C199.833 61.1378 198.483 61.9545 196.779 62.3097V62.6719C198.881 62.9134 200.536 63.7017 201.743 65.0369C202.965 66.3722 203.576 68.0625 203.576 70.108C203.576 72.75 202.468 74.9446 200.252 76.6918C198.05 78.4389 195.28 79.3125 191.942 79.3125C188.632 79.3125 185.934 78.4673 183.846 76.777C181.772 75.0866 180.664 72.8352 180.522 70.0227H185.784C185.898 71.4432 186.516 72.5795 187.638 73.4318C188.76 74.2699 190.209 74.6889 191.985 74.6889C193.746 74.6889 195.181 74.2344 196.289 73.3253C197.411 72.402 197.972 71.2159 197.972 69.767C197.972 68.2614 197.425 67.0753 196.331 66.2088C195.238 65.3423 193.746 64.9091 191.857 64.9091H188Z"/>\n  </g>\n</svg>',"",'<svg viewBox="0 0 66.61 12.86">\n  <g transform="scale(0.34) translate(-826.18, -43.64)" fill="currentColor">\n    <path d="M826.182 68.8112C826.182 67.2663 827.434 66.014 828.979 66.014H831.776C833.321 66.014 834.573 67.2663 834.573 68.8112V74.4056C834.573 75.9505 833.321 77.2028 831.776 77.2028H828.979C827.434 77.2028 826.182 75.9505 826.182 74.4056V68.8112Z"/>\n    <path d="M840.168 61.8182C840.168 60.2733 841.42 59.021 842.965 59.021H845.762C847.307 59.021 848.559 60.2733 848.559 61.8182V74.4056C848.559 75.9505 847.307 77.2028 845.762 77.2028H842.965C841.42 77.2028 840.168 75.9505 840.168 74.4056V61.8182Z"/>\n    <path d="M854.154 52.028C854.154 50.4831 855.406 49.2308 856.951 49.2308H859.748C861.293 49.2308 862.545 50.4831 862.545 52.028V74.4056C862.545 75.9505 861.293 77.2028 859.748 77.2028H856.951C855.406 77.2028 854.154 75.9505 854.154 74.4056V52.028Z"/>\n    <path d="M868.14 46.4336C868.14 44.8887 869.392 43.6364 870.937 43.6364H873.734C875.279 43.6364 876.531 44.8887 876.531 46.4336V74.4056C876.531 75.9505 875.279 77.2028 873.734 77.2028H870.937C869.392 77.2028 868.14 75.9505 868.14 74.4056V46.4336Z"/>\n    <path d="M913.959 50.8742C920.859 50.8745 927.494 53.5806 932.495 58.4331C932.871 58.8077 933.473 58.803 933.844 58.4225L937.443 54.7146C937.631 54.5216 937.736 54.2601 937.734 53.9882C937.733 53.7162 937.625 53.456 937.435 53.2653C924.311 40.4267 903.606 40.4267 890.482 53.2653C890.291 53.4559 890.184 53.7159 890.182 53.9879C890.18 54.2599 890.285 54.5214 890.472 54.7146L894.073 58.4225C894.443 58.8035 895.046 58.8083 895.422 58.4331C900.423 53.5802 907.059 50.8742 913.959 50.8742ZM914.059 62.0682C917.849 62.068 921.505 63.5062 924.315 66.1035C924.695 66.4721 925.294 66.4641 925.664 66.0855L929.259 62.3775C929.449 62.1831 929.554 61.9192 929.551 61.645C929.548 61.3709 929.438 61.1093 929.245 60.9187C920.688 52.794 907.436 52.794 898.88 60.9187C898.686 61.1093 898.576 61.371 898.573 61.6453C898.571 61.9195 898.676 62.1833 898.866 62.3775L902.46 66.0855C902.831 66.4641 903.429 66.4721 903.809 66.1035C906.618 63.5079 910.27 62.0698 914.059 62.0682ZM921.369 69.3055C921.375 69.5805 921.269 69.8455 921.077 70.0381L914.858 76.4444C914.675 76.6326 914.427 76.7386 914.168 76.7386C913.908 76.7386 913.66 76.6326 913.477 76.4444L907.257 70.0381C907.065 69.8454 906.96 69.5802 906.965 69.3053C906.971 69.0303 907.088 68.77 907.288 68.5857C911.259 65.1568 917.076 65.1568 921.048 68.5857C921.247 68.7701 921.364 69.0306 921.369 69.3055Z" fill-rule="evenodd"/>\n    <path d="M951.27 55.2766C951.27 48.8499 956.48 43.64 962.907 43.64H1003.63C1010.06 43.64 1015.27 48.8499 1015.27 55.2766V69.8224C1015.27 76.2491 1010.06 81.459 1003.63 81.459H962.907C956.48 81.459 951.27 76.2491 951.27 69.8224V55.2766Z M966.132 72.7316L974.868 56.0124V55.7568H964.527V52.2197H979.186V55.7994L970.621 72.7316H966.132Z M990.824 73.2571C989.337 73.2571 988.011 72.9399 986.847 72.3054C985.691 71.6709 984.763 70.7523 984.062 69.5497C982.917 67.7883 982.344 65.4823 982.344 62.6319C982.344 59.2322 983.101 56.5617 984.616 54.6204C986.132 52.679 988.224 51.7084 990.895 51.7084C992.846 51.7084 994.508 52.234 995.881 53.2851C997.263 54.3363 998.102 55.7189 998.395 57.4329H994.148C993.949 56.7606 993.551 56.2255 992.955 55.8278C992.368 55.43 991.671 55.2312 990.867 55.2312C989.465 55.2312 988.362 55.8609 987.557 57.1204C986.761 58.3704 986.387 60.0608 986.435 62.1916H986.69C987.154 61.2256 987.841 60.4822 988.75 59.9614C989.669 59.4311 990.725 59.1659 991.918 59.1659C993.859 59.1659 995.469 59.8099 996.747 61.0978C998.026 62.3857 998.665 64.0098 998.665 65.97C998.665 68.1008 997.931 69.848 996.463 71.2116C994.995 72.5753 993.116 73.2571 990.824 73.2571ZM988.139 68.6832C988.849 69.3839 989.73 69.7343 990.781 69.7343C991.832 69.7343 992.713 69.3887 993.423 68.6974C994.143 67.9966 994.503 67.1301 994.503 66.0979C994.503 65.0562 994.153 64.1944 993.452 63.5126C992.751 62.8213 991.866 62.4756 990.796 62.4756C989.725 62.4756 988.835 62.8166 988.125 63.4984C987.424 64.1802 987.074 65.0325 987.074 66.0553C987.074 67.097 987.429 67.9729 988.139 68.6832Z" fill-rule="evenodd" fill-opacity="0.4"/>\n    <path d="M951.27 55.2766C951.27 48.8499 956.48 43.64 962.907 43.64H997.816V81.459H962.907C956.48 81.459 951.27 76.2491 951.27 69.8224V55.2766Z M966.132 72.7316L974.868 56.0124V55.7568H964.527V52.2197H979.186V55.7994L970.621 72.7316H966.132Z M990.824 73.2571C989.337 73.2571 988.011 72.9399 986.847 72.3054C985.691 71.6709 984.763 70.7523 984.062 69.5497C982.917 67.7883 982.344 65.4823 982.344 62.6319C982.344 59.2322 983.101 56.5617 984.616 54.6204C986.132 52.679 988.224 51.7084 990.895 51.7084C992.846 51.7084 994.508 52.234 995.881 53.2851C997.263 54.3363 998.102 55.7189 998.395 57.4329H994.148C993.949 56.7606 993.551 56.2255 992.955 55.8278C992.368 55.43 991.671 55.2312 990.867 55.2312C989.465 55.2312 988.362 55.8609 987.557 57.1204C986.761 58.3704 986.387 60.0608 986.435 62.1916H986.69C987.154 61.2256 987.841 60.4822 988.75 59.9614C989.669 59.4311 990.725 59.1659 991.918 59.1659C993.859 59.1659 995.469 59.8099 996.747 61.0978C998.026 62.3857 998.665 64.0098 998.665 65.97C998.665 68.1008 997.931 69.848 996.463 71.2116C994.995 72.5753 993.116 73.2571 990.824 73.2571ZM988.139 68.6832C988.849 69.3839 989.73 69.7343 990.781 69.7343C991.832 69.7343 992.713 69.3887 993.423 68.6974C994.143 67.9966 994.503 67.1301 994.503 66.0979C994.503 65.0562 994.153 64.1944 993.452 63.5126C992.751 62.8213 991.866 62.4756 990.796 62.4756C989.725 62.4756 988.835 62.8166 988.125 63.4984C987.424 64.1802 987.074 65.0325 987.074 66.0553C987.074 67.097 987.429 67.9729 988.139 68.6832Z" fill-rule="evenodd"/>\n    <path d="M1018.18 57.6263V69.4317C1020.56 68.4318 1022.1 66.1059 1022.1 63.529C1022.1 60.9521 1020.56 58.6261 1018.18 57.6263Z" fill-opacity="0.4"/>\n  </g>\n</svg>',42,null)
D.c0Y=new B.tX("",'<svg viewBox="0 0 320 5">\n  <path d="M 2.5,0 H 317.5 A 2.5,2.5 0 0 1 320,2.5 V 2.5 A 2.5,2.5 0 0 1 317.5,5 H 2.5 A 2.5,2.5 0 0 1 0,2.5 V 2.5 A 2.5,2.5 0 0 1 2.5,0 Z" fill="currentColor"/>\n</svg>',"",16,8)
D.c14=new B.H_(D.c10,D.c0Y,C.aF)
D.bXN=new A.a1(820,1180)
D.De=new A.K(0,32,0,25)
D.aoX=new B.LN(1,"tablet")
D.ap1=new B.vo("apple-ipad-air-11-m4",'iPad Air 11" (M4)',"Apple",2026,C.aF,D.aoQ,D.c14,D.bXN,2,D.De,D.De,337,422,D.aoX)
D.ap6=new B.vp(C.z9,D.ap1,!0)
D.bXH=new A.a1(1922,1109)
D.bQD=new A.y(1,28)
D.aoU=new B.vn(D.bXH,D.bQD,"M 0,0 H 1920 V 1068 A 12,12 0 0 1 1908,1080 H 12 A 12,12 0 0 1 0,1068 Z",'<svg viewBox="0 0 1922 1109">\n  <path d="M 12,0 H 1910 A 12,12 0 0 1 1922,12 V 1097 A 12,12 0 0 1 1910,1109 H 12 A 12,12 0 0 1 0,1097 V 12 A 12,12 0 0 1 12,0 Z" fill="#26282c"/>\n  <circle cx="16" cy="14" r="6" fill="#ff5f57"/>\n  <circle cx="36" cy="14" r="6" fill="#febc2e"/>\n  <circle cx="56" cy="14" r="6" fill="#28c840"/>\n  <rect x="891" y="9" width="140" height="10" rx="5" fill="#c9ccd1" fill-opacity="0.35"/>\n</svg>')
D.bXG=new A.a1(1920,1080)
D.zd=new B.LN(3,"desktop")
D.ap0=new B.vo("desktop-large","Large Desktop Window","Generic",null,C.fF,D.aoU,null,D.bXG,2,C.Q,null,null,null,D.zd)
D.ap4=new B.vp(C.k9,D.ap0,!1)
D.bXE=new A.a1(1026,673)
D.bQE=new A.y(1,32)
D.aoR=new B.vn(D.bXE,D.bQE,"M 0,0 H 1024 V 632 A 8,8 0 0 1 1016,640 H 8 A 8,8 0 0 1 0,632 Z",'<svg viewBox="0 0 1026 673">\n  <path d="M 8,0 H 1018 A 8,8 0 0 1 1026,8 V 665 A 8,8 0 0 1 1018,673 H 8 A 8,8 0 0 1 0,665 V 8 A 8,8 0 0 1 8,0 Z" fill="#202226"/>\n  <rect x="980" y="15" width="10" height="2" fill="#c9ccd1"/>\n  <rect x="994" y="15" width="10" height="2" fill="#c9ccd1"/>\n  <rect x="1008" y="15" width="10" height="2" fill="#c9ccd1"/>\n  <rect x="443" y="11" width="140" height="10" rx="5" fill="#c9ccd1" fill-opacity="0.35"/>\n</svg>')
D.bXD=new A.a1(1024,640)
D.ap_=new B.vo("desktop-small","Small Desktop Window","Generic",null,C.vw,D.aoR,null,D.bXD,1,C.Q,null,null,null,D.zd)
D.ap3=new B.vp(C.za,D.ap_,!1)
D.kH=x([D.ap5,D.ap2,D.ap6,D.ap4,D.ap3],A.e("f<vp>"))
D.bQ9={black:0,white:1,gray:2,grey:3,silver:4,red:5,green:6,blue:7,yellow:8,orange:9,navy:10}
D.xK=new A.ad(1,0.5019607843137255,0.5019607843137255,0.5019607843137255,C.L)
D.a3a=new A.ad(1,0.7529411764705882,0.7529411764705882,0.7529411764705882,C.L)
D.a3_=new A.ad(1,0,0.5019607843137255,0,C.L)
D.a3o=new A.ad(1,1,0.6470588235294118,0,C.L)
D.a3R=new A.ad(1,0,0,0.5019607843137255,C.L)
D.bOi=new A.bB(D.bQ9,[C.cl,C.aM,D.xK,D.xK,D.a3a,E.pG,D.a3_,E.xI,E.xL,D.a3o,D.a3R],A.e("bB<q,ad>"))
D.bP6=new A.F6(C.ac,1,C.ps,C.bU,C.Q,C.Q,C.Q,C.Q,!1,!1,!1,!1,!1,!1,!1,!1,C.kW,C.zb,C.tB,!1,null,null,null,null,null)
D.bQv={g:0,a:1,svg:2,switch:3}
D.bW0=new A.fd(D.bQv,4,y.M)
D.bQ1={defs:0,clipPath:1,mask:2,title:3,desc:4,metadata:5,style:6,symbol:7,linearGradient:8,radialGradient:9,filter:10}
D.bWc=new A.fd(D.bQ1,11,y.M)})();(function lazyInitializers(){var x=a.lazyFinal
x($,"cgK","bNk",()=>A.a9("[-+]?(\\d*\\.\\d+|\\d+\\.?)([eE][-+]?\\d+)?",!0,!1,!1,!1))
x($,"chj","bNH",()=>A.a9("url\\(\\s*#([^)\\s]+)\\s*\\)",!0,!1,!1,!1))
x($,"cgP","bNl",()=>A.a9("rgba?\\(([^)]*)\\)",!0,!1,!1,!1))
x($,"chh","bNF",()=>A.a9("(\\w+)\\s*\\(([^)]*)\\)",!0,!1,!1,!1))
x($,"cfU","bMM",()=>A.a9("&([a-zA-Z]+|#[xX]?[0-9a-fA-F]+);",!0,!1,!1,!1))})()};
(a=>{a["WcMh5aKTfhb/QGOmGCKAcQbCgrk="]=a.current})($__dart_deferred_initializers__);