((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,C,D={aj2:function aj2(d){this.b=d},
cma(){return new D.D2(null)},
D2:function D2(d){this.a=d}},B
A=c[0]
C=c[2]
D=a.updateHolder(c[121],D)
B=c[408]
D.aj2.prototype={
ih(d){var x,w
if(d<=0)return"0 "+C.b.gV(this.b)
x=d
w=0
for(;;){if(!(x>=1024&&w<8))break
x/=1024;++w}return this.azP(x===(x<0?Math.ceil(x):Math.floor(x))?C.i.m(C.f.bS(x)):C.f.a6(x,1))+" "+this.b[w]},
azP(d){var x,w,v=C.d.ce(d,"."),u=v===-1,t=u?d:C.d.U(d,0,v),s=u?"":C.d.aM(d,v),r=new A.dI("")
for(u=t.length,x=0,w="";x<u;++x){if(x>0&&C.i.Z(u-x,3)===0)w=r.a=w+","
w+=t[x]
r.a=w}return r.m(0)+s}}
D.D2.prototype={
k(d){var x,w,v=null,u=A.h(d).x.a*3,t=A.a([A.m4(A.jM(B.chZ))],y.e)
for(x=0;x<6;++x){w=B.KB[x]
t.push(new A.a4(B.cc2.ih(w)+"  ("+w+")",v,v,v,v,v,v,v,v,v,v,v,v,v,v,v))}t.push(new A.w(v,u,v,v))
t.push(A.m4(A.jM(B.chd)))
for(x=0;x<6;++x){w=B.KB[x]
t.push(new A.a4(B.cc3.ih(w)+"  ("+w+")",v,v,v,v,v,v,v,v,v,v,v,v,v,v,v))}return new A.P(new A.O(u,u,u,u),A.u(t,C.p,v,C.c,C.j,0,C.h),v)}}
var z=a.updateTypes([]);(function inheritance(){var x=a.inherit
x(D.aj2,A.I)
x(D.D2,A.m)})()
A.ap(b.typeUniverse,JSON.parse('{"D2":{"m":[],"b":[]}}'))
var y={h:A.j("i<p>"),e:A.j("i<b>")};(function constants(){var x=a.makeConstList
B.KB=x([0,512,1024,1536,10485760,1073741824],A.j("i<B>"))
B.bBG=x(["B","KB","MB","GB","TB","PB","EB","ZB","YB"],y.h)
B.cc2=new D.aj2(B.bBG)
B.bY6=x(["B","KiB","MiB","GiB","TiB","PiB","EiB","ZiB","YiB"],y.h)
B.cc3=new D.aj2(B.bY6)
B.chd=new A.a4("binaryBytes",null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)
B.chZ=new A.a4("fileBytes",null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)})()};
(a=>{a["SFZzCXxhpyWh9phRp5UT2jYeOlI="]=a.current})($__dart_deferred_initializers__);