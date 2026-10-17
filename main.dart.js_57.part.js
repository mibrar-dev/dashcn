((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,C,D={a9s:function a9s(d){this.b=d},
bRr(){return new D.F0(null)},
F0:function F0(d){this.a=d}},B
A=c[0]
C=c[2]
D=a.updateHolder(c[85],D)
B=c[446]
D.a9s.prototype={
a3B(d){var x,w
if(d<=0)return"0 "+C.b.ga1(this.b)
x=d
w=0
for(;;){if(!(x>=1024&&w<8))break
x/=1024;++w}return this.aks(x===(x<0?Math.ceil(x):Math.floor(x))?C.l.l(C.f.es(x)):C.f.a7(x,1))+" "+this.b[w]},
aks(d){var x,w,v=C.d.dt(d,"."),u=v===-1,t=u?d:C.d.S(d,0,v),s=u?"":C.d.aL(d,v),r=new A.dp("")
for(u=t.length,x=0,w="";x<u;++x){if(x>0&&C.l.aQ(u-x,3)===0)w=r.a=w+","
w+=t[x]
r.a=w}return r.l(0)+s}}
D.F0.prototype={
j(d){var x,w,v=null,u=A.h(d).w.a*3,t=A.a([A.lo(A.ii(B.c9h))],y.e)
for(x=0;x<6;++x){w=B.GA[x]
t.push(new A.o(B.bXy.a3B(w)+"  ("+w+")",v,v,v,v,v,v,v,v,v,v,v,v,v,v,v))}t.push(new A.A(v,u,v,v))
t.push(A.lo(A.ii(B.c5v)))
for(x=0;x<6;++x){w=B.GA[x]
t.push(new A.o(B.bXz.a3B(w)+"  ("+w+")",v,v,v,v,v,v,v,v,v,v,v,v,v,v,v))}return new A.I(new A.K(u,u,u,u),A.u(t,C.o,C.c,C.i,0,C.h),v)}}
var z=a.updateTypes([]);(function inheritance(){var x=a.inherit
x(D.a9s,A.J)
x(D.F0,A.i)})()
A.ag(b.typeUniverse,JSON.parse('{"F0":{"i":[],"b":[]}}'))
var y={h:A.e("f<q>"),e:A.e("f<b>")};(function constants(){var x=a.makeConstList
B.GA=x([0,512,1024,1536,10485760,1073741824],A.e("f<E>"))
B.bqc=x(["B","KB","MB","GB","TB","PB","EB","ZB","YB"],y.h)
B.bXy=new D.a9s(B.bqc)
B.bLr=x(["B","KiB","MiB","GiB","TiB","PiB","EiB","ZiB","YiB"],y.h)
B.bXz=new D.a9s(B.bLr)
B.c5v=new A.o("binaryBytes",null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)
B.c9h=new A.o("fileBytes",null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)})()};
(a=>{a["ef23Oao6IkksVSAQm4+AbnVFaS0="]=a.current})($__dart_deferred_initializers__);