((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,C,H,K,I,F,E,G,L,B={
cJv(d){var x,w,v,u,t,s,r=A.a([],y.S),q=A.bT(d,"\r\n","\n").split("\n"),p=q.length!==0&&C.d.ar(C.b.gV(q))==="WEBVTT"?1:0,o=A.ab("(?:(\\d+):)?([0-5]?\\d):([0-5]\\d)[.,](\\d{3})\\s*-->\\s*(?:(\\d+):)?([0-5]?\\d):([0-5]\\d)[.,](\\d{3})",!0,!1,!1,!1),n=new B.bWy()
while(p<q.length){x=C.d.ar(q[p]);++p
if(x.length===0)continue
w=o.h9(x)
if(w==null)continue
v=n.$5(w,1,2,3,4)
v.toString
u=n.$5(w,5,6,7,8)
u.toString
t=q.length
s=""
for(;;){if(!(p<t&&C.d.ar(q[p]).length!==0))break
if(s.length!==0)s+="\n"
s+=C.d.ar(q[p]);++p}if(s.length!==0)r.push(new F.F_(v,u,s.charCodeAt(0)==0?s:s))}return r},
czw(d){return D.cs5},
bWy:function bWy(){},
a1B:function a1B(d){this.a=d},
a1D:function a1D(){var _=this
_.d=0
_.f=_.e=null
_.w=_.r=!1
_.c=_.a=_.x=null},
bus:function bus(){},
but:function but(){},
bul:function bul(d,e,f){this.a=d
this.b=e
this.c=f},
bum:function bum(d,e){this.a=d
this.b=e},
bun:function bun(d){this.a=d},
buo:function buo(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},
bup:function bup(d,e,f){this.a=d
this.b=e
this.c=f},
bur:function bur(d){this.a=d},
buq:function buq(){},
azM:function azM(d,e,f){this.c=d
this.d=e
this.a=f},
bFL:function bFL(d,e){this.a=d
this.b=e},
Ux:function Ux(d,e,f){var _=this
_.r=d
_.w=1
_.x=!1
_.y=null
_.z=!1
_.Q=e
_.id$=0
_.k1$=f
_.k3$=_.k2$=0},
Vq:function Vq(d,e,f,g,h){var _=this
_.F=d
_.W=null
_.a0=e
_.H$=f
_.dy=g
_.b=_.fy=null
_.c=0
_.y=_.d=null
_.z=!0
_.Q=null
_.as=!1
_.at=null
_.ay=$
_.ch=h
_.CW=!1
_.cx=$
_.cy=!0
_.db=!1
_.dx=$},
b0K:function b0K(d){this.a=d},
axf:function axf(){},
ahO:function ahO(d,e,f){this.e=d
this.c=e
this.a=f},
a8J:function a8J(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},
rh(){var x=$.cgB()
if($.ccf!==x){x.Lo()
$.ccf=x}return x},
caq(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s){return new B.LZ(g,o,e,f,d,m,!1,i,s,n,h,j,!0,r,q,k)},
LZ:function LZ(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s){var _=this
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
_.z=n
_.Q=o
_.as=p
_.at=q
_.ax=r
_.ay=s},
aly:function aly(d,e,f){var _=this
_.w=d
_.CW=_.ch=_.ay=null
_.cx=!1
_.dx=_.db=_.cy=null
_.dy=-1
_.a=e
_.id$=0
_.k1$=f
_.k3$=_.k2$=0},
b9A:function b9A(d,e){this.a=d
this.b=e},
b9B:function b9B(d){this.a=d},
b9z:function b9z(d,e){this.a=d
this.b=e},
b9y:function b9y(d){this.a=d},
aC1:function aC1(d){this.a=!1
this.b=d},
Y2:function Y2(d,e){this.c=d
this.a=e},
a61:function a61(){this.d=$
this.c=this.a=null},
bLa:function bLa(d,e){this.a=d
this.b=e},
aC3:function aC3(d,e,f){this.c=d
this.d=e
this.a=f},
aDz:function aDz(){},
aLc:function aLc(d,e,f,g){var _=this
_.a=d
_.b=e
_.e=f
_.f=g},
bZY(){var x=0,w=A.M(y.y),v,u=2,t=[],s,r,q,p,o,n,m,l,k
var $async$bZY=A.H(function(d,e){if(d===1){t.push(e)
x=u}for(;;)switch(x){case 0:u=4
s=b.G.window.navigator.mediaDevices
x=7
return A.D(A.hW(s.getUserMedia({video:!0}),y.m),$async$bZY)
case 7:r=e
q=A.hm(r)
p=!1
try{p=q.getVideoTracks().length>0
o=q.getTracks()
for(n=0;n<o.length;++n)o[n].stop()}catch(j){p=!0}l=p
v=l
x=1
break
u=2
x=6
break
case 4:u=3
k=t.pop()
v=!1
x=1
break
x=6
break
case 3:x=2
break
case 6:case 1:return A.K(v,w)
case 2:return A.J(t.at(-1),w)}})
return A.L($async$bZY,w)}},D,M
A=c[0]
C=c[2]
H=c[225]
K=c[247]
I=c[244]
F=c[189]
E=c[250]
G=c[245]
L=c[246]
B=a.updateHolder(c[140],B)
D=c[103]
M=c[242]
B.a1B.prototype={
q(){return new B.a1D()}}
B.a1D.prototype={
a9(){this.af()
this.o2(0)},
l(){var x=this.f
if(x!=null)x.l()
x=this.e
if(x!=null)x.l().cn(new B.bus(),new B.but(),y.P)
this.O()},
o2(d){return this.aIL(d)},
aIL(a2){var x=0,w=A.M(y.H),v,u=2,t=[],s=this,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,a0,a1
var $async$o2=A.H(function(a3,a4){if(a3===1){t.push(a4)
x=u}for(;;)switch(x){case 0:h=E.wN[a2]
g=s.e
f=s.f
if(f!=null)f.l()
if(s.c!=null)s.n(new B.bul(s,a2,h))
x=h.e?3:4
break
case 3:x=5
return A.D(B.bZY(),$async$o2)
case 5:o=a4
if(s.c==null){x=1
break}s.n(new B.bum(s,o))
u=7
n=g
n=n==null?null:n.l()
x=10
return A.D(y.x.b(n)?n:A.cO(n,y.H),$async$o2)
case 10:u=2
x=9
break
case 7:u=6
e=t.pop()
x=9
break
case 6:x=2
break
case 9:x=1
break
case 4:l=h.c
x=l==null?11:12
break
case 11:if(s.c==null){x=1
break}s.n(new B.bun(s))
u=14
n=g
n=n==null?null:n.l()
x=17
return A.D(y.x.b(n)?n:A.cO(n,y.H),$async$o2)
case 17:u=2
x=16
break
case 14:u=13
d=t.pop()
x=16
break
case 13:x=2
break
case 16:x=1
break
case 12:n=A.cq(l,0,null).m(0)
k=B.caq(D.Kf,D.t1,C.C,C.C,null,!1,!1,!1,!1,!1,1,C.C,!0,0,C.ag,1)
j=$.a3()
r=new B.aly(n,k,j)
k=r
i=new B.Ux(k,E.Kg,j)
k.a1(i.ga47())
q=i
k=q
j=h.d
k.x=j
k.y=h.b
k.a_()
k=q
k.Q=B.cJv("WEBVTT\n\n00:00.000 --> 00:05.000\nHello, world\n\n00:05.000 --> 00:12.000\nButterfly wings at 24 frames\n")
k.a_()
x=j?18:20
break
case 18:x=21
return A.D(q.on(!1),$async$o2)
case 21:x=19
break
case 20:x=22
return A.D(q.on(!0),$async$o2)
case 22:case 19:u=24
x=27
return A.D(r.hb(),$async$o2)
case 27:u=2
x=26
break
case 24:u=23
a0=t.pop()
p=A.aK(a0)
x=s.c==null?28:29
break
case 28:q.l()
x=30
return A.D(r.l(),$async$o2)
case 30:x=1
break
case 29:s.n(new B.buo(s,r,q,p))
u=32
n=g
n=n==null?null:n.l()
x=35
return A.D(y.x.b(n)?n:A.cO(n,y.H),$async$o2)
case 35:u=23
x=34
break
case 32:u=31
a1=t.pop()
x=34
break
case 31:x=23
break
case 34:x=1
break
x=26
break
case 23:x=2
break
case 26:x=s.c==null?36:37
break
case 36:q.l()
x=38
return A.D(r.l(),$async$o2)
case 38:x=1
break
case 37:s.n(new B.bup(s,r,q))
n=g
n=n==null?null:n.l()
x=39
return A.D(y.x.b(n)?n:A.cO(n,y.H),$async$o2)
case 39:case 1:return A.K(v,w)
case 2:return A.J(t.at(-1),w)}})
return A.L($async$o2,w)},
k(d){return A.bG(new B.bur(this))},
aPJ(d){var x,w,v,u,t,s=this,r=null,q=E.wN[s.d]
if(q.e){x=A.a5(18)
w=A.aO(G.lH,C.w,1)
if(!s.w)v=C.ac
else v=s.r?D.a4T:D.a4V
return new H.uK(1.7777777777777777,A.af(C.D,v,C.n,r,r,new A.V(I.ij,r,w,x,r,r,r,C.o),r,r,r,r,r,r,r,r),r)}u=s.f
t=s.e
if(u==null||t==null){x=A.a5(18)
w=A.aO(G.lH,C.w,1)
v=s.x
v=v==null?D.byo:A.d("Playback failed: "+A.F(v),r,r,r,r,r,r,r,r,D.WR,C.a2,r,r,r)
return new H.uK(1.7777777777777777,A.af(C.D,v,C.n,r,r,new A.V(C.c_,r,w,x,r,r,r,C.o),r,r,r,r,r,r,r,r),r)}return F.Ag(new B.Y2(u.r,r),u,r,r,new B.buq(),r,q.b,r,q.a)}}
B.azM.prototype={
k(d){var x,w,v,u,t,s,r,q=null,p=A.a([],y.p)
for(x=this.c,w=0;w<3;++w){v=x===w
u=v?I.ij:C.aJ
t=new A.b9(999,999)
s=new A.d4(G.lH,1,C.w,-1)
r=E.wN[w]
v=v?C.aA:L.B2
p.push(A.cm(C.aw,A.af(q,new A.a4(r.a,q,new A.bl(!0,v,q,q,q,q,12,C.R,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q),q,q,q,q,q,q,q,q,q,q,q,q,q),C.n,q,q,new A.V(u,q,new A.cG(s,s,s,s),new A.db(t,t,t,t),q,q,q,C.o),q,q,q,K.p2,C.iy,q,q,q),!1,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,new B.bFL(this,w),q,q,q,q,q,q,q,q,q,q,q,!1,C.af))}return A.bd(C.be,p,C.a8,q,C.v,8,0)}}
B.Ux.prototype={
az5(){return this.a_()},
gaes(){return this.Q},
gri(){return this.z},
on(d){return this.al0(d)},
al0(d){var x=0,w=A.M(y.H),v=this
var $async$on=A.H(function(e,f){if(e===1)return A.J(f,w)
for(;;)switch(x){case 0:v.z=d
v.a_()
return A.K(null,w)}})
return A.L($async$on,w)},
gAu(){return this.x},
gaV(){return this.r.a.b},
gef(){return this.r.a.a},
gx9(){var x=this.r.a.e
if(x.length===0)return C.C
return C.b.gaq(x).b},
gul(){return this.r.a.x},
gnl(){return this.r.a.x<=0},
gpQ(){return this.r.a.y},
gfJ(){return this.r.a.f},
gxR(){return this.r.a.w},
gKN(){var x=this.r.a.z
return x!=null?x:null},
c6(){return this.r.c6()},
bR(){return this.r.bR()},
eI(d){return this.r.eI(d)},
bI(d){if(d>0)this.w=d
return this.r.bI(d)},
p5(d){var x=d?0:this.w
return this.r.bI(x)},
ny(d){return this.r.ny(d)},
l(){var x=this.r
if(!x.cx)x.yC(this.ga47())
this.bx()}}
B.Vq.prototype={
sb20(d){if(this.F===d)return
this.F=d
this.a7()},
be(d){var x=this.H$
if(x==null)return 0
return(this.F&1)===1?x.am(C.cG,d,x.gbH()):x.am(C.cm,d,x.gbA())},
b6(d){var x=this.H$
if(x==null)return 0
return(this.F&1)===1?x.am(C.bE,d,x.gbr()):x.am(C.bm,d,x.gbh())},
bd(d){var x=this.H$
if(x==null)return 0
return(this.F&1)===1?x.am(C.cm,d,x.gbA()):x.am(C.cG,d,x.gbH())},
bc(d){var x=this.H$
if(x==null)return 0
return(this.F&1)===1?x.am(C.bm,d,x.gbh()):x.am(C.bE,d,x.gbr())},
c8(d){var x,w,v=this.H$
if(v==null)return new A.a8(A.a7(0,d.a,d.b),A.a7(0,d.c,d.d))
x=(this.F&1)===1?d.gKY():d
w=v.am(C.aO,x,v.gcp())
return(this.F&1)===1?new A.a8(w.b,w.a):w},
bn(){var x,w,v=this
v.W=null
x=v.H$
if(x!=null){w=y.k
x.bQ((v.F&1)===1?w.a(A.Y.prototype.ga4.call(v)).gKY():w.a(A.Y.prototype.ga4.call(v)),!0)
x=v.F
w=v.H$
v.fy=(x&1)===1?new A.a8(w.gD().b,v.H$.gD().a):w.gD()
w=A.eu()
w.dT(v.gD().a/2,v.gD().b/2,0,1)
w.yg(1.5707963267948966*C.i.Z(v.F,4))
w.dT(-v.H$.gD().a/2,-v.H$.gD().b/2,0,1)
v.W=w}else{x=y.k.a(A.Y.prototype.ga4.call(v))
v.fy=new A.a8(A.a7(0,x.a,x.b),A.a7(0,x.c,x.d))}},
ea(d,e){var x=this
if(x.H$==null||x.W==null)return!1
return d.x4(new B.b0K(x),e,x.W)},
aJ7(d,e){var x=this.H$
x.toString
d.f6(x,e)},
av(d,e){var x,w,v=this,u=v.a0
if(v.H$!=null){x=v.cx
x===$&&A.f()
w=v.W
w.toString
u.saQ(d.AV(x,e,w,v.gaJ6(),u.a))}else u.saQ(null)},
l(){this.a0.saQ(null)
this.iA()},
fl(d,e){var x=this.W
if(x!=null)e.ek(x)
this.a_Y(d,e)}}
B.axf.prototype={
aA(d){var x
this.f8(d)
x=this.H$
if(x!=null)x.aA(d)},
ap(){this.f_()
var x=this.H$
if(x!=null)x.ap()}}
B.ahO.prototype={
aN(d){var x=new B.Vq(this.e,A.b2(),null,new A.bL(),A.b2())
x.aL()
x.sb3(null)
return x},
aR(d,e){e.sb20(this.e)}}
B.a8J.prototype={
m(d){var x=this
return"Caption(number: "+x.a+", start: "+x.b.m(0)+", end: "+x.c.m(0)+", text: "+x.d+")"},
h(d,e){var x,w,v=this
if(e==null)return!1
if(v!==e){x=!1
if(e instanceof B.a8J)if(A.ai(v)===A.ai(e))if(v.a===e.a){w=e.b
if(v.b.a===w.a){x=e.c
x=v.c.a===x.a&&v.d===e.d}}}else x=!0
return x},
gt(d){var x=this
return A.X(x.a,x.b,x.c,x.d,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a)}}
B.LZ.prototype={
tA(d,e,f,g,h,i,j,k,a0,a1,a2,a3,a4){var x=this,w=f==null?x.a:f,v=a3==null?x.at:a3,u=a1==null?x.b:a1,t=e==null?x.c:e,s=d==null?x.e:d,r=j==null?x.ay:j,q=k==null?x.f:k,p=h==null?x.w:h,o=a4==null?x.x:a4,n=a0==null?x.y:a0,m=g!=="defaultErrorDescription"?g:x.z,l=i==null?x.Q:i
return B.caq(s,t,x.d,w,m,p,l,r,!1,q,n,u,!0,x.ax,v,o)},
aWf(d,e,f,g,h,i){var x=null
return this.tA(x,x,d,e,x,f,g,x,x,x,h,i,x)},
aVk(d){var x=null
return this.tA(x,x,x,"defaultErrorDescription",x,d,x,x,x,x,x,x,x)},
aV9(d){var x=null
return this.tA(d,x,x,"defaultErrorDescription",x,x,x,x,x,x,x,x,x)},
ae2(d){var x=null
return this.tA(x,x,x,"defaultErrorDescription",d,x,x,x,x,x,x,x,x)},
aW1(d,e){var x=null
return this.tA(x,x,x,"defaultErrorDescription",x,d,x,e,x,x,x,x,x)},
UO(d){var x=null
return this.tA(x,x,x,"defaultErrorDescription",x,x,x,d,x,x,x,x,x)},
aW8(d,e,f){var x=null
return this.tA(x,d,x,"defaultErrorDescription",x,e,x,x,x,f,x,x,x)},
aVX(d){var x=null
return this.tA(x,x,x,"defaultErrorDescription",x,x,x,x,x,x,x,x,d)},
aVI(d){var x=null
return this.tA(x,x,x,"defaultErrorDescription",x,x,x,x,d,x,x,x,x)},
m(d){var x=this
return"VideoPlayerValue(duration: "+x.a.m(0)+", size: "+x.at.m(0)+", position: "+x.b.m(0)+", caption: "+x.c.m(0)+", captionOffset: "+x.d.m(0)+", buffered: ["+C.b.aT(x.e,", ")+"], isInitialized: "+x.ay+", isPlaying: "+x.f+", isLooping: false, isBuffering: "+x.w+", volume: "+A.F(x.x)+", playbackSpeed: "+A.F(x.y)+", errorDescription: "+A.F(x.z)+", isCompleted: "+x.Q+", preventsDisplaySleepDuringVideoPlayback: true),"},
h(d,e){var x,w,v=this
if(e==null)return!1
if(v!==e){x=!1
if(e instanceof B.LZ)if(A.ai(v)===A.ai(e)){w=e.a
if(v.a.a===w.a){w=e.b
if(v.b.a===w.a)if(v.c.h(0,e.c)){w=e.d
if(v.d.a===w.a)if(A.cN(v.e,e.e))if(v.f===e.f)if(v.w===e.w)if(v.x===e.x)if(v.y===e.y)if(v.z==e.z)if(v.at.h(0,e.at))if(v.ax===e.ax)if(v.ay===e.ay)x=v.Q===e.Q}}}}else x=!0
return x},
gt(d){var x=this
return A.X(x.a,x.b,x.c,x.d,x.e,x.f,!1,x.w,x.x,x.y,x.z,x.at,x.ax,x.ay,x.Q,!0,C.a,C.a,C.a,C.a)}}
B.aly.prototype={
hb(){var x=0,w=A.M(y.H),v,u=this,t,s,r,q,p
var $async$hb=A.H(function(d,e){if(d===1)return A.J(e,w)
for(;;)switch(x){case 0:u.dx=new B.aC1(u)
t=u.dx
if(t!=null)$.ar.b1$.push(t)
t=y.D
s=y.h
u.cy=new A.c_(new A.aR($.aT,t),s)
switch(1){case 1:r=new B.aLc(C.anQ,u.w,null,null)
break}x=3
return A.D(B.rh().Eb(new A.alw(r)),$async$hb)
case 3:q=e
u.dy=q==null?-1:q
u.cy.f1(null)
t=new A.aR($.aT,t)
p=new A.c_(t,s)
s=B.rh()
q=u.dy
u.a.toString
x=4
return A.D(s.Ny(q,!0),$async$hb)
case 4:u.db=B.rh().aj8(u.dy).LO(new B.b9A(u,p),new B.b9z(u,p))
v=t
x=1
break
case 1:return A.K(v,w)}})
return A.L($async$hb,w)},
l(){var x=0,w=A.M(y.H),v,u=this,t
var $async$l=A.H(function(d,e){if(d===1)return A.J(e,w)
for(;;)switch(x){case 0:if(u.cx){x=1
break}t=u.cy
x=t!=null?3:4
break
case 3:x=5
return A.D(t.a,$async$l)
case 5:x=!u.cx?6:7
break
case 6:u.cx=!0
t=u.CW
if(t!=null)t.ah()
t=u.db
t=t==null?null:t.ah()
x=8
return A.D(y.x.b(t)?t:A.cO(t,y.H),$async$l)
case 8:x=9
return A.D(B.rh().hG(u.dy),$async$l)
case 9:case 7:t=u.dx
if(t!=null)$.ar.nT(t)
case 4:u.cx=!0
u.bx()
case 1:return A.K(v,w)}})
return A.L($async$l,w)},
c6(){var x=0,w=A.M(y.H),v=this,u,t
var $async$c6=A.H(function(d,e){if(d===1)return A.J(e,w)
for(;;)switch(x){case 0:u=v.a
t=u.b
u=u.a
x=t.a===u.a?2:3
break
case 2:x=4
return A.D(v.eI(C.C),$async$c6)
case 4:case 3:v.sA(v.a.UO(!0))
x=5
return A.D(v.ux(),$async$c6)
case 5:return A.K(null,w)}})
return A.L($async$c6,w)},
bR(){var x=0,w=A.M(y.H),v=this
var $async$bR=A.H(function(d,e){if(d===1)return A.J(e,w)
for(;;)switch(x){case 0:v.sA(v.a.UO(!1))
x=2
return A.D(v.ux(),$async$bR)
case 2:return A.K(null,w)}})
return A.L($async$bR,w)},
GF(){var x=0,w=A.M(y.H),v,u=this,t,s
var $async$GF=A.H(function(d,e){if(d===1)return A.J(e,w)
for(;;)switch(x){case 0:if(u.cx||!u.a.ay){x=1
break}t=B.rh()
s=u.dy
u.a.toString
x=3
return A.D(t.G6(s,!1),$async$GF)
case 3:case 1:return A.K(v,w)}})
return A.L($async$GF,w)},
ux(){var x=0,w=A.M(y.H),v,u=this,t
var $async$ux=A.H(function(d,e){if(d===1)return A.J(e,w)
for(;;)switch(x){case 0:if(u.cx||!u.a.ay){x=1
break}x=u.a.f?3:5
break
case 3:x=6
return A.D(B.rh().mz(u.dy),$async$ux)
case 6:t=u.CW
if(t!=null)t.ah()
u.CW=A.A6(C.bK,new B.b9y(u))
x=7
return A.D(u.BU(),$async$ux)
case 7:x=4
break
case 5:t=u.CW
if(t!=null)t.ah()
x=8
return A.D(B.rh().fD(u.dy),$async$ux)
case 8:case 4:case 1:return A.K(v,w)}})
return A.L($async$ux,w)},
BV(){var x=0,w=A.M(y.H),v,u=this
var $async$BV=A.H(function(d,e){if(d===1)return A.J(e,w)
for(;;)switch(x){case 0:if(u.cx||!u.a.ay){x=1
break}x=3
return A.D(B.rh().Ge(u.dy,u.a.x),$async$BV)
case 3:case 1:return A.K(v,w)}})
return A.L($async$BV,w)},
BU(){var x=0,w=A.M(y.H),v,u=this
var $async$BU=A.H(function(d,e){if(d===1)return A.J(e,w)
for(;;)switch(x){case 0:if(u.cx||!u.a.ay){x=1
break}if(!u.a.f){x=1
break}x=3
return A.D(B.rh().G8(u.dy,u.a.y),$async$BU)
case 3:case 1:return A.K(v,w)}})
return A.L($async$BU,w)},
gaV(){var x=0,w=A.M(y.O),v,u=this
var $async$gaV=A.H(function(d,e){if(d===1)return A.J(e,w)
for(;;)switch(x){case 0:if(u.cx){v=null
x=1
break}v=B.rh().FO(u.dy)
x=1
break
case 1:return A.K(v,w)}})
return A.L($async$gaV,w)},
eI(d){return this.akF(d)},
akF(d){var x=0,w=A.M(y.H),v,u=this,t,s
var $async$eI=A.H(function(e,f){if(e===1)return A.J(f,w)
for(;;)switch(x){case 0:if(u.cx||!u.a.ay){x=1
break}t=u.a.a
s=d.a
if(s>t.a)d=t
else if(s<0)d=C.C
x=3
return A.D(B.rh().FZ(u.dy,d),$async$eI)
case 3:u.acj(d)
case 1:return A.K(v,w)}})
return A.L($async$eI,w)},
bI(d){return this.ami(d)},
ami(d){var x=0,w=A.M(y.H),v=this
var $async$bI=A.H(function(e,f){if(e===1)return A.J(f,w)
for(;;)switch(x){case 0:v.sA(v.a.aVX(C.f.v(d,0,1)))
x=2
return A.D(v.BV(),$async$bI)
case 2:return A.K(null,w)}})
return A.L($async$bI,w)},
ny(d){return this.alD(d)},
alD(d){var x=0,w=A.M(y.H),v=this
var $async$ny=A.H(function(e,f){if(e===1)return A.J(f,w)
for(;;)switch(x){case 0:if(d<0)throw A.x(A.f7(d,"Negative playback speeds are generally unsupported.",null))
else if(d===0)throw A.x(A.f7(d,"Zero playback speed is generally unsupported. Consider using [pause].",null))
v.sA(v.a.aVI(d))
x=2
return A.D(v.BU(),$async$ny)
case 2:return A.K(null,w)}})
return A.L($async$ny,w)},
azk(d){return D.t1},
acj(d){var x,w,v,u,t=this
if(t.cx)return
x=t.a
w=x.a
if(d.a>w.a)d=w
v=t.azk(d)
u=t.a.a
t.sA(x.aW8(v,d.a===u.a,d))},
P(d){if(!this.cx)this.yC(d)}}
B.aC1.prototype={
xt(d){var x,w=this
if(d===C.nN){x=w.b
w.a=x.a.f
x.bR()}else if(d===C.eR)if(w.a)w.b.c6()}}
B.Y2.prototype={
q(){return new B.a61()}}
B.a61.prototype={
avN(){var x=this,w=x.a.c.dy,v=x.d
v===$&&A.f()
if(w!==v)x.n(new B.bLa(x,w))},
a9(){var x,w=this
w.af()
x=w.a.c
w.d=x.dy
x.a1(w.gOZ())},
al(d){var x,w,v=this
v.au(d)
x=d.c
w=v.gOZ()
if(!x.cx)x.yC(w)
x=v.a.c
v.d=x.dy
x.a1(w)},
l(){var x=this.a.c
if(!x.cx)x.yC(this.gOZ())
this.O()},
k(d){var x=null,w=this.d
w===$&&A.f()
return w===-1?A.af(x,x,C.n,x,x,x,x,x,x,x,x,x,x,x):new B.aC3(this.a.c.a.ax,B.rh().ads(this.d),x)}}
B.aC3.prototype={
k(d){var x=this.c
if(x===0)return this.d
return new B.ahO(x/90|0,this.d,null)}}
B.aDz.prototype={}
B.aLc.prototype={}
var z=a.updateTypes(["G(G)","~()","am<~>(B)","am<~>()","am<~>(au)","~(lW,y)","b(n)"])
B.bWy.prototype={
$5(d,e,f,g,h){var x,w,v=null,u=d.b,t=u[e]
if(t==null)x=0
else{t=t
t.toString
x=A.jp(t,v)}t=u[f]
t.toString
t=A.jp(t,v)
w=u[g]
w.toString
w=A.jp(w,v)
u=u[h]
u.toString
return A.dt(0,x,0,A.jp(u,v),t,w)},
$S:855}
B.bus.prototype={
$1(d){},
$S:15}
B.but.prototype={
$1(d){},
$S:38}
B.bul.prototype={
$0(){var x=this.a
x.d=this.b
x.x=x.f=x.e=null
x.w=this.c.e},
$S:0}
B.bum.prototype={
$0(){return this.a.r=this.b},
$S:0}
B.bun.prototype={
$0(){return this.a.x=new A.kc("No playable URL")},
$S:0}
B.buo.prototype={
$0(){var x=this,w=x.a
w.e=x.b
w.f=x.c
w.x=x.d},
$S:0}
B.bup.prototype={
$0(){var x=this.a
x.e=this.b
x.f=this.c},
$S:0}
B.bur.prototype={
$2(d,e){var x=null,w=e.b,v=isFinite(w)?C.f.v(w,320,640):640
w=this.a
return new A.w(v,x,A.u(A.a([new B.azM(w.d,w.gaIK(),x),C.d5,w.aPJ(v)],y.p),C.l,x,C.c,C.j,0,C.h),x)},
$S:46}
B.buq.prototype={
$2(d,e){var x=null
return A.as(A.d("Playback failed: "+e,x,x,x,x,x,x,x,x,D.WR,C.a2,x,x,x),x,x)},
$S:856}
B.bFL.prototype={
$0(){return this.a.d.$1(this.b)},
$S:0}
B.b0K.prototype={
$2(d,e){return this.a.H$.dn(d,e)},
$S:35}
B.b9A.prototype={
$1(d){var x,w,v=this.a
if(v.cx)return
switch(d.a.a){case 0:x=d.b
v.sA(v.a.aWf(x,null,!1,x!=null,null,d.c))
x=this.b
if((x.a.a&30)!==0)throw A.x(A.bw("VideoPlayerController already initialized"))
x.f1(null)
v.GF()
v.BV()
v.ux()
break
case 1:v.bR().Y(new B.b9B(v),y.H)
v.sA(v.a.aVk(!0))
break
case 2:v.sA(v.a.aV9(d.e))
break
case 3:v.sA(v.a.ae2(!0))
break
case 4:v.sA(v.a.ae2(!1))
break
case 5:x=d.f
w=v.a
if(x===!0)v.sA(w.aW1(!1,x))
else v.sA(w.UO(x))
break
case 6:break}},
$S:857}
B.b9B.prototype={
$1(d){var x=this.a
return x.eI(x.a.a)},
$S:858}
B.b9z.prototype={
$1(d){var x,w
y.L.a(d)
x=this.a
w=d.b
w.toString
x.sA(new B.LZ(C.C,C.C,D.t1,C.C,D.Kf,!1,!1,!1,1,1,w,!1,!0,C.ag,0,!1))
x=x.CW
if(x!=null)x.ah()
x=this.b
if((x.a.a&30)===0)x.pv(d)},
$S:153}
B.b9y.prototype={
$1(d){return this.ajv(d)},
ajv(d){var x=0,w=A.M(y.H),v,u=this,t,s
var $async$$1=A.H(function(e,f){if(e===1)return A.J(f,w)
for(;;)switch(x){case 0:s=u.a
if(s.cx){x=1
break}x=3
return A.D(s.gaV(),$async$$1)
case 3:t=f
if(t==null){x=1
break}s.acj(t)
case 1:return A.K(v,w)}})
return A.L($async$$1,w)},
$S:859}
B.bLa.prototype={
$0(){this.a.d=this.b},
$S:0};(function installTearOffs(){var x=a._static_1,w=a._instance_1u,v=a._instance_0u,u=a._instance_2u
x(B,"cIB","czw",6)
w(B.a1D.prototype,"gaIK","o2",2)
var t
v(t=B.Ux.prototype,"ga47","az5",1)
v(t,"gahS","c6",3)
w(t,"gw9","eI",4)
w(t=B.Vq.prototype,"gbA","be",0)
w(t,"gbh","b6",0)
w(t,"gbH","bd",0)
w(t,"gbr","bc",0)
u(t,"gaJ6","aJ7",5)
v(B.a61.prototype,"gOZ","avN",1)})();(function inheritance(){var x=a.mixinHard,w=a.mixin,v=a.inheritMany,u=a.inherit
v(A.ax,[B.bWy,B.bus,B.but,B.b9A,B.b9B,B.b9z,B.b9y])
v(A.q,[B.a1B,B.Y2])
v(A.t,[B.a1D,B.a61])
v(A.aN,[B.bul,B.bum,B.bun,B.buo,B.bup,B.bFL,B.bLa])
v(A.bF,[B.bur,B.buq,B.b0K])
v(A.m,[B.azM,B.aC3])
u(B.Ux,F.m6)
u(B.axf,A.Z)
u(B.Vq,B.axf)
u(B.ahO,A.bB)
v(A.I,[B.a8J,B.LZ,B.aDz,B.aLc])
u(B.aly,A.bI)
u(B.aC1,B.aDz)
x(B.axf,A.bO)
w(B.aDz,A.f5)})()
A.ap(b.typeUniverse,JSON.parse('{"a1B":{"q":[],"b":[]},"a1D":{"t":["a1B"]},"azM":{"m":[],"b":[]},"Ux":{"m6":[],"az":[]},"Vq":{"Z":[],"bO":["Z"],"Y":[],"b7":[]},"ahO":{"bB":[],"ba":[],"b":[]},"Y2":{"q":[],"b":[]},"aly":{"bI":["LZ"],"az":[]},"aC1":{"f5":[]},"a61":{"t":["Y2"]},"aC3":{"m":[],"b":[]}}'))
var y=(function rtii(){var x=A.j
return{k:x("a9"),x:x("am<~>"),S:x("i<F_>"),p:x("i<b>"),m:x("c2"),P:x("aY"),L:x("qc"),h:x("c_<~>"),D:x("aR<~>"),y:x("E"),O:x("au?"),H:x("~")}})();(function constants(){var x=a.makeConstList
D.a7h=new M.v(B.cIB())
D.bG5=x([D.a7h],A.j("i<v>"))
D.a0L=D.bG5
D.t1=new B.a8J(0,C.C,C.C,"")
D.bxn=new A.aE(57764,"LucideIcons")
D.bxW=new A.bC(D.bxn,32,C.aA,null,null)
D.WW=new A.bl(!0,C.aA,null,null,null,null,13,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)
D.chm=new A.a4("Camera live \u2014 feed renders on device browsers",null,D.WW,null,null,null,null,null,null,null,null,null,null,null,null,null)
D.bIt=x([D.bxW,C.d5,D.chm],y.p)
D.a4T=new A.h7(C.z,C.c,C.j,C.l,null,C.h,null,C.n,0,D.bIt,null)
D.byq=new A.bC(E.IE,32,C.aA,null,null)
D.chg=new A.a4("Camera unavailable \u2014 permission denied",null,D.WW,null,null,null,null,null,null,null,null,null,null,null,null,null)
D.bXy=x([D.byq,C.d5,D.chg],y.p)
D.a4V=new A.h7(C.z,C.c,C.j,C.l,null,C.h,null,C.n,0,D.bXy,null)
D.byo=new A.bC(C.hD,32,C.aA,null,null)
D.Kf=x([],A.j("i<HU>"))
D.WR=new A.bl(!0,C.aA,null,null,null,null,12,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)
D.cvP=new A.b9P(0,"textureView")
D.cs5=new B.a1B(null)})();(function staticFields(){$.ccf=null})()};
(a=>{a["AszIKhj8IqCEENziEiANJdGqaoI="]=a.current})($__dart_deferred_initializers__);