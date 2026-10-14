/* Plinth shared interactions — works from file:// , no dependencies */
(function(){
  const root=document.documentElement;
  // theme
  const saved=localStorage.getItem('plinth-theme');
  if(saved)root.setAttribute('data-theme',saved);
  document.addEventListener('click',e=>{
    const t=e.target.closest('[data-toggle-theme]');
    if(t){const n=root.getAttribute('data-theme')==='dark'?'light':'dark';
      root.setAttribute('data-theme',n);localStorage.setItem('plinth-theme',n);
      t.textContent=n==='dark'?'☀':'◐';}
    const b=e.target.closest('[data-burger]');
    if(b)document.querySelector('.mobile-menu').classList.toggle('open');
    const c=e.target.closest('[data-cmdk-open]');
    if(c)openCmdk();
    if(e.target.classList&&e.target.classList.contains('cmdk'))closeCmdk();
    const cp=e.target.closest('[data-copy]');
    if(cp){navigator.clipboard&&navigator.clipboard.writeText(cp.getAttribute('data-copy'));toast('Copied to clipboard');}
  });
  document.addEventListener('keydown',e=>{
    if((e.metaKey||e.ctrlKey)&&e.key.toLowerCase()==='k'){e.preventDefault();openCmdk();}
    if(e.key==='Escape')closeCmdk();
  });
  function openCmdk(){const m=document.getElementById('cmdk');if(m){m.classList.add('open');const i=m.querySelector('input');i&&i.focus();}}
  function closeCmdk(){const m=document.getElementById('cmdk');m&&m.classList.remove('open');}
  // cmdk filter
  document.addEventListener('input',e=>{
    if(e.target.id==='cmdk-input'){
      const q=e.target.value.toLowerCase();
      document.querySelectorAll('.cmdk-list a').forEach(a=>{a.style.display=a.textContent.toLowerCase().includes(q)?'flex':'none';});
    }
  });
  function toast(msg){let t=document.querySelector('.toast');if(!t){t=document.createElement('div');t.className='toast';document.body.appendChild(t);}t.textContent=msg;t.classList.add('show');clearTimeout(t._h);t._h=setTimeout(()=>t.classList.remove('show'),1600);}
  window.plinthToast=toast;

  /* ---- theme presets (glaze tiles) : [name, bg, fg, primary, radius] ---- */
  window.PRESETS=[
    ['Ember','#FFFFFF','#141414','#E2552B',10],['Paper','#FAF8F5','#1C1A17','#B7791F',8],
    ['Moss','#F4F6EE','#1E2418','#4C7C43',12],['Lagoon','#F2F7F7','#14272B','#0E7C8B',12],
    ['Indigo','#F5F5FA','#1B1B28','#4F46E5',8],['Rose','#FBF3F4','#2B1418','#D33F5E',14],
    ['Noir','#171512','#F2EEE7','#FF7A4D',6],['Mint','#EFF9F2','#12301F','#1F9D55',16]
  ];
  // hero morph: cycles presets every 3s, updates CSS vars + tile state + label
  window.initMorph=function(scope){
    const box=scope||document;let i=0,paused=false;
    const tiles=box.querySelectorAll('[data-tile]');
    const label=box.querySelector('[data-preset-name]');
    const stage=box.querySelector('[data-morph-stage]');
    function apply(p){
      const r=stage||document.documentElement;
      r.style.setProperty('--pv-bg',p[1]);r.style.setProperty('--pv-fg',p[2]);
      r.style.setProperty('--pv-primary',p[3]);r.style.setProperty('--pv-radius',p[4]+'px');
      if(label)label.textContent=p[0]+' · bg '+p[1]+' · '+p[3]+' · r'+p[4];
      tiles.forEach(t=>t.classList.toggle('on',t.getAttribute('data-tile')===p[0]));
    }
    tiles.forEach(t=>t.addEventListener('click',()=>{paused=true;const p=PRESETS.find(x=>x[0]===t.getAttribute('data-tile'));if(p)apply(p);toast('Morph paused — '+t.getAttribute('data-tile'));clearTimeout(window._mp);window._mp=setTimeout(()=>paused=false,12000);}));
    box.querySelectorAll('[data-ruler]').forEach(r=>r.addEventListener('input',()=>{paused=true;clearTimeout(window._mp);window._mp=setTimeout(()=>paused=false,12000);}));
    // radius/density/hue rulers live-apply to preview
    const rr=box.querySelector('[data-ruler="radius"]'),dr=box.querySelector('[data-ruler="density"]'),hr=box.querySelector('[data-ruler="hue"]');
    if(rr)rr.addEventListener('input',()=>{(stage||document.documentElement).style.setProperty('--pv-radius',rr.value+'px');const o=box.querySelector('[data-ruler-val="radius"]');if(o)o.textContent=rr.value+'px';});
    setInterval(()=>{if(paused||document.hidden)return;i=(i+1)%PRESETS.length;apply(PRESETS[i]);},3000);
    apply(PRESETS[0]);
  };
  // platform switcher: swaps frame class
  window.initPlatform=function(scope){
    const box=scope||document;
    const btns=box.querySelectorAll('[data-plat]');
    const frame=box.querySelector('[data-frame]');
    if(!frame||!btns.length)return;
    btns.forEach(b=>b.addEventListener('click',()=>{
      btns.forEach(x=>x.classList.remove('on'));b.classList.add('on');
      frame.className='';frame.setAttribute('class','frame-'+b.getAttribute('data-plat'));
      const tag=box.querySelector('[data-frame-tag]');if(tag)tag.textContent=b.getAttribute('data-plat')+'.dart — same widget';
    }));
  };
  // generic tabs
  window.initTabs=function(scope){
    (scope||document).querySelectorAll('[data-tabs]').forEach(g=>{
      const btns=g.querySelectorAll('[data-tab]');
      const panes=g.parentElement.querySelectorAll(':scope > [data-pane], [data-panes] [data-pane]');
      btns.forEach(b=>b.addEventListener('click',()=>{
        btns.forEach(x=>x.classList.remove('on'));b.classList.add('on');
        panes.forEach(p=>p.style.display=p.getAttribute('data-pane')===b.getAttribute('data-tab')?'':'none');
      }));
    });
  };
})();
