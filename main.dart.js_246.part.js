((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var J,B,C,A={
cHL(d,e,f,g){if(d.length===0||e.length===0)return null
return A.czJ(d,e,f,g)},
czJ(d,e,f,g){var x=A.czK(d,e,f)
if(x!=null||g)return x
return A.czI(d,e,f)},
czK(d,e,f){var x,w,v
if(d===f){x=e.length
w=J.hu(x,y.e)
for(v=0;v<x;++v)w[v]=v
return new A.yq(1e6,w)}if(C.d.ac(f,d)){x=d.length
w=J.hu(x,y.e)
for(v=0;v<x;++v)w[v]=v
return new A.yq(5e5,w)}return A.czL(d,f)},
a7m(d){return d===32||d===95||d===45||d===47||d===92||d===46||d===58||d===59||d===44||d===40||d===41||d===91||d===93||d===123||d===125},
czL(d,e){var x,w,v,u,t,s,r=e.length
for(x=d.length,w=1;w<r;++w)if(A.a7m(e.charCodeAt(w-1))&&w+x<=r&&C.d.c3(e,d,w)){v=B.a(new Array(x),y.r)
for(u=0;u<x;++u)v[u]=w+u
return new A.yq(12e4,v)}if(!A.cyA(d,e))return null
t=B.a([],y.r)
if(e.charCodeAt(0)===d.charCodeAt(0)){t.push(0)
s=1}else s=0
w=1
for(;;){if(!(w<r&&s<x))break
if(A.a7m(e.charCodeAt(w-1))&&e.charCodeAt(w)===d.charCodeAt(s)){t.push(w);++s}++w}return new A.yq(1e5,t)},
cyA(d,e){var x,w,v,u=e.length
if(u===0||d.length===0)return!1
if(e.charCodeAt(0)===d.charCodeAt(0)){if(1===d.length)return!0
x=1}else x=0
w=d.length
v=1
for(;;){if(!(v<u&&x<w))break
if(A.a7m(e.charCodeAt(v-1))&&e.charCodeAt(v)===d.charCodeAt(x))++x;++v}return x===w},
crE(d,e){var x,w
if(e===0)return 8
x=d.charCodeAt(e-1)
w=d.charCodeAt(e)
if(A.a7m(x)){if(x===47||x===46||x===58)return 9
return 10}if(x>=97&&x<=122&&w>=65&&w<=90)return 7
return 0},
czO(d,e){var x,w,v,u,t,s,r
for(x=e.length,w=0,v=0,u=!1,t=0;t<x;++t){s=e.charCodeAt(t)
if(s<64)w|=C.i.wW(1,s)
else if(s<128)v|=C.i.nz(1,s-64)
else u=!0}for(x=d.length,r=!u,t=0;t<x;++t){s=d.charCodeAt(t)
if(s<64){if((w&C.i.wW(1,s))>>>0===0)return!1}else if(s<128){if((v&C.i.nz(1,s-64))>>>0===0)return!1}else if(r)return!1}return!0},
czI(a8,a9,b0){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,a0,a1,a2,a3,a4,a5=3221225472,a6=a8.length,a7=b0.length
if(a6>a7||!A.czO(a8,b0))return null
x=y.e
w=J.hu(a7,x)
for(v=0;v<a7;++v)w[v]=A.crE(a9,v)
u=B.bZ(a7,a5,!1,x)
t=J.hu(a6,y.w)
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
a4=B.aj(new B.df(a1,x),x.i("bj.E"))
return new A.yq(1e4+e,a4)},
yq:function yq(d,e){this.a=d
this.c=e},
cGq(d,e,a0){var x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f
if(d===e)return 0
x=d.length
w=e.length
if(Math.abs(x-w)>a0)return a0+1
if(x===0)return w
if(w===0)return x
v=w+1
u=y.e
t=B.bZ(v,0,!1,u)
s=J.hu(v,u)
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
cHM(d,e){var x,w,v,u,t,s,r,q,p,o,n,m=d.toLowerCase()
if(m.length===0||e.length===0)return null
for(x=new B.jT(A.cdc(e).a()),w=y.r,v=null;x.u();){u=x.b
t=u.a
s=t.length
if(s<3)continue
r=s>=6?2:1
q=A.cGq(m,t.toLowerCase(),r)
if(q>r||q===0)continue
p=1000-q*100
if(v==null||p>v.a){o=B.a(new Array(s),w)
for(u=u.b,n=0;n<s;++n)o[n]=u+n
v=new A.yq(p,o)}}return v},
cdc(d){return new B.dA(A.cCM(d),y.a)},
cCM(d){return function(){var x=d
var w=0,v=1,u=[],t,s,r
return function $async$cdc(e,f,g){if(f===1){u.push(g)
w=v}for(;;)switch(w){case 0:t=x.length,s=0
case 2:if(!(s<t)){w=4
break}for(;;){if(!(s<t&&A.a7m(x.charCodeAt(s))))break;++s}if(s>=t){w=4
break}r=s
for(;;){if(!(r<t&&!A.a7m(x.charCodeAt(r))))break;++r}w=5
return e.b=new A.aBf(C.d.U(x,s,r),s),1
case 5:case 3:s=r
w=2
break
case 4:return 0
case 1:return e.c=u.at(-1),3}}}},
aBf:function aBf(d,e){this.a=d
this.b=e},
clm(d){var x,w,v,u,t,s,r,q,p=B.S(y.x,y.w)
for(x=y.r,w=0;w<d.length;++w){v=d[w].toLowerCase()
for(u=v.length,t=0;s=t+1,s<u;t=s){r=C.d.U(v,t,t+2)
q=p.j(0,r)
if(q==null){q=B.a([],x)
p.p(0,r,q)}q.push(w)}}return p},
vC:function vC(d,e){this.a=d
this.b=e},
Iy:function Iy(d){this.a=d
this.b=null}},D
J=c[1]
B=c[0]
C=c[2]
A=a.updateHolder(c[181],A)
D=c[489]
A.yq.prototype={}
A.aBf.prototype={}
A.vC.prototype={}
A.Iy.prototype={
O6(d){var x=this.a
if(x.length>2000)this.b=A.clm(x)},
b1N(d){var x,w,v,u,t,s,r,q,p,o=this.b,n=d.toLowerCase()
if(o==null||n.length<2){x=this.a.length
w=J.hu(x,y.e)
for(v=0;v<x;++v)w[v]=v
return w}u=B.b4(y.e)
for(t=n.length,s=0;r=s+1,r<t;s=r){q=o.j(0,C.d.U(n,s,s+2))
if(q!=null)u.E(0,q)}p=B.aj(u,u.$ti.c)
C.b.mK(p)
return p},
ai6(d){var x,w,v,u,t,s,r,q,p,o,n,m,l=this
if(d.length===0)return D.bQC
x=d.toLowerCase()
w=B.a([],y.y)
v=l.b!=null
if(v){u=l.b1N(d)
t=B.tl(u,B.at(u).c)}else t=D.caT
for(u=l.a,s=0;s<u.length;++s){r=u[s]
if(r.length===0)continue
q=v&&!t.B(0,s)
p=A.cHL(x,r,r.toLowerCase(),q)
if(p!=null)w.push(new A.vC(s,p))}if(w.length!==0){C.b.fu(w,l.ga2k())
return w}o=v?t:l.a0F()
for(n=o.gaa(o);n.u();){m=n.gR()
p=A.cHM(d,u[m])
if(p!=null)w.push(new A.vC(m,p))}C.b.fu(w,l.ga2k())
return w},
a0F(){return new B.dA(this.asv(),y.v)},
asv(){var x=this
return function(){var w=0,v=1,u=[],t,s
return function $async$a0F(d,e,f){if(e===1){u.push(f)
w=v}for(;;)switch(w){case 0:t=x.a,s=0
case 2:if(!(s<t.length)){w=4
break}w=5
return d.b=s,1
case 5:case 3:++s
w=2
break
case 4:return 0
case 1:return d.c=u.at(-1),3}}}},
avm(d,e){var x,w,v,u=d.b.a,t=e.b.a
if(u!==t)return C.i.bl(t,u)
u=this.a
t=d.a
x=u[t].length
w=e.a
v=u[w].length
if(x!==v)return C.i.bl(x,v)
return C.i.bl(t,w)}}
var z=a.updateTypes(["B(vC,vC)"]);(function installTearOffs(){var x=a._instance_2u
x(A.Iy.prototype,"ga2k","avm",0)})();(function inheritance(){var x=a.inheritMany
x(B.I,[A.yq,A.aBf,A.vC,A.Iy])})()
var y={y:B.j("i<vC>"),r:B.j("i<B>"),w:B.j("a2<B>"),F:B.j("df<B>"),x:B.j("p"),a:B.j("dA<aBf>"),v:B.j("dA<B>"),e:B.j("B")};(function constants(){var x=a.makeConstList
D.bQC=x([],y.y)
D.caT=new B.eK(C.cD,0,B.j("eK<B>"))})()};
(a=>{a["EFFbWUJs1KKprb8sraqto36rz7E="]=a.current})($__dart_deferred_initializers__);