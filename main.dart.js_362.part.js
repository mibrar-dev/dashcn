((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,C,H,K,I,F,E,G,L,B={
cI4(d){var x,w,v,u,t,s,r=A.a([],y.S),q=A.bY(d,"\r\n","\n").split("\n"),p=q.length!==0&&C.d.av(C.b.gV(q))==="WEBVTT"?1:0,o=A.ab("(?:(\\d+):)?([0-5]?\\d):([0-5]\\d)[.,](\\d{3})\\s*-->\\s*(?:(\\d+):)?([0-5]?\\d):([0-5]\\d)[.,](\\d{3})",!0,!1,!1,!1),n=new B.bVm()
while(p<q.length){x=C.d.av(q[p]);++p
if(x.length===0)continue
w=o.ha(x)
if(w==null)continue
v=n.$5(w,1,2,3,4)
v.toString
u=n.$5(w,5,6,7,8)
u.toString
t=q.length
s=""
for(;;){if(!(p<t&&C.d.av(q[p]).length!==0))break
if(s.length!==0)s+="\n"
s+=C.d.av(q[p]);++p}if(s.length!==0)r.push(new F.EQ(v,u,s.charCodeAt(0)==0?s:s))}return r},
cyb(d){return D.cpz},
bVm:function bVm(){},
a1D:function a1D(d){this.a=d},
a1F:function a1F(){var _=this
_.d=0
_.f=_.e=null
_.w=_.r=!1
_.c=_.a=_.x=null},
btK:function btK(){},
btL:function btL(){},
btD:function btD(d,e,f){this.a=d
this.b=e
this.c=f},
btE:function btE(d,e){this.a=d
this.b=e},
btF:function btF(d){this.a=d},
btG:function btG(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},
btH:function btH(d,e,f){this.a=d
this.b=e
this.c=f},
btJ:function btJ(d){this.a=d},
btI:function btI(){},
azy:function azy(d,e,f){this.c=d
this.d=e
this.a=f},
bEK:function bEK(d,e){this.a=d
this.b=e},
Ut:function Ut(d,e,f){var _=this
_.r=d
_.w=1
_.x=!1
_.y=null
_.z=!1
_.Q=e
_.id$=0
_.k1$=f
_.k3$=_.k2$=0},
Vm:function Vm(d,e,f,g,h){var _=this
_.G=d
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
b0a:function b0a(d){this.a=d},
ax1:function ax1(){},
ahD:function ahD(d,e,f){this.e=d
this.c=e
this.a=f},
a8K:function a8K(d,e,f,g){var _=this
_.a=d
_.b=e
_.c=f
_.d=g},
rf(){var x=$.cfe()
if($.caW!==x){x.Lk()
$.caW=x}return x},
c97(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s){return new B.LS(g,o,e,f,d,m,!1,i,s,n,h,j,!0,r,q,k)},
LS:function LS(d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s){var _=this
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
aln:function aln(d,e,f){var _=this
_.w=d
_.CW=_.ch=_.ay=null
_.cx=!1
_.dx=_.db=_.cy=null
_.dy=-1
_.a=e
_.id$=0
_.k1$=f
_.k3$=_.k2$=0},
b93:function b93(d,e){this.a=d
this.b=e},
b94:function b94(d){this.a=d},
b92:function b92(d,e){this.a=d
this.b=e},
b91:function b91(d){this.a=d},
aBL:function aBL(d){this.a=!1
this.b=d},
Y4:function Y4(d,e){this.c=d
this.a=e},
a62:function a62(){this.d=$
this.c=this.a=null},
bK5:function bK5(d,e){this.a=d
this.b=e},
aBN:function aBN(d,e,f){this.c=d
this.d=e
this.a=f},
aDi:function aDi(){},
aL_:function aL_(d,e,f,g){var _=this
_.a=d
_.b=e
_.e=f
_.f=g},
bYL(){var x=0,w=A.M(y.y),v,u=2,t=[],s,r,q,p,o,n,m,l,k
var $async$bYL=A.H(function(d,e){if(d===1){t.push(e)
x=u}for(;;)switch(x){case 0:u=4
s=b.G.window.navigator.mediaDevices
x=7
return A.D(A.hV(s.getUserMedia({video:!0}),y.m),$async$bYL)
case 7:r=e
q=A.hl(r)
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
return A.L($async$bYL,w)}},D,M
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
B.a1D.prototype={
q(){return new B.a1F()}}
B.a1F.prototype={
aa(){this.af()
this.o3(0)},
l(){var x=this.f
if(x!=null)x.l()
x=this.e
if(x!=null)x.l().cp(new B.btK(),new B.btL(),y.P)
this.P()},
o3(d){return this.aIC(d)},
aIC(a2){var x=0,w=A.M(y.H),v,u=2,t=[],s=this,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,a0,a1
var $async$o3=A.H(function(a3,a4){if(a3===1){t.push(a4)
x=u}for(;;)switch(x){case 0:h=E.wK[a2]
g=s.e
f=s.f
if(f!=null)f.l()
if(s.c!=null)s.n(new B.btD(s,a2,h))
x=h.e?3:4
break
case 3:x=5
return A.D(B.bYL(),$async$o3)
case 5:o=a4
if(s.c==null){x=1
break}s.n(new B.btE(s,o))
u=7
n=g
n=n==null?null:n.l()
x=10
return A.D(y.x.b(n)?n:A.cO(n,y.H),$async$o3)
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
break}s.n(new B.btF(s))
u=14
n=g
n=n==null?null:n.l()
x=17
return A.D(y.x.b(n)?n:A.cO(n,y.H),$async$o3)
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
case 12:n=A.cn(l,0,null).m(0)
k=B.c97(D.K6,D.t2,C.B,C.B,null,!1,!1,!1,!1,!1,1,C.B,!0,0,C.ae,1)
j=$.a3()
r=new B.aln(n,k,j)
k=r
i=new B.Ut(k,E.K7,j)
k.a1(i.ga4_())
q=i
k=q
j=h.d
k.x=j
k.y=h.b
k.a_()
k=q
k.Q=B.cI4("WEBVTT\n\n00:00.000 --> 00:05.000\nHello, world\n\n00:05.000 --> 00:12.000\nButterfly wings at 24 frames\n")
k.a_()
x=j?18:20
break
case 18:x=21
return A.D(q.op(!1),$async$o3)
case 21:x=19
break
case 20:x=22
return A.D(q.op(!0),$async$o3)
case 22:case 19:u=24
x=27
return A.D(r.hc(),$async$o3)
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
return A.D(r.l(),$async$o3)
case 30:x=1
break
case 29:s.n(new B.btG(s,r,q,p))
u=32
n=g
n=n==null?null:n.l()
x=35
return A.D(y.x.b(n)?n:A.cO(n,y.H),$async$o3)
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
return A.D(r.l(),$async$o3)
case 38:x=1
break
case 37:s.n(new B.btH(s,r,q))
n=g
n=n==null?null:n.l()
x=39
return A.D(y.x.b(n)?n:A.cO(n,y.H),$async$o3)
case 39:case 1:return A.K(v,w)
case 2:return A.J(t.at(-1),w)}})
return A.L($async$o3,w)},
k(d){return A.bI(new B.btJ(this))},
aPz(d){var x,w,v,u,t,s=this,r=null,q=E.wK[s.d]
if(q.e){x=A.a4(18)
w=A.aQ(G.lN,C.w,1)
if(!s.w)v=C.ab
else v=s.r?D.a4M:D.a4O
return new H.uE(1.7777777777777777,A.ag(C.C,v,C.n,r,r,new A.V(I.il,r,w,x,r,r,r,C.o),r,r,r,r,r,r,r,r),r)}u=s.f
t=s.e
if(u==null||t==null){x=A.a4(18)
w=A.aQ(G.lN,C.w,1)
v=s.x
v=v==null?D.bxj:A.d("Playback failed: "+A.E(v),r,r,r,r,r,r,r,r,D.WG,C.a1,r,r,r)
return new H.uE(1.7777777777777777,A.ag(C.C,v,C.n,r,r,new A.V(C.co,r,w,x,r,r,r,C.o),r,r,r,r,r,r,r,r),r)}return F.A6(new B.Y4(u.r,r),u,r,r,new B.btI(),r,q.b,r,q.a)}}
B.azy.prototype={
k(d){var x,w,v,u,t,s,r,q=null,p=A.a([],y.p)
for(x=this.c,w=0;w<3;++w){v=x===w
u=v?I.il:C.aM
t=new A.b9(999,999)
s=new A.d5(G.lN,1,C.w,-1)
r=E.wK[w]
v=v?C.az:L.AZ
p.push(A.ck(C.aw,A.ag(q,new A.a5(r.a,q,new A.bn(!0,v,q,q,q,q,12,C.R,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q),q,q,q,q,q,q,q,q,q,q,q,q,q),C.n,q,q,new A.V(u,q,new A.cG(s,s,s,s),new A.dd(t,t,t,t),q,q,q,C.o),q,q,q,K.p5,C.iB,q,q,q),!1,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,q,new B.bEK(this,w),q,q,q,q,q,q,q,q,q,q,q,!1,C.ad))}return A.bg(C.bc,p,C.a9,q,C.v,8,0)}}
B.Ut.prototype={
ayY(){return this.a_()},
gaej(){return this.Q},
grh(){return this.z},
op(d){return this.akS(d)},
akS(d){var x=0,w=A.M(y.H),v=this
var $async$op=A.H(function(e,f){if(e===1)return A.J(f,w)
for(;;)switch(x){case 0:v.z=d
v.a_()
return A.K(null,w)}})
return A.L($async$op,w)},
gAt(){return this.x},
gaV(){return this.r.a.b},
gef(){return this.r.a.a},
gx9(){var x=this.r.a.e
if(x.length===0)return C.B
return C.b.gaq(x).b},
guh(){return this.r.a.x},
gnk(){return this.r.a.x<=0},
gpP(){return this.r.a.y},
gfJ(){return this.r.a.f},
gxR(){return this.r.a.w},
gKJ(){var x=this.r.a.z
return x!=null?x:null},
c7(){return this.r.c7()},
bR(){return this.r.bR()},
eG(d){return this.r.eG(d)},
bJ(d){if(d>0)this.w=d
return this.r.bJ(d)},
p5(d){var x=d?0:this.w
return this.r.bJ(x)},
nx(d){return this.r.nx(d)},
l(){var x=this.r
if(!x.cx)x.yB(this.ga4_())
this.bx()}}
B.Vm.prototype={
sb1H(d){if(this.G===d)return
this.G=d
this.a6()},
be(d){var x=this.H$
if(x==null)return 0
return(this.G&1)===1?x.am(C.cF,d,x.gbH()):x.am(C.cl,d,x.gbB())},
b6(d){var x=this.H$
if(x==null)return 0
return(this.G&1)===1?x.am(C.bB,d,x.gbr()):x.am(C.bm,d,x.gbh())},
bd(d){var x=this.H$
if(x==null)return 0
return(this.G&1)===1?x.am(C.cl,d,x.gbB()):x.am(C.cF,d,x.gbH())},
bc(d){var x=this.H$
if(x==null)return 0
return(this.G&1)===1?x.am(C.bm,d,x.gbh()):x.am(C.bB,d,x.gbr())},
c9(d){var x,w,v=this.H$
if(v==null)return new A.a8(A.a7(0,d.a,d.b),A.a7(0,d.c,d.d))
x=(this.G&1)===1?d.gKU():d
w=v.am(C.aP,x,v.gcr())
return(this.G&1)===1?new A.a8(w.b,w.a):w},
bn(){var x,w,v=this
v.W=null
x=v.H$
if(x!=null){w=y.k
x.bQ((v.G&1)===1?w.a(A.Z.prototype.ga4.call(v)).gKU():w.a(A.Z.prototype.ga4.call(v)),!0)
x=v.G
w=v.H$
v.fy=(x&1)===1?new A.a8(w.gD().b,v.H$.gD().a):w.gD()
w=A.et()
w.dT(v.gD().a/2,v.gD().b/2,0,1)
w.yg(1.5707963267948966*C.h.Z(v.G,4))
w.dT(-v.H$.gD().a/2,-v.H$.gD().b/2,0,1)
v.W=w}else{x=y.k.a(A.Z.prototype.ga4.call(v))
v.fy=new A.a8(A.a7(0,x.a,x.b),A.a7(0,x.c,x.d))}},
ea(d,e){var x=this
if(x.H$==null||x.W==null)return!1
return d.x4(new B.b0a(x),e,x.W)},
aIZ(d,e){var x=this.H$
x.toString
d.f5(x,e)},
au(d,e){var x,w,v=this,u=v.a0
if(v.H$!=null){x=v.cx
x===$&&A.f()
w=v.W
w.toString
u.saQ(d.AU(x,e,w,v.gaIY(),u.a))}else u.saQ(null)},
l(){this.a0.saQ(null)
this.iA()},
fl(d,e){var x=this.W
if(x!=null)e.ej(x)
this.a_R(d,e)}}
B.ax1.prototype={
aA(d){var x
this.f7(d)
x=this.H$
if(x!=null)x.aA(d)},
ap(){this.f_()
var x=this.H$
if(x!=null)x.ap()}}
B.ahD.prototype={
aM(d){var x=new B.Vm(this.e,A.b2(),null,new A.bM(),A.b2())
x.aL()
x.sb3(null)
return x},
aR(d,e){e.sb1H(this.e)}}
B.a8K.prototype={
m(d){var x=this
return"Caption(number: "+x.a+", start: "+x.b.m(0)+", end: "+x.c.m(0)+", text: "+x.d+")"},
h(d,e){var x,w,v=this
if(e==null)return!1
if(v!==e){x=!1
if(e instanceof B.a8K)if(A.ah(v)===A.ah(e))if(v.a===e.a){w=e.b
if(v.b.a===w.a){x=e.c
x=v.c.a===x.a&&v.d===e.d}}}else x=!0
return x},
gt(d){var x=this
return A.W(x.a,x.b,x.c,x.d,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a)}}
B.LS.prototype={
ty(d,e,f,g,h,i,j,k,a0,a1,a2,a3,a4){var x=this,w=f==null?x.a:f,v=a3==null?x.at:a3,u=a1==null?x.b:a1,t=e==null?x.c:e,s=d==null?x.e:d,r=j==null?x.ay:j,q=k==null?x.f:k,p=h==null?x.w:h,o=a4==null?x.x:a4,n=a0==null?x.y:a0,m=g!=="defaultErrorDescription"?g:x.z,l=i==null?x.Q:i
return B.c97(s,t,x.d,w,m,p,l,r,!1,q,n,u,!0,x.ax,v,o)},
aVX(d,e,f,g,h,i){var x=null
return this.ty(x,x,d,e,x,f,g,x,x,x,h,i,x)},
aV7(d){var x=null
return this.ty(x,x,x,"defaultErrorDescription",x,d,x,x,x,x,x,x,x)},
aUZ(d){var x=null
return this.ty(d,x,x,"defaultErrorDescription",x,x,x,x,x,x,x,x,x)},
adU(d){var x=null
return this.ty(x,x,x,"defaultErrorDescription",d,x,x,x,x,x,x,x,x)},
aVJ(d,e){var x=null
return this.ty(x,x,x,"defaultErrorDescription",x,d,x,e,x,x,x,x,x)},
UI(d){var x=null
return this.ty(x,x,x,"defaultErrorDescription",x,x,x,d,x,x,x,x,x)},
aVQ(d,e,f){var x=null
return this.ty(x,d,x,"defaultErrorDescription",x,e,x,x,x,f,x,x,x)},
aVE(d){var x=null
return this.ty(x,x,x,"defaultErrorDescription",x,x,x,x,x,x,x,x,d)},
aVu(d){var x=null
return this.ty(x,x,x,"defaultErrorDescription",x,x,x,x,d,x,x,x,x)},
m(d){var x=this
return"VideoPlayerValue(duration: "+x.a.m(0)+", size: "+x.at.m(0)+", position: "+x.b.m(0)+", caption: "+x.c.m(0)+", captionOffset: "+x.d.m(0)+", buffered: ["+C.b.aU(x.e,", ")+"], isInitialized: "+x.ay+", isPlaying: "+x.f+", isLooping: false, isBuffering: "+x.w+", volume: "+A.E(x.x)+", playbackSpeed: "+A.E(x.y)+", errorDescription: "+A.E(x.z)+", isCompleted: "+x.Q+", preventsDisplaySleepDuringVideoPlayback: true),"},
h(d,e){var x,w,v=this
if(e==null)return!1
if(v!==e){x=!1
if(e instanceof B.LS)if(A.ah(v)===A.ah(e)){w=e.a
if(v.a.a===w.a){w=e.b
if(v.b.a===w.a)if(v.c.h(0,e.c)){w=e.d
if(v.d.a===w.a)if(A.cN(v.e,e.e))if(v.f===e.f)if(v.w===e.w)if(v.x===e.x)if(v.y===e.y)if(v.z==e.z)if(v.at.h(0,e.at))if(v.ax===e.ax)if(v.ay===e.ay)x=v.Q===e.Q}}}}else x=!0
return x},
gt(d){var x=this
return A.W(x.a,x.b,x.c,x.d,x.e,x.f,!1,x.w,x.x,x.y,x.z,x.at,x.ax,x.ay,x.Q,!0,C.a,C.a,C.a,C.a)}}
B.aln.prototype={
hc(){var x=0,w=A.M(y.H),v,u=this,t,s,r,q,p
var $async$hc=A.H(function(d,e){if(d===1)return A.J(e,w)
for(;;)switch(x){case 0:u.dx=new B.aBL(u)
t=u.dx
if(t!=null)$.ar.b1$.push(t)
t=y.D
s=y.h
u.cy=new A.c_(new A.aS($.aU,t),s)
switch(1){case 1:r=new B.aL_(C.anI,u.w,null,null)
break}x=3
return A.D(B.rf().Ea(new A.all(r)),$async$hc)
case 3:q=e
u.dy=q==null?-1:q
u.cy.f1(null)
t=new A.aS($.aU,t)
p=new A.c_(t,s)
s=B.rf()
q=u.dy
u.a.toString
x=4
return A.D(s.Nu(q,!0),$async$hc)
case 4:u.db=B.rf().aj_(u.dy).LK(new B.b93(u,p),new B.b92(u,p))
v=t
x=1
break
case 1:return A.K(v,w)}})
return A.L($async$hc,w)},
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
return A.D(B.rf().hG(u.dy),$async$l)
case 9:case 7:t=u.dx
if(t!=null)$.ar.nT(t)
case 4:u.cx=!0
u.bx()
case 1:return A.K(v,w)}})
return A.L($async$l,w)},
c7(){var x=0,w=A.M(y.H),v=this,u,t
var $async$c7=A.H(function(d,e){if(d===1)return A.J(e,w)
for(;;)switch(x){case 0:u=v.a
t=u.b
u=u.a
x=t.a===u.a?2:3
break
case 2:x=4
return A.D(v.eG(C.B),$async$c7)
case 4:case 3:v.sv(v.a.UI(!0))
x=5
return A.D(v.uu(),$async$c7)
case 5:return A.K(null,w)}})
return A.L($async$c7,w)},
bR(){var x=0,w=A.M(y.H),v=this
var $async$bR=A.H(function(d,e){if(d===1)return A.J(e,w)
for(;;)switch(x){case 0:v.sv(v.a.UI(!1))
x=2
return A.D(v.uu(),$async$bR)
case 2:return A.K(null,w)}})
return A.L($async$bR,w)},
GD(){var x=0,w=A.M(y.H),v,u=this,t,s
var $async$GD=A.H(function(d,e){if(d===1)return A.J(e,w)
for(;;)switch(x){case 0:if(u.cx||!u.a.ay){x=1
break}t=B.rf()
s=u.dy
u.a.toString
x=3
return A.D(t.G5(s,!1),$async$GD)
case 3:case 1:return A.K(v,w)}})
return A.L($async$GD,w)},
uu(){var x=0,w=A.M(y.H),v,u=this,t
var $async$uu=A.H(function(d,e){if(d===1)return A.J(e,w)
for(;;)switch(x){case 0:if(u.cx||!u.a.ay){x=1
break}x=u.a.f?3:5
break
case 3:x=6
return A.D(B.rf().mz(u.dy),$async$uu)
case 6:t=u.CW
if(t!=null)t.ah()
u.CW=A.zY(C.bM,new B.b91(u))
x=7
return A.D(u.BT(),$async$uu)
case 7:x=4
break
case 5:t=u.CW
if(t!=null)t.ah()
x=8
return A.D(B.rf().fD(u.dy),$async$uu)
case 8:case 4:case 1:return A.K(v,w)}})
return A.L($async$uu,w)},
BU(){var x=0,w=A.M(y.H),v,u=this
var $async$BU=A.H(function(d,e){if(d===1)return A.J(e,w)
for(;;)switch(x){case 0:if(u.cx||!u.a.ay){x=1
break}x=3
return A.D(B.rf().Gc(u.dy,u.a.x),$async$BU)
case 3:case 1:return A.K(v,w)}})
return A.L($async$BU,w)},
BT(){var x=0,w=A.M(y.H),v,u=this
var $async$BT=A.H(function(d,e){if(d===1)return A.J(e,w)
for(;;)switch(x){case 0:if(u.cx||!u.a.ay){x=1
break}if(!u.a.f){x=1
break}x=3
return A.D(B.rf().G7(u.dy,u.a.y),$async$BT)
case 3:case 1:return A.K(v,w)}})
return A.L($async$BT,w)},
gaV(){var x=0,w=A.M(y.O),v,u=this
var $async$gaV=A.H(function(d,e){if(d===1)return A.J(e,w)
for(;;)switch(x){case 0:if(u.cx){v=null
x=1
break}v=B.rf().FN(u.dy)
x=1
break
case 1:return A.K(v,w)}})
return A.L($async$gaV,w)},
eG(d){return this.akw(d)},
akw(d){var x=0,w=A.M(y.H),v,u=this,t,s
var $async$eG=A.H(function(e,f){if(e===1)return A.J(f,w)
for(;;)switch(x){case 0:if(u.cx||!u.a.ay){x=1
break}t=u.a.a
s=d.a
if(s>t.a)d=t
else if(s<0)d=C.B
x=3
return A.D(B.rf().FY(u.dy,d),$async$eG)
case 3:u.aca(d)
case 1:return A.K(v,w)}})
return A.L($async$eG,w)},
bJ(d){return this.ama(d)},
ama(d){var x=0,w=A.M(y.H),v=this
var $async$bJ=A.H(function(e,f){if(e===1)return A.J(f,w)
for(;;)switch(x){case 0:v.sv(v.a.aVE(C.f.A(d,0,1)))
x=2
return A.D(v.BU(),$async$bJ)
case 2:return A.K(null,w)}})
return A.L($async$bJ,w)},
nx(d){return this.alv(d)},
alv(d){var x=0,w=A.M(y.H),v=this
var $async$nx=A.H(function(e,f){if(e===1)return A.J(f,w)
for(;;)switch(x){case 0:if(d<0)throw A.w(A.f8(d,"Negative playback speeds are generally unsupported.",null))
else if(d===0)throw A.w(A.f8(d,"Zero playback speed is generally unsupported. Consider using [pause].",null))
v.sv(v.a.aVu(d))
x=2
return A.D(v.BT(),$async$nx)
case 2:return A.K(null,w)}})
return A.L($async$nx,w)},
azc(d){return D.t2},
aca(d){var x,w,v,u,t=this
if(t.cx)return
x=t.a
w=x.a
if(d.a>w.a)d=w
v=t.azc(d)
u=t.a.a
t.sv(x.aVQ(v,d.a===u.a,d))},
O(d){if(!this.cx)this.yB(d)}}
B.aBL.prototype={
xt(d){var x,w=this
if(d===C.nP){x=w.b
w.a=x.a.f
x.bR()}else if(d===C.eT)if(w.a)w.b.c7()}}
B.Y4.prototype={
q(){return new B.a62()}}
B.a62.prototype={
avF(){var x=this,w=x.a.c.dy,v=x.d
v===$&&A.f()
if(w!==v)x.n(new B.bK5(x,w))},
aa(){var x,w=this
w.af()
x=w.a.c
w.d=x.dy
x.a1(w.gOV())},
al(d){var x,w,v=this
v.ar(d)
x=d.c
w=v.gOV()
if(!x.cx)x.yB(w)
x=v.a.c
v.d=x.dy
x.a1(w)},
l(){var x=this.a.c
if(!x.cx)x.yB(this.gOV())
this.P()},
k(d){var x=null,w=this.d
w===$&&A.f()
return w===-1?A.ag(x,x,C.n,x,x,x,x,x,x,x,x,x,x,x):new B.aBN(this.a.c.a.ax,B.rf().adi(this.d),x)}}
B.aBN.prototype={
k(d){var x=this.c
if(x===0)return this.d
return new B.ahD(x/90|0,this.d,null)}}
B.aDi.prototype={}
B.aL_.prototype={}
var z=a.updateTypes(["G(G)","~()","al<~>(B)","al<~>()","al<~>(au)","~(lU,y)","b(n)"])
B.bVm.prototype={
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
return A.du(0,x,0,A.jp(u,v),t,w)},
$S:847}
B.btK.prototype={
$1(d){},
$S:15}
B.btL.prototype={
$1(d){},
$S:39}
B.btD.prototype={
$0(){var x=this.a
x.d=this.b
x.x=x.f=x.e=null
x.w=this.c.e},
$S:0}
B.btE.prototype={
$0(){return this.a.r=this.b},
$S:0}
B.btF.prototype={
$0(){return this.a.x=new A.ka("No playable URL")},
$S:0}
B.btG.prototype={
$0(){var x=this,w=x.a
w.e=x.b
w.f=x.c
w.x=x.d},
$S:0}
B.btH.prototype={
$0(){var x=this.a
x.e=this.b
x.f=this.c},
$S:0}
B.btJ.prototype={
$2(d,e){var x=null,w=e.b,v=isFinite(w)?C.f.A(w,320,640):640
w=this.a
return new A.x(v,x,A.u(A.a([new B.azy(w.d,w.gaIB(),x),C.d6,w.aPz(v)],y.p),C.l,x,C.c,C.j,0,C.i),x)},
$S:48}
B.btI.prototype={
$2(d,e){var x=null
return A.as(A.d("Playback failed: "+e,x,x,x,x,x,x,x,x,D.WG,C.a1,x,x,x),x,x)},
$S:848}
B.bEK.prototype={
$0(){return this.a.d.$1(this.b)},
$S:0}
B.b0a.prototype={
$2(d,e){return this.a.H$.dn(d,e)},
$S:35}
B.b93.prototype={
$1(d){var x,w,v=this.a
if(v.cx)return
switch(d.a.a){case 0:x=d.b
v.sv(v.a.aVX(x,null,!1,x!=null,null,d.c))
x=this.b
if((x.a.a&30)!==0)throw A.w(A.bw("VideoPlayerController already initialized"))
x.f1(null)
v.GD()
v.BU()
v.uu()
break
case 1:v.bR().Y(new B.b94(v),y.H)
v.sv(v.a.aV7(!0))
break
case 2:v.sv(v.a.aUZ(d.e))
break
case 3:v.sv(v.a.adU(!0))
break
case 4:v.sv(v.a.adU(!1))
break
case 5:x=d.f
w=v.a
if(x===!0)v.sv(w.aVJ(!1,x))
else v.sv(w.UI(x))
break
case 6:break}},
$S:849}
B.b94.prototype={
$1(d){var x=this.a
return x.eG(x.a.a)},
$S:850}
B.b92.prototype={
$1(d){var x,w
y.L.a(d)
x=this.a
w=d.b
w.toString
x.sv(new B.LS(C.B,C.B,D.t2,C.B,D.K6,!1,!1,!1,1,1,w,!1,!0,C.ae,0,!1))
x=x.CW
if(x!=null)x.ah()
x=this.b
if((x.a.a&30)===0)x.pu(d)},
$S:208}
B.b91.prototype={
$1(d){return this.ajm(d)},
ajm(d){var x=0,w=A.M(y.H),v,u=this,t,s
var $async$$1=A.H(function(e,f){if(e===1)return A.J(f,w)
for(;;)switch(x){case 0:s=u.a
if(s.cx){x=1
break}x=3
return A.D(s.gaV(),$async$$1)
case 3:t=f
if(t==null){x=1
break}s.aca(t)
case 1:return A.K(v,w)}})
return A.L($async$$1,w)},
$S:851}
B.bK5.prototype={
$0(){this.a.d=this.b},
$S:0};(function installTearOffs(){var x=a._static_1,w=a._instance_1u,v=a._instance_0u,u=a._instance_2u
x(B,"cHa","cyb",6)
w(B.a1F.prototype,"gaIB","o3",2)
var t
v(t=B.Ut.prototype,"ga4_","ayY",1)
v(t,"gahJ","c7",3)
w(t,"gw7","eG",4)
w(t=B.Vm.prototype,"gbB","be",0)
w(t,"gbh","b6",0)
w(t,"gbH","bd",0)
w(t,"gbr","bc",0)
u(t,"gaIY","aIZ",5)
v(B.a62.prototype,"gOV","avF",1)})();(function inheritance(){var x=a.mixinHard,w=a.mixin,v=a.inheritMany,u=a.inherit
v(A.ax,[B.bVm,B.btK,B.btL,B.b93,B.b94,B.b92,B.b91])
v(A.q,[B.a1D,B.Y4])
v(A.t,[B.a1F,B.a62])
v(A.aM,[B.btD,B.btE,B.btF,B.btG,B.btH,B.bEK,B.bK5])
v(A.bD,[B.btJ,B.btI,B.b0a])
v(A.m,[B.azy,B.aBN])
u(B.Ut,F.m3)
u(B.ax1,A.Y)
u(B.Vm,B.ax1)
u(B.ahD,A.bC)
v(A.I,[B.a8K,B.LS,B.aDi,B.aL_])
u(B.aln,A.bL)
u(B.aBL,B.aDi)
x(B.ax1,A.bO)
w(B.aDi,A.f5)})()
A.ao(b.typeUniverse,JSON.parse('{"a1D":{"q":[],"b":[]},"a1F":{"t":["a1D"]},"azy":{"m":[],"b":[]},"Ut":{"m3":[],"az":[]},"Vm":{"Y":[],"bO":["Y"],"Z":[],"b6":[]},"ahD":{"bC":[],"b7":[],"b":[]},"Y4":{"q":[],"b":[]},"aln":{"bL":["LS"],"az":[]},"aBL":{"f5":[]},"a62":{"t":["Y4"]},"aBN":{"m":[],"b":[]}}'))
var y=(function rtii(){var x=A.j
return{k:x("a9"),x:x("al<~>"),S:x("i<EQ>"),p:x("i<b>"),m:x("c2"),P:x("aZ"),L:x("qb"),h:x("c_<~>"),D:x("aS<~>"),y:x("F"),O:x("au?"),H:x("~")}})();(function constants(){var x=a.makeConstList
D.a7a=new M.v(B.cHa())
D.bF0=x([D.a7a],A.j("i<v>"))
D.a0I=D.bF0
D.t2=new B.a8K(0,C.B,C.B,"")
D.bwi=new A.aE(57764,"LucideIcons")
D.bwR=new A.bB(D.bwi,32,C.az,null,null)
D.WR=new A.bn(!0,C.az,null,null,null,null,13,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)
D.cfc=new A.a5("Camera live \u2014 feed renders on device browsers",null,D.WR,null,null,null,null,null,null,null,null,null,null,null,null,null)
D.bHo=x([D.bwR,C.d6,D.cfc],y.p)
D.a4M=new A.h8(C.z,C.c,C.j,C.l,null,C.i,null,C.n,0,D.bHo,null)
D.bxl=new A.bB(E.Iv,32,C.az,null,null)
D.cf6=new A.a5("Camera unavailable \u2014 permission denied",null,D.WR,null,null,null,null,null,null,null,null,null,null,null,null,null)
D.bWr=x([D.bxl,C.d6,D.cf6],y.p)
D.a4O=new A.h8(C.z,C.c,C.j,C.l,null,C.i,null,C.n,0,D.bWr,null)
D.bxj=new A.bB(C.hB,32,C.az,null,null)
D.K6=x([],A.j("i<HL>"))
D.WG=new A.bn(!0,C.az,null,null,null,null,12,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)
D.cti=new A.b9i(0,"textureView")
D.cpz=new B.a1D(null)})();(function staticFields(){$.caW=null})()};
(a=>{a["BJyQjKFrsc6FTu8KRM0GaOOL4mQ="]=a.current})($__dart_deferred_initializers__);