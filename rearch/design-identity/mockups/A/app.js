/* Plinth shared interactions — works from file:// */
(function(){
  const root=document.documentElement;
  // theme
  const saved=localStorage.getItem('plinth-theme');
  if(saved) root.setAttribute('data-theme',saved);
  window.plinthTheme=function(){
    const cur=root.getAttribute('data-theme')==='dark'?'light':'dark';
    root.setAttribute('data-theme',cur);localStorage.setItem('plinth-theme',cur);
    document.querySelectorAll('[data-theme-label]').forEach(e=>e.textContent=cur==='dark'?'Light':'Dark');
  };
  document.querySelectorAll('[data-theme-toggle]').forEach(b=>b.addEventListener('click',window.plinthTheme));
  // mobile nav
  document.querySelectorAll('[data-hamb]').forEach(b=>b.addEventListener('click',()=>{
    document.querySelectorAll('.nav-links').forEach(n=>n.classList.toggle('open'));
  }));
  // copy buttons
  document.querySelectorAll('[data-copy]').forEach(b=>b.addEventListener('click',()=>{
    const t=b.getAttribute('data-copy');navigator.clipboard&&navigator.clipboard.writeText(t);
    const o=b.textContent;b.textContent='copied';setTimeout(()=>b.textContent=o,900);
  }));
  // counters roll
  function roll(el,to){let s=0;const steps=24;let i=0;const iv=setInterval(()=>{i++;s=Math.round(to*i/steps);el.textContent=s.toLocaleString();if(i>=steps)clearInterval(iv);},28);}
  document.querySelectorAll('[data-count]').forEach(el=>roll(el,parseFloat(el.getAttribute('data-count'))));
  // platform switchers: [data-plats] container with buttons data-plat + targets data-frame
  document.querySelectorAll('[data-plats]').forEach(group=>{
    const btns=group.querySelectorAll('button[data-plat]');
    const scope=group.getAttribute('data-plats');
    const frames=document.querySelectorAll('[data-frame-scope="'+scope+'"] [data-frame]');
    btns.forEach(b=>b.addEventListener('click',()=>{
      btns.forEach(x=>x.classList.remove('on'));b.classList.add('on');
      const p=b.getAttribute('data-plat');
      frames.forEach(f=>f.style.display=f.getAttribute('data-frame')===p?'':'none');
      const lab=document.querySelector('[data-plat-label="'+scope+'"]');if(lab)lab.textContent=p;
    }));
  });
  // rulers: drag changes CSS vars on target
  document.querySelectorAll('.ruler[data-ruler]').forEach(r=>{
    const key=r.getAttribute('data-ruler');const target=document.querySelector(r.getAttribute('data-target')||'#heroApp');
    const val=r.parentElement.querySelector('[data-ruler-val]');
    const thumb=r.querySelector('.thumb');
    let cur=parseFloat(r.getAttribute('data-value')||50);
    function render(){
      const min=parseFloat(r.getAttribute('data-min')),max=parseFloat(r.getAttribute('data-max'));
      const pct=(cur-min)/(max-min)*100;thumb.style.left='calc('+pct+'% - 1px)';
      if(!target)return;
      if(key==='radius'){const v=(cur).toFixed(3);target.style.setProperty('--rscale',(cur/10).toFixed(2));if(val)val.textContent='radius '+v+'rem';}
      if(key==='density'){target.style.setProperty('--dscale',(1.3-cur/50).toFixed(2));if(val)val.textContent='density '+(cur<33?'compact':cur<66?'medium':'comfortable');}
      if(key==='hue'){target.style.setProperty('filter','hue-rotate('+((cur-24)*1.2).toFixed(0)+'deg)');if(val)val.textContent='hue '+Math.round(cur)+'°';}
    }
    function setFromEvent(e){
      const rect=r.getBoundingClientRect();const x=(e.touches?e.touches[0].clientX:e.clientX)-rect.left;
      const min=parseFloat(r.getAttribute('data-min')),max=parseFloat(r.getAttribute('data-max'));
      cur=Math.min(max,Math.max(min,min+(x/rect.width)*(max-min)));render();
    }
    let drag=false;
    r.addEventListener('pointerdown',e=>{drag=true;r.setPointerCapture(e.pointerId);setFromEvent(e);});
    r.addEventListener('pointermove',e=>{if(drag)setFromEvent(e);});
    r.addEventListener('pointerup',()=>drag=false);
    render();
  });
  // generic tabs
  document.querySelectorAll('[data-tabs]').forEach(t=>{
    const btns=t.querySelectorAll('button[data-tab]');
    const panes=document.querySelectorAll('[data-pane-scope="'+t.getAttribute('data-tabs')+'"]');
    btns.forEach(b=>b.addEventListener('click',()=>{
      btns.forEach(x=>x.classList.remove('on'));b.classList.add('on');
      panes.forEach(p=>p.style.display=p.getAttribute('data-pane')===b.getAttribute('data-tab')?'':'none');
    }));
  });
  // playground (component page)
  const pg=document.getElementById('pg');if(pg){
    const state={variant:'default',size:'default',disabled:false,loading:false,label:'Save changes',icon:true};
    const prev=document.getElementById('pgPreview'),code=document.getElementById('pgCode');
    const vmap={default:'def',secondary:'sec',outline:'out',ghost:'gho',destructive:'des',link:'link'};
    function dart(){
      let s="Button(";
      if(state.variant!=='default')s+="variant: ButtonVariant."+state.variant+", ";
      if(state.size!=='default')s+="size: ButtonSize."+state.size+", ";
      if(state.disabled)s+="enabled: false, ";
      if(state.loading)s+="loading: true, ";
      if(!state.icon)s+="leading: null, ";
      s+="child: Text('"+state.label+"'))";
      return s;
    }
    function render(){
      const sz=state.size==='sm'?'padding:6px 11px;font-size:12.5px':state.size==='lg'?'padding:12px 20px;font-size:15px':state.size==='icon'?'padding:9px;width:38px;height:38px':'';
      prev.innerHTML='<button class="k-btn '+(vmap[state.variant]||'def')+'" '+(state.disabled?'disabled style="opacity:.45;'+sz+'"':'style="'+sz+'"')+'>'+
        (state.loading?'<span class="mono">◌&nbsp;</span>':'')+(state.icon&&state.size!=='icon'?'<span>＋</span>':'')+
        (state.size==='icon'?'＋':state.loading?'Saving…':state.label)+'</button>';
      code.innerHTML='<span class="f">Button</span>(<span class="k">variant</span>: ButtonVariant.<span class="s">'+state.variant+'</span>, <span class="k">size</span>: ButtonSize.<span class="s">'+state.size+'</span>, <span class="k">child</span>: <span class="f">Text</span>(<span class="s">\''+state.label+'\'</span>))';
      pg.querySelectorAll('[data-v]').forEach(b=>b.classList.toggle('on',b.getAttribute('data-v')===state.variant));
      pg.querySelectorAll('[data-s]').forEach(b=>b.classList.toggle('on',b.getAttribute('data-s')===state.size));
    }
    pg.addEventListener('click',e=>{
      const v=e.target.closest('[data-v]');const s=e.target.closest('[data-s]');
      if(v){state.variant=v.getAttribute('data-v');render();}
      if(s){state.size=s.getAttribute('data-s');render();}
    });
    pg.querySelectorAll('input[data-k]').forEach(i=>i.addEventListener('change',()=>{
      state[i.getAttribute('data-k')]=i.type==='checkbox'?i.checked:i.value;
      if(i.getAttribute('data-k')==='label')state.label=i.value||'Save';
      render();
    }));
    render();
  }
  // theming page: paste -> token table + export
  const paste=document.getElementById('cssIn');
  if(paste){
    const rows=document.getElementById('tokenRows'),prev=document.getElementById('themePrevApp');
    const dartOut=document.getElementById('expDart'),jsonOut=document.getElementById('expJson'),figOut=document.getElementById('expFig');
    const sample="--background: oklch(0.99 0 0);\n--primary: oklch(0.55 0.18 35);\n--radius: 0.625rem;\n--font-sans: Geist;";
    if(!paste.value)paste.value=sample;
    function parse(){
      const txt=paste.value;const get=(n)=>{const m=txt.match(new RegExp(n+'\\s*:\\s*([^;]+);'));return m?m[1].trim():'—';};
      const bg=get('--background'),pri=get('--primary'),rad=get('--radius'),font=get('--font-sans');
      const data=[
        ['color.background',bg,'Color(0xFFFAF8F5)','#FAF8F5'],
        ['color.primary',pri,'Color(0xFFE2552B)','#E2552B'],
        ['radius.md',rad,'Radius.circular(10)','10px'],
        ['font.sans',font,'TextStyle(fontFamily: Geist)','Geist'],
        ['density.compact','0.9','VisualDensity.compact','—'],
        ['shadow.card','0 8px 24px','kShadowCard','soft'],
      ];
      rows.innerHTML=data.map((d,i)=>'<tr style="animation:rowin .3s '+(i*0.06)+'s both"><td class="mono">'+d[0]+'</td><td class="mono">'+d[1]+'</td><td class="mono">'+d[2]+'</td><td><span class="swatch" style="background:'+d[3]+'"></span></td></tr>').join('');
      if(prev){const m=rad.match(/([\d.]+)/);if(m)prev.style.setProperty('--rscale',(parseFloat(m[1])/0.625).toFixed(2));}
      dartOut.textContent="final theme = PlinthTheme(\n  background: "+bg+",\n  primary: "+pri+",\n  radius: "+rad+", // -> Radius.circular(10)\n  font: '"+font+"',\n);";
      jsonOut.textContent=JSON.stringify({background:bg,primary:pri,radius:rad,font:font},null,2);
      figOut.textContent='{"plinth/background": "'+bg+'", "plinth/primary": "'+pri+'", "plinth/radius": "'+rad+'"}';
      document.getElementById('tokCount').textContent=data.length+' / 6 tokens';
    }
    paste.addEventListener('input',parse);parse();
    const st=document.createElement('style');st.textContent='@keyframes rowin{from{opacity:0;transform:translateY(4px)}to{opacity:1}}';document.head.appendChild(st);
  }
  // terminal typer (home)
  const term=document.getElementById('termBody');
  if(term){
    const lines=["$ flutter_shadcn create --template saas","  ✓ scaffold  38 files in 1.2s","  ✓ theme    plinth-ember (light+dark)","  ✓ routes   /onboarding /auth /checkout","$ flutter run -d chrome","  ✓ built   118 widgets · 18 blocks"];
    let li=0;term.innerHTML='<span class="p">$</span> <span id="caret">▌</span>';
    const iv=setInterval(()=>{
      if(li>=lines.length){clearInterval(iv);term.innerHTML=lines.map(l=>l.startsWith('$')?'<div><span class="p">'+l.slice(0,1)+'</span>'+l.slice(1)+'</div>':'<div style="color:#9BD49B">'+l+'</div>').join('');return;}
      term.innerHTML=lines.slice(0,li).map(l=>'<div>'+l+'</div>').join('')+'<div>'+lines[li].slice(0,12)+'▌</div>';li++;
    },420);
  }
})();
