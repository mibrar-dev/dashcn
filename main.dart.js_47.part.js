((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,C,D={aiT:function aiT(d){this.b=d},
ckQ(){return new D.CU(null)},
CU:function CU(d){this.a=d}},B
A=c[0]
C=c[2]
D=a.updateHolder(c[121],D)
B=c[408]
D.aiT.prototype={
ig(d){var x,w
if(d<=0)return"0 "+C.b.gV(this.b)
x=d
w=0
for(;;){if(!(x>=1024&&w<8))break
x/=1024;++w}return this.azH(x===(x<0?Math.ceil(x):Math.floor(x))?C.h.m(C.f.bW(x)):C.f.a8(x,1))+" "+this.b[w]},
azH(d){var x,w,v=C.d.ca(d,"."),u=v===-1,t=u?d:C.d.U(d,0,v),s=u?"":C.d.aN(d,v),r=new A.dI("")
for(u=t.length,x=0,w="";x<u;++x){if(x>0&&C.h.Z(u-x,3)===0)w=r.a=w+","
w+=t[x]
r.a=w}return r.m(0)+s}}
D.CU.prototype={
k(d){var x,w,v=null,u=A.h(d).x.a*3,t=A.a([A.m1(A.jK(B.cfG))],y.e)
for(x=0;x<6;++x){w=B.Ks[x]
t.push(new A.a5(B.caS.ig(w)+"  ("+w+")",v,v,v,v,v,v,v,v,v,v,v,v,v,v,v))}t.push(new A.x(v,u,v,v))
t.push(A.m1(A.jK(B.cf3)))
for(x=0;x<6;++x){w=B.Ks[x]
t.push(new A.a5(B.caT.ig(w)+"  ("+w+")",v,v,v,v,v,v,v,v,v,v,v,v,v,v,v))}return new A.P(new A.O(u,u,u,u),A.u(t,C.p,v,C.c,C.j,0,C.i),v)}}
var z=a.updateTypes([]);(function inheritance(){var x=a.inherit
x(D.aiT,A.I)
x(D.CU,A.m)})()
A.ao(b.typeUniverse,JSON.parse('{"CU":{"m":[],"b":[]}}'))
var y={h:A.j("i<o>"),e:A.j("i<b>")};(function constants(){var x=a.makeConstList
B.Ks=x([0,512,1024,1536,10485760,1073741824],A.j("i<B>"))
B.bAB=x(["B","KB","MB","GB","TB","PB","EB","ZB","YB"],y.h)
B.caS=new D.aiT(B.bAB)
B.bX_=x(["B","KiB","MiB","GiB","TiB","PiB","EiB","ZiB","YiB"],y.h)
B.caT=new D.aiT(B.bX_)
B.cf3=new A.a5("binaryBytes",null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)
B.cfG=new A.a5("fileBytes",null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)})()};
(a=>{a["ymP3XcJVVJILGhaj5YDmZ35fWnE="]=a.current})($__dart_deferred_initializers__);