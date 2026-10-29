((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,B,C,A={
cGl(d,e,f,g){if(d.length===0||e.length===0)return null
return A.cyo(d,e,f,g)},
cyo(d,e,f,g){var x=A.cyp(d,e,f)
if(x!=null||g)return x
return A.cyn(d,e,f)},
cyp(d,e,f){var x,w,v
if(d===f){x=e.length
w=J.ht(x,y.e)
for(v=0;v<x;++v)w[v]=v
return new A.yj(1e6,w)}if(C.d.ac(f,d)){x=d.length
w=J.ht(x,y.e)
for(v=0;v<x;++v)w[v]=v
return new A.yj(5e5,w)}return A.cyq(d,f)},
a7o(d){return d===32||d===95||d===45||d===47||d===92||d===46||d===58||d===59||d===44||d===40||d===41||d===91||d===93||d===123||d===125},
cyq(d,e){var x,w,v,u,t,s,r=e.length
for(x=d.length,w=1;w<r;++w)if(A.a7o(e.charCodeAt(w-1))&&w+x<=r&&C.d.c3(e,d,w)){v=B.a(new Array(x),y.r)
for(u=0;u<x;++u)v[u]=w+u
return new A.yj(12e4,v)}if(!A.cxg(d,e))return null
t=B.a([],y.r)
if(e.charCodeAt(0)===d.charCodeAt(0)){t.push(0)
s=1}else s=0
w=1
for(;;){if(!(w<r&&s<x))break
if(A.a7o(e.charCodeAt(w-1))&&e.charCodeAt(w)===d.charCodeAt(s)){t.push(w);++s}++w}return new A.yj(1e5,t)},
cxg(d,e){var x,w,v,u=e.length
if(u===0||d.length===0)return!1
if(e.charCodeAt(0)===d.charCodeAt(0)){if(1===d.length)return!0
x=1}else x=0
w=d.length
v=1
for(;;){if(!(v<u&&x<w))break
if(A.a7o(e.charCodeAt(v-1))&&e.charCodeAt(v)===d.charCodeAt(x))++x;++v}return x===w},
cqn(d,e){var x,w
if(e===0)return 8
x=d.charCodeAt(e-1)
w=d.charCodeAt(e)
if(A.a7o(x)){if(x===47||x===46||x===58)return 9
return 10}if(x>=97&&x<=122&&w>=65&&w<=90)return 7
return 0},
cyt(d,e){var x,w,v,u,t,s,r
for(x=e.length,w=0,v=0,u=!1,t=0;t<x;++t){s=e.charCodeAt(t)
if(s<64)w|=C.h.wV(1,s)
else if(s<128)v|=C.h.ny(1,s-64)
else u=!0}for(x=d.length,r=!u,t=0;t<x;++t){s=d.charCodeAt(t)
if(s<64){if((w&C.h.wV(1,s))>>>0===0)return!1}else if(s<128){if((v&C.h.ny(1,s-64))>>>0===0)return!1}else if(r)return!1}return!0},
cyn(a8,a9,b0){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,a0,a1,a2,a3,a4,a5=3221225472,a6=a8.length,a7=b0.length
if(a6>a7||!A.cyt(a8,b0))return null
x=y.e
w=J.ht(a7,x)
for(v=0;v<a7;++v)w[v]=A.cqn(a9,v)
u=B.bZ(a7,a5,!1,x)
t=J.ht(a6,y.w)
for(s=0;s<a6;++s)t[s]=B.bZ(a7,-1,!1,x)
for(r=0;r<a6;++r,u=q){q=B.bZ(a7,a5,!1,x)
p=a8.charCodeAt(r)
for(o=r===0,n=r>0,m=a5,l=-1,v=0;v<a7;++v){if(n&&v>=2){k=v-2
j=u[k]
if(j!==3221225472){i=j+k
if(i>m){l=k
m=i}}}if(b0.charCodeAt(v)!==p)continue
if(o){if(v===0){q[v]=w[v]
t[r][v]=-1}else{q[v]=w[v]-(3+(v-1))
t[r][v]=-2}continue}if(v>0&&u[v-1]!==3221225472){h=v-1
g=u[h]+5+w[v]}else{g=a5
h=-1}if(l!==-1&&m!==3221225472){f=m-v-1+w[v]
if(f>g){h=l
g=f}}q[v]=g
t[r][v]=h}}for(e=a5,d=-1,v=0;v<a7;++v){a0=u[v]
if(a0>e){e=a0
d=v}}if(d===-1)return null
a1=B.a([],y.r)
a2=a6-1
a3=d
for(;;){if(!(a2>=0&&a3>=0))break
a1.push(a3)
a3=t[a2][a3];--a2}if(a1.length!==a6)return null
x=y.F
a4=B.ai(new B.de(a1,x),x.i("bi.E"))
return new A.yj(1e4+e,a4)},
yj:function yj(d,e){this.a=d
this.c=e},
cF0(d,e,a0){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f
if(d===e)return 0
x=d.length
w=e.length
if(Math.abs(x-w)>a0)return a0+1
if(x===0)return w
if(w===0)return x
v=w+1
u=y.e
t=B.bZ(v,0,!1,u)
s=J.ht(v,u)
for(r=0;r<v;++r)s[r]=r
for(q=1;q<=x;++q,t=s,s=p){p=B.bZ(v,0,!1,u)
p[0]=q
for(o=q>1,n=q-1,m=q-2,l=q,r=1;r<=w;++r){k=r-1
j=d.charCodeAt(n)===e.charCodeAt(k)?0:1
i=s[r]+1
h=p[k]+1
if(h<i)i=h
g=s[k]+j
if(g<i)i=g
if(o&&r>1&&d.charCodeAt(n)===e.charCodeAt(r-2)&&d.charCodeAt(m)===e.charCodeAt(k)){f=t[r-2]+1
if(f<i)i=f}p[r]=i
if(i<l)l=i}if(l>a0)return a0+1}return s[w]},
cGm(d,e){var x,w,v,u,t,s,r,q,p,o,n,m=d.toLowerCase()
if(m.length===0||e.length===0)return null
for(x=new B.jQ(A.cbT(e).a()),w=y.r,v=null;x.u();){u=x.b
t=u.a
s=t.length
if(s<3)continue
r=s>=6?2:1
q=A.cF0(m,t.toLowerCase(),r)
if(q>r||q===0)continue
p=1000-q*100
if(v==null||p>v.a){o=B.a(new Array(s),w)
for(u=u.b,n=0;n<s;++n)o[n]=u+n
v=new A.yj(p,o)}}return v},
cbT(d){return new B.dB(A.cBn(d),y.a)},
cBn(d){return function(){var x=d
var w=0,v=1,u=[],t,s,r
return function $async$cbT(e,f,g){if(f===1){u.push(g)
w=v}for(;;)switch(w){case 0:t=x.length,s=0
case 2:if(!(s<t)){w=4
break}for(;;){if(!(s<t&&A.a7o(x.charCodeAt(s))))break;++s}if(s>=t){w=4
break}r=s
for(;;){if(!(r<t&&!A.a7o(x.charCodeAt(r))))break;++r}w=5
return e.b=new A.aB_(C.d.U(x,s,r),s),1
case 5:case 3:s=r
w=2
break
case 4:return 0
case 1:return e.c=u.at(-1),3}}}},
aB_:function aB_(d,e){this.a=d
this.b=e},
ck1(d){var x,w,v,u,t,s,r,q,p=B.S(y.x,y.w)
for(x=y.r,w=0;w<d.length;++w){v=d[w].toLowerCase()
for(u=v.length,t=0;s=t+1,s<u;t=s){r=C.d.U(v,t,t+2)
q=p.j(0,r)
if(q==null){q=B.a([],x)
p.p(0,r,q)}q.push(w)}}return p},
vt:function vt(d,e){this.a=d
this.b=e},
Iq:function Iq(d){this.a=d
this.b=null}},D
J=c[1]
B=c[0]
C=c[2]
A=a.updateHolder(c[181],A)
D=c[488]
A.yj.prototype={}
A.aB_.prototype={}
A.vt.prototype={}
A.Iq.prototype={
O3(d){var x=this.a
if(x.length>2000)this.b=A.ck1(x)},
b1t(d){var x,w,v,u,t,s,r,q,p,o=this.b,n=d.toLowerCase()
if(o==null||n.length<2){x=this.a.length
w=J.ht(x,y.e)
for(v=0;v<x;++v)w[v]=v
return w}u=B.b4(y.e)
for(t=n.length,s=0;r=s+1,r<t;s=r){q=o.j(0,C.d.U(n,s,s+2))
if(q!=null)u.E(0,q)}p=B.ai(u,u.$ti.c)
C.b.mK(p)
return p},
ahY(d){var x,w,v,u,t,s,r,q,p,o,n,m,l=this
if(d.length===0)return D.bPx
x=d.toLowerCase()
w=B.a([],y.y)
v=l.b!=null
if(v){u=l.b1t(d)
t=B.ti(u,B.at(u).c)}else t=D.c9I
for(u=l.a,s=0;s<u.length;++s){r=u[s]
if(r.length===0)continue
q=v&&!t.C(0,s)
p=A.cGl(x,r,r.toLowerCase(),q)
if(p!=null)w.push(new A.vt(s,p))}if(w.length!==0){C.b.fu(w,l.ga2d())
return w}o=v?t:l.a0x()
for(n=o.ga9(o);n.u();){m=n.gS()
p=A.cGm(d,u[m])
if(p!=null)w.push(new A.vt(m,p))}C.b.fu(w,l.ga2d())
return w},
a0x(){return new B.dB(this.asq(),y.v)},
asq(){var x=this
return function(){var w=0,v=1,u=[],t,s
return function $async$a0x(d,e,f){if(e===1){u.push(f)
w=v}for(;;)switch(w){case 0:t=x.a,s=0
case 2:if(!(s<t.length)){w=4
break}w=5
return d.b=s,1
case 5:case 3:++s
w=2
break
case 4:return 0
case 1:return d.c=u.at(-1),3}}}},
avd(d,e){var x,w,v,u=d.b.a,t=e.b.a
if(u!==t)return C.h.bl(t,u)
u=this.a
t=d.a
x=u[t].length
w=e.a
v=u[w].length
if(x!==v)return C.h.bl(x,v)
return C.h.bl(t,w)}}
var z=a.updateTypes(["B(vt,vt)"]);(function installTearOffs(){var x=a._instance_2u
x(A.Iq.prototype,"ga2d","avd",0)})();(function inheritance(){var x=a.inheritMany
x(B.I,[A.yj,A.aB_,A.vt,A.Iq])})()
var y={y:B.j("i<vt>"),r:B.j("i<B>"),w:B.j("a2<B>"),F:B.j("de<B>"),x:B.j("o"),a:B.j("dB<aB_>"),v:B.j("dB<B>"),e:B.j("B")};(function constants(){var x=a.makeConstList
D.bPx=x([],y.y)
D.c9I=new B.eI(C.cC,0,B.j("eI<B>"))})()};
(a=>{a["7ukr1dCVrmoSGzMpQ3xkhVI16jc="]=a.current})($__dart_deferred_initializers__);