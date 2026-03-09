/**
 * OpenClaw Installer - i18n
 * Default: English. Auto-detect from browser. Manual override via localStorage.
 */
(function () {
  const STORAGE_KEY = 'openclaw_lang';
  const SUPPORTED = ['en', 'zh-CN', 'ja', 'ko', 'es', 'fr', 'de', 'pt', 'ru', 'ar'];
  const LANG_NAMES = { en: 'English', 'zh-CN': '简体中文', ja: '日本語', ko: '한국어', es: 'Español', fr: 'Français', de: 'Deutsch', pt: 'Português', ru: 'Русский', ar: 'العربية' };
  const RTL_LANGS = ['ar'];

  function getStored() { return localStorage.getItem(STORAGE_KEY); }
  function setStored(lang) { localStorage.setItem(STORAGE_KEY, lang); }

  function detectBrowserLang() {
    const raw = (navigator.language || navigator.userLanguage || 'en').toLowerCase();
    const [base] = raw.split('-');
    const full = raw.includes('-') ? raw : raw;
    if (SUPPORTED.includes(full)) return full;
    if (SUPPORTED.includes(base)) return base;
    const map = { zh: 'zh-CN', 'zh-cn': 'zh-CN', 'zh-tw': 'zh-CN', pt: 'pt', 'pt-br': 'pt' };
    return map[full] || map[base] || 'en';
  }

  function getLang() {
    const stored = getStored();
    if (stored && SUPPORTED.includes(stored)) return stored;
    return detectBrowserLang();
  }

  function getNested(obj, path) {
    return path.split('.').reduce((o, k) => (o && o[k] !== undefined ? o[k] : null), obj);
  }

  function applyTranslations(lang) {
    const t = typeof TRANSLATIONS !== 'undefined' ? TRANSLATIONS[lang] : null;
    if (!t) return;

    document.documentElement.lang = lang === 'zh-CN' ? 'zh-CN' : lang.split('-')[0];
    document.documentElement.dir = RTL_LANGS.includes(lang) ? 'rtl' : 'ltr';

    document.querySelectorAll('[data-i18n]').forEach(el => {
      const key = el.getAttribute('data-i18n');
      const val = getNested(t, key);
      if (val != null) {
        if (typeof val === 'string' && val.includes('<')) {
          el.innerHTML = val;
        } else {
          el.textContent = val;
        }
      }
    });

    document.querySelectorAll('[data-i18n-placeholder]').forEach(el => {
      const key = el.getAttribute('data-i18n-placeholder');
      const val = getNested(t, key);
      if (val != null) el.placeholder = val;
    });

    document.querySelectorAll('[data-i18n-html]').forEach(el => {
      const key = el.getAttribute('data-i18n-html');
      const val = getNested(t, key);
      if (val != null) el.innerHTML = val;
    });
  }

  function setLang(lang) {
    if (!SUPPORTED.includes(lang)) return;
    setStored(lang);
    applyTranslations(lang);
    updateLangSelector(lang);
    if (typeof window.onLangChange === 'function') window.onLangChange(lang);
  }

  function updateLangSelector(current) {
    const sel = document.getElementById('lang-select');
    if (sel) sel.value = current;
  }

  function initLangSelector() {
    const sel = document.getElementById('lang-select');
    if (!sel) return;
    if (sel.options.length === 0) {
      SUPPORTED.forEach(code => {
        const opt = document.createElement('option');
        opt.value = code;
        opt.textContent = LANG_NAMES[code] || code;
        sel.appendChild(opt);
      });
    }
    sel.value = getLang();
    sel.addEventListener('change', function () { setLang(this.value); });
  }

  function init() {
    const lang = getLang();
    applyTranslations(lang);
    initLangSelector();
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }

  window.i18n = { setLang, getLang, SUPPORTED };
})();
