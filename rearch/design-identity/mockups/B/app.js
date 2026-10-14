/* Kiln shared interactions */
(function(){
  const root=document.documentElement;
  // theme toggle (persist)
  try{const s=localStorage.getItem('kiln-theme');if(s)root.setAttribute('data-theme',s);}catch(e){}
  window.kilnTheme=function(){
    const n=root.getAttribute('data-theme')==='dark'?'light':'dark';
    root.setAttribute('data-theme',n);
    try{localStorage.setItem('kiln-theme',n);}catch(e){}
    document.querySelectorAll('[data-theme-icon]').forEach(el=>el.textContent=n==='dark'?'☾':'☀');
  };
  // mobile nav
  window.kilnMenu=function(){document.getElementById('mmenu').classList.toggle('open');};
  // cmdk
  const pages=[['Home','home.html'],['Theming — The Kiln','theming.html'],['Button component','component.html'],['Chooser','index.html'],['Install — flutter_shadcn add button','component.html'],['Presets — 42 themes','theming.html'],['Motion Lab','home.html#motion'],['Recipes','home.html#recipes']];
  window.kilnSearch=function(){document.getElementById('cmdk').classList.add('open');const i=document.getElementById('cmdk-input');if(i){i.value='';i.focus();renderCmdk('');}};
  window.kilnCloseSearch=function(e){if(e&&e.target&&e.target.id!=='cmdk')return;document.getElementById('cmdk').classList.remove('open');};
  window.renderCmdk=function(q){
    const box=document.getElementById('cmdk-list');if(!box)return;
    const f=pages.filter(p=>p[0].toLowerCase().includes(q.toLowerCase()));
    box.innerHTML=f.map(p=>`<div class="cmdk-item" onclick="location.href='${p[1]}'"><span>${p[0]}</span><span>↵</span></div>`).join('')||'<div class="cmdk-item"><span>No match</span><span></span></div>';
  };
  document.addEventListener('keydown',e=>{
    if((e.metaKey||e.ctrlKey)&&e.key.toLowerCase()==='k'){e.preventDefault();window.kilnSearch();}
    if(e.key==='Escape'){const c=document.getElementById('cmdk');if(c)c.classList.remove('open');}
  });
  // glaze presets
  window.GLAZES={
    'Caffeine':{a:'#9A3F16',bg:'#F6F1EA',ink:'#1A1714',r:'10px',t1:'#C96B2C',t2:'#5C2A0E',tileBg:'#F3E4CF'},
    'Ocean Breeze':{a:'#0E6E6E',bg:'#EDF4F1',ink:'#12211F',r:'12px',t1:'#3FB3A8',t2:'#0E4A5E',tileBg:'#DCEDE8'},
    'Neo Brutalism':{a:'#1A1714',bg:'#FFFDF4',ink:'#111111',r:'2px',t1:'#FFD02F',t2:'#FF5C38',tileBg:'#FFF3C4'},
    'Vintage Paper':{a:'#7A2E1D',bg:'#F1E7D0',ink:'#3A2A1C',r:'4px',t1:'#C9A227',t2:'#7A2E1D',tileBg:'#EADFC2'},
    'Cosmic Night':{a:'#8B7CFF',bg:'#14121E',ink:'#EDEAFF',r:'16px',t1:'#3B2E8F',t2:'#0E0B1E',tileBg:'#221D3D'},
    'Sage Garden':{a:'#4A7C59',bg:'#EFF3E8',ink:'#1E2B22',r:'14px',t1:'#9DBE8C',t2:'#2F5D3A',tileBg:'#DDE8CF'},
    'Tangerine':{a:'#E4572E',bg:'#FFF3E8',ink:'#2A1A12',r:'18px',t1:'#FFB03A',t2:'#E4572E',tileBg:'#FFE3C2'},
    'Mono':{a:'#111111',bg:'#FAFAFA',ink:'#111111',r:'6px',t1:'#E5E5E5',t2:'#555555',tileBg:'#EEEEEE'}
  };
  // morph engine: apply glaze vars onto a scope element with slow lerp
  window.applyGlaze=function(name,scope){
    const g=window.GLAZES[name];if(!g)return;
    const el=typeof scope==='string'?document.querySelector(scope):scope;if(!el)return;
    el.style.setProperty('--a',g.a);el.style.setProperty('--r',g.r);
    if(el.classList.contains('stage-scope')||el.id==='stage'||el.id==='kiln-canvas'){
      el.style.transition='--a .6s,background .6s,color .6s';
      el.style.background=g.bg;el.style.color=g.ink;el.style.setProperty('--bg',g.bg);el.style.setProperty('--ink',g.ink);
    }
    document.querySelectorAll('.tile').forEach(t=>t.classList.toggle('sel',t.dataset.glaze===name));
    const label=document.getElementById('stage-name')||document.getElementById('canvas-name');
    if(label)label.textContent=name;
    const code=document.getElementById('stage-token-code');
    if(code)code.textContent=`KilnTheme glaze: ${name.toLowerCase().replace(/ /g,'_')}  ·  accent ${g.a}  ·  radius ${g.r}  ·  bg ${g.bg}`;
  };
  window.copyText=function(t,btn){
    navigator.clipboard&&navigator.clipboard.writeText(t);
    if(btn){const o=btn.textContent;btn.textContent='Copied ✓';setTimeout(()=>btn.textContent=o,1400);}
  };
})();
