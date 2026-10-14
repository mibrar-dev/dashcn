/* Facet shared interactions — file:// safe, no deps */
(function(){
  var root=document.documentElement;
  try{var saved=localStorage.getItem('facet-theme');if(saved)root.setAttribute('data-theme',saved);}catch(e){}
  if(!root.getAttribute('data-theme'))root.setAttribute('data-theme','dark');
  function toggleTheme(){
    var next=root.getAttribute('data-theme')==='dark'?'light':'dark';
    root.setAttribute('data-theme',next);
    try{localStorage.setItem('facet-theme',next);}catch(e){}
    var els=document.querySelectorAll('[data-theme-icon]');
    els.forEach(function(el){el.textContent=next==='dark'?'◐':'◑';});
  }
  document.addEventListener('click',function(e){
    var t=e.target.closest('[data-action]');
    if(!t)return;
    var a=t.getAttribute('data-action');
    if(a==='theme')toggleTheme();
    if(a==='nav'){var n=document.querySelector('.nav-links');if(n)n.classList.toggle('open');}
    if(a==='copy'){var sel=t.getAttribute('data-copy');var txt=sel?document.querySelector(sel):null;
      var s=txt?txt.innerText:t.innerText;
      if(navigator.clipboard)navigator.clipboard.writeText(s).catch(function(){});
      t.textContent='Copied';setTimeout(function(){t.textContent='Copy';},1200);}
    if(a==='zoom'){document.querySelectorAll('.screen.zoomed').forEach(function(s){if(s!==t.closest('.screen'))s.classList.remove('zoomed');});
      var sc=t.closest('.screen');if(sc)sc.classList.toggle('zoomed');}
  });
  document.addEventListener('keydown',function(e){
    if((e.metaKey||e.ctrlKey)&&e.key.toLowerCase()==='k'){e.preventDefault();var s=document.querySelector('#cmdk');if(s)s.style.display=s.style.display==='grid'?'none':'grid';}
    if(e.key==='Escape'){var s2=document.querySelector('#cmdk');if(s2)s2.style.display='none';}
  });
})();
