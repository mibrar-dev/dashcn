((a,b)=>{a[b]=a[b]||{}})(self,"$__dart_deferred_initializers__")
$__dart_deferred_initializers__.current=function(a,b,c,$){var A,C,E,B={DA:function DA(d,e,f){this.d=d
this.e=e
this.a=f},awl:function awl(){},n8:function n8(d,e,f,g,h,i,j,k){var _=this
_.d=d
_.e=e
_.f=f
_.r=g
_.w=h
_.a=i
_.b=j
_.c=k},
bXx(d){return D.W0},
bXy(d){return D.W_},
bXz(d){return D.ci7},
TF:function TF(d,e,f){this.c=d
this.d=e
this.a=f},
TG:function TG(d){this.a=d},
afh:function afh(){this.d="idle"
this.c=this.a=null},
b_8:function b_8(d){this.a=d},
b_7:function b_7(d){this.a=d},
b_9:function b_9(d){this.a=d},
b_6:function b_6(d){this.a=d},
cdt(d){var x,w,v,u,t=C.d.m5(d),s=A.a9("^(?:```+|~~~+)\\s*([A-Za-z][\\w+-]*)",!0,!1,!1,!1).fG(t)
if(s!=null){x=A.as5(s.b[1])
if(x!=null)return x}w=A.a9("^import\\s+['\"]package:flutter/",!0,!1,!1,!1)
v=!0
if(!w.b.test(t)){w=A.a9("^import\\s+['\"]dart:",!0,!1,!1,!1)
if(!w.b.test(t)){w=A.a9("^\\s*void\\s+main\\s*\\(",!0,!1,!0,!1)
w=w.b.test(t)}else w=v}else w=v
if(w)return C.lk
w=A.a9("^#!\\S*\\b(?:ba)?sh\\b|^#!\\S*\\bzsh\\b",!0,!1,!1,!1)
if(w.b.test(t))return C.ll
w=A.a9("^<!DOCTYPE html|^<html[\\s>]",!1,!1,!1,!1)
if(w.b.test(t))return C.vr
w=A.a9("^<\\?xml",!0,!1,!1,!1)
if(w.b.test(t))return C.vr
w=A.a9("^import\\s+(?:UIKit|Foundation|SwiftUI)\\b",!0,!1,!1,!1)
if(w.b.test(t))return C.S7
w=A.a9("^\\s*def\\s+\\w+\\s*\\([^)]*\\)\\s*:",!0,!1,!1,!1)
if(!w.b.test(t)){w=A.a9("^\\s*(?:async\\s+)?def\\s+\\w+\\s*\\(.*\\)\\s*(?:->\\s*\\w+\\s*)?:",!0,!1,!1,!1)
w=w.b.test(t)}else w=!0
if(w)return C.Sb
w=A.a9("^\\s*(?:pub\\s+)?(?:fun|val|var)\\s+\\w+",!0,!1,!1,!1)
if(w.b.test(t)&&C.d.v(t,A.a9("\\b(?:Unit|Int|String|Boolean)\\b",!0,!1,!1,!1)))return C.S6
w=A.a9("^\\s*(?:const|let|var|function)\\s+\\w+",!0,!1,!1,!1)
v=!0
if(!w.b.test(t)){w=A.a9("=>",!0,!1,!1,!1)
if(!w.b.test(t)){w=A.a9("^\\s*console\\.log\\(",!0,!1,!0,!1)
w=w.b.test(t)}else w=v}else w=v
if(w)return C.vq
u=C.d.au(t)
if(u.length===0)return null
if(C.d.ac(u,"{")||C.d.ac(u,"[")){w=A.a9('^[\\s{}\\[\\]",:0-9aeflnrtyA-FLNR\\.\\-+]*$',!0,!1,!1,!1)
w=w.b.test(u)}else w=!1
if(w)return C.Sc
return null}},D,F
A=c[0]
C=c[2]
E=c[166]
B=a.updateHolder(c[46],B)
D=c[308]
F=c[216]
B.DA.prototype={
j(d){var x,w,v,u,t,s=this,r=null,q=A.h(d),p=y.j,o=A.aF(d,D.a2b,new B.awl(),r,p,p),n=q.f
p=q.a
x=o.d.H(p)
w=o.e.H(p)
w=A.aU(w,C.y,o.f*n)
v=A.ab(q.b.a*16)
u=q.r
t=A.cf(o.w,u.a*n)
p=A.aK(r,r,p.c,r,r,r,r,r,r,r,r,r,r,r,r,r,r,!0,r,r,r,r,r,r,r,r)
p=A.a([A.aq(r,A.b3(A.b3(A.d6(A.wl(d,!1)==null?s.SU(q):A.aNI(s.SU(q),r,r,new A.h2()),r,r,r,p,r,r),r,t,r,r,C.B),r,r,r,r,C.u),C.n,r,r,r,r,r,r,r,r,r,r,r)],y.e)
if(s.d.length!==0){t=d.Z(y.o).w
u=u.b*n
p.push(A.bzn(r,A.M(s.ay9(n),C.m,r,C.c,C.i,0,r),u,r,t,u,r))}return A.aq(r,A.cd(C.a2,p,C.T,C.dN),C.n,r,r,new A.a2(x,r,w,v,r,r,C.q),r,r,r,r,r,r,r,r)},
ay9(d){var x,w,v,u=A.a([],y.e)
for(x=this.d,w=4*d,v=0;v<x.length;++v){if(v>0)u.push(new A.c2(w,null,null))
u.push(x[v])}return u},
SU(d){var x,w,v,u=null,t=this.e,s=t.c
if(s==null){x=t.d
s=x==null?u:x.Ou()}if(s==null)return A.ii(E.aSf(t))
w=A.as5(u)
if(w==null)w=B.cdt(s)
if(w==null)return A.ii(E.aSf(t))
v=d.d.b.R(d.a.c)
return A.ii(E.aSf(A.ln(A.bN(A.CG(v,s,d.gmj(),w),u,u,u,u,u,u,u,u,v,u),u,u,u,u,u,u,u,u,u)))}}
B.n8.prototype={
F(d){var x=this
return new B.n8(x.d,x.e,x.f,d.r,x.w,d.a,d.b,d.c)},
h(d,e){var x,w=this
if(e==null)return!1
if(w===e)return!0
x=!1
if(e instanceof B.n8)if(e.d.h(0,w.d))if(e.e.h(0,w.e))if(e.f===w.f)x=e.w.h(0,w.w)
return x},
gq(d){var x=this
return A.P(x.a,x.b,x.c,x.d,x.e,x.f,x.r,x.w,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a,C.a)}}
B.TF.prototype={
j(d){var x=null
return A.T(!1,A.j(this.c,x,x,x,x,x,x,x,x,x,x,x,x,x),x,x,x,x,x,x,x,this.d,x,x,C.r,x,x,x,x,C.R)}}
B.TG.prototype={
t(){return new B.afh()}}
B.afh.prototype={
j(d){var x=null,w=A.h(d),v=y.e
return A.u(A.a([new B.DA(A.a([new B.TF("Copy",new B.b_8(this),x),new B.TF("Run",new B.b_9(this),x)],v),D.c5y,x),A.p(w.w.a*2),A.j(this.d,x,x,x,x,x,x,x,x,A.aK(x,x,A.h(d).a.as,x,x,x,x,x,x,x,x,12,x,x,x,x,x,!0,x,x,x,x,x,x,x,x),x,x,x,x)],v),C.o,C.c,C.i,0,C.h)}}
var z=a.updateTypes(["b(l)","n8(n8)"])
B.awl.prototype={
$1(d){return d},
$S:z+1}
B.b_8.prototype={
$0(){var x=this.a
return x.p(new B.b_7(x))},
$S:0}
B.b_7.prototype={
$0(){return this.a.d="copied"},
$S:0}
B.b_9.prototype={
$0(){var x=this.a
return x.p(new B.b_6(x))},
$S:0}
B.b_6.prototype={
$0(){return this.a.d="running"},
$S:0};(function installTearOffs(){var x=a._static_1
x(B,"c9q","bXx",0)
x(B,"c9r","bXy",0)
x(B,"c9s","bXz",0)})();(function inheritance(){var x=a.inheritMany,w=a.inherit
x(A.i,[B.DA,B.TF])
w(B.awl,A.ap)
w(B.n8,A.ao)
w(B.TG,A.r)
w(B.afh,A.t)
x(A.aA,[B.b_8,B.b_7,B.b_9,B.b_6])})()
A.ag(b.typeUniverse,JSON.parse('{"DA":{"i":[],"b":[]},"n8":{"ao":[]},"TG":{"r":[],"b":[]},"TF":{"i":[],"b":[]},"afh":{"t":["TG"]}}'))
var y={j:A.e("n8"),o:A.e("dC"),e:A.e("f<b>")};(function constants(){var x=a.makeConstList
D.c7N=new A.o('void main() { runApp(const MyApp(home: Center(child: Text("wide")))); }',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)
D.a2c=new B.DA(C.b0,D.c7N,null)
D.bYe=new A.A(320,null,D.a2c,null)
D.W_=new A.bc(C.D,null,null,D.bYe,null)
D.c64=new A.o('const greeting = "hello";',null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)
D.a2d=new B.DA(C.b0,D.c64,null)
D.W0=new A.bc(C.D,null,null,D.a2d,null)
D.a7y=new F.z(B.c9q())
D.a7A=new F.z(B.c9s())
D.a7z=new F.z(B.c9r())
D.bL8=x([D.a7y,D.a7A,D.a7z],A.e("f<z>"))
D.Z4=D.bL8
D.bhb=new A.ed(1,1,3.5,1)
D.a2b=new B.n8(C.dI,C.aD,1,null,D.bhb,null,null,null)
D.c5y=new A.o("flutter run -d chrome",null,null,null,null,null,null,null,null,null,null,null,null,null,null,null)
D.ci7=new B.TG(null)})()};
(a=>{a["bbcwDuT7HBWkLvJMiazwoDHI9Pc="]=a.current})($__dart_deferred_initializers__);