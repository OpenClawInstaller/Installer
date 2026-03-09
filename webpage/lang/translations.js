/* OpenClaw Installer - 10 languages: en, zh-CN, ja, ko, es, fr, de, pt, ru, ar */
const TRANSLATIONS = {
  en: {
    nav: { home: 'Home', download: 'Download', github: 'GitHub', openclaw_site: 'OpenClaw' },
    hero: {
      title: 'OpenClaw Graphical Installer',
      subtitle: 'Cross-platform graphical installer for <a href="https://openclaw.ai" target="_blank" rel="noopener">OpenClaw</a> open-source personal AI assistant',
      desc: 'Supports Windows, macOS and Linux. One-click install and configuration.',
      download: 'Download Now',
      source: 'View Source'
    },
    features: {
      title: 'Features',
      dual_mode: { title: 'Dual Install Modes', desc: 'Local npm install and Docker container install for different use cases' },
      env_check: { title: 'Environment Detection', desc: 'Auto-detect Node.js 22+ and Docker, smart configuration guidance' },
      deps_guide: { title: 'Dependency Guide', desc: 'Official Node.js / Docker download links when environment is missing' },
      one_click: { title: 'One-Click Install', desc: 'Graphical UI for install and config, no command line required' }
    },
    platforms: { title: 'Supported Platforms', windows: 'Windows', macos: 'macOS', linux: 'Linux' },
    requirements: {
      title: 'System Requirements',
      local: { title: 'Local (npm)', items: ['Node.js 22+ (LTS recommended)', 'npm 10+ or pnpm 9+'] },
      docker: { title: 'Docker', items: ['Docker Desktop (Windows/macOS)', 'Docker Engine (Linux)'] }
    },
    about: {
      title: 'About OpenClaw',
      intro: 'OpenClaw is an open-source personal AI assistant supporting:',
      features: ['WhatsApp, Telegram, Discord, Slack, Signal, iMessage and more', 'Persistent memory and personalized config', 'Browser control, file access, skill extensions'],
      visit: 'Visit OpenClaw →'
    },
    cta: { title: 'Get Started', desc: 'Choose your OS, download and install OpenClaw Installer', btn: 'Download' },
    footer: { license: 'OpenClaw Installer is open source under <a href="https://opensource.org/licenses/MIT" target="_blank" rel="noopener">MIT</a>', repo: 'GitHub', site: 'OpenClaw' },
    download_page: {
      title: 'Download OpenClaw Installer',
      subtitle: 'Choose your OS and get the latest from GitHub Releases',
      windows: { title: 'Windows', desc: 'Desktop installer for Windows 10/11', btn: 'Download on GitHub', note: 'Download <code>.exe</code> or <code>.msix</code>' },
      macos: { title: 'macOS', desc: 'For Intel and Apple Silicon (M1/M2/M3) Mac', btn: 'Download on GitHub', note: 'Download <code>.dmg</code> or <code>.app</code>' },
      linux: { title: 'Linux', desc: 'For x64 Linux desktop', btn: 'Download on GitHub', note: 'Download <code>.AppImage</code> or <code>.deb</code>' },
      steps: {
        title: 'Installation Steps',
        step1: { title: 'Choose Install Mode', p1: 'Local: npm global install, requires Node.js 22+', p2: 'Docker: official image, requires Docker' },
        step2: { title: 'Environment Check', p: 'If Node.js or Docker is missing, the installer shows download links. After installing, restart and click "Re-check".' },
        step3: { title: 'Install', p1: 'Local: run npm install -g openclaw@latest and config wizard', p2: 'Docker: pull ghcr.io/openclaw/openclaw:latest and start container' },
        step4: { title: 'Done', p: 'Open control panel <a href="http://127.0.0.1:18789/" target="_blank" rel="noopener">http://127.0.0.1:18789/</a> for first-time setup' }
      },
      build: { title: 'Build from Source', intro_html: 'To build yourself, install <a href="https://flutter.dev" target="_blank" rel="noopener">Flutter</a>, then run:' },
      issues: 'Having issues? Report on'
    }
  },
  'zh-CN': {
    nav: { home: '首页', download: '下载', github: 'GitHub', openclaw_site: 'OpenClaw 官网' },
    hero: {
      title: 'OpenClaw 图形化安装器',
      subtitle: '为 <a href="https://openclaw.ai" target="_blank" rel="noopener">OpenClaw</a> 开源个人 AI 助手提供的跨平台图形化安装程序',
      desc: '支持 Windows、macOS 和 Linux 桌面系统，一键完成安装与配置',
      download: '立即下载',
      source: '查看源码'
    },
    features: {
      title: '功能特性',
      dual_mode: { title: '双安装模式', desc: '支持本地 npm 安装和 Docker 容器安装，满足不同使用场景' },
      env_check: { title: '环境检测', desc: '自动检测 Node.js 22+ 和 Docker 是否已安装，智能引导配置' },
      deps_guide: { title: '依赖引导', desc: '缺少环境时提供 Node.js / Docker 官方下载链接，一键跳转' },
      one_click: { title: '一键安装', desc: '图形化界面完成 OpenClaw 的安装与配置，无需命令行操作' }
    },
    platforms: { title: '支持平台', windows: 'Windows', macos: 'macOS', linux: 'Linux' },
    requirements: {
      title: '系统要求',
      local: { title: '本地安装 (npm)', items: ['Node.js 22+（推荐 LTS 版本）', 'npm 10+ 或 pnpm 9+'] },
      docker: { title: 'Docker 安装', items: ['Docker Desktop（Windows/macOS）', 'Docker Engine（Linux）'] }
    },
    about: {
      title: '关于 OpenClaw',
      intro: 'OpenClaw 是开源的个人 AI 助手，支持：',
      features: ['WhatsApp、Telegram、Discord、Slack、Signal、iMessage 等通讯渠道', '持久化记忆与个性化配置', '浏览器控制、文件访问、技能扩展等'],
      visit: '访问 OpenClaw 官网 →'
    },
    cta: { title: '开始使用', desc: '选择您的操作系统，下载并安装 OpenClaw Installer', btn: '前往下载' },
    footer: { license: 'OpenClaw Installer 采用 <a href="https://opensource.org/licenses/MIT" target="_blank" rel="noopener">MIT</a> 许可证开源', repo: 'GitHub 仓库', site: 'OpenClaw 官网' },
    download_page: {
      title: '下载 OpenClaw Installer',
      subtitle: '选择您的操作系统，从 GitHub Releases 获取最新版本',
      windows: { title: 'Windows', desc: '适用于 Windows 10/11 的桌面安装程序', btn: '前往 GitHub 下载', note: '下载 <code>.exe</code> 或 <code>.msix</code> 安装包' },
      macos: { title: 'macOS', desc: '适用于 Intel 和 Apple Silicon (M1/M2/M3) Mac', btn: '前往 GitHub 下载', note: '下载 <code>.dmg</code> 或 <code>.app</code> 应用包' },
      linux: { title: 'Linux', desc: '适用于 x64 架构的 Linux 桌面系统', btn: '前往 GitHub 下载', note: '下载 <code>.AppImage</code> 或 <code>.deb</code> 包' },
      steps: {
        title: '安装流程',
        step1: { title: '选择安装方式', p1: '本地安装：通过 npm 全局安装，需要 Node.js 22+', p2: 'Docker 安装：使用官方镜像运行，需要 Docker' },
        step2: { title: '环境检测', p: '若缺少 Node.js 或 Docker，安装器会显示官方下载链接。安装完成后重启安装器，点击「重新检测」' },
        step3: { title: '执行安装', p1: '本地：执行 npm install -g openclaw@latest 并运行配置向导', p2: 'Docker：拉取 ghcr.io/openclaw/openclaw:latest 并启动容器' },
        step4: { title: '完成', p: '打开控制面板 <a href="http://127.0.0.1:18789/" target="_blank" rel="noopener">http://127.0.0.1:18789/</a> 完成首次配置' }
      },
      build: { title: '从源码构建', intro_html: '如需自行构建，请确保已安装 <a href="https://flutter.dev" target="_blank" rel="noopener">Flutter</a>，然后执行：' },
      issues: '遇到问题？欢迎在'
    }
  },
  ja: {
    nav: { home: 'ホーム', download: 'ダウンロード', github: 'GitHub', openclaw_site: 'OpenClaw' },
    hero: {
      title: 'OpenClaw グラフィカルインストーラー',
      subtitle: '<a href="https://openclaw.ai" target="_blank" rel="noopener">OpenClaw</a> オープンソース個人AIアシスタント用のクロスプラットフォームインストーラー',
      desc: 'Windows、macOS、Linux対応。ワンクリックでインストールと設定が完了',
      download: '今すぐダウンロード',
      source: 'ソースを表示'
    },
    features: {
      title: '機能',
      dual_mode: { title: 'デュアルインストール', desc: 'ローカルnpmとDockerコンテナの2つのインストールモード' },
      env_check: { title: '環境検出', desc: 'Node.js 22+とDockerを自動検出、スマート設定ガイド' },
      deps_guide: { title: '依存関係ガイド', desc: '環境が不足している場合の公式ダウンロードリンク' },
      one_click: { title: 'ワンクリックインストール', desc: 'GUIでインストールと設定、コマンドライン不要' }
    },
    platforms: { title: '対応プラットフォーム', windows: 'Windows', macos: 'macOS', linux: 'Linux' },
    requirements: {
      title: 'システム要件',
      local: { title: 'ローカル (npm)', items: ['Node.js 22+（LTS推奨）', 'npm 10+ または pnpm 9+'] },
      docker: { title: 'Docker', items: ['Docker Desktop（Windows/macOS）', 'Docker Engine（Linux）'] }
    },
    about: {
      title: 'OpenClawについて',
      intro: 'OpenClawはオープンソースの個人AIアシスタントで、以下をサポート：',
      features: ['WhatsApp、Telegram、Discord、Slack、Signal、iMessageなど', '永続メモリとパーソナライズ設定', 'ブラウザ制御、ファイルアクセス、スキル拡張'],
      visit: 'OpenClaw公式サイトへ →'
    },
    cta: { title: '始める', desc: 'OSを選択してOpenClaw Installerをダウンロード', btn: 'ダウンロード' },
    footer: { license: 'OpenClaw Installerは <a href="https://opensource.org/licenses/MIT" target="_blank" rel="noopener">MIT</a> ライセンスのオープンソースです', repo: 'GitHub', site: 'OpenClaw' },
    download_page: {
      title: 'OpenClaw Installer をダウンロード',
      subtitle: 'OSを選択してGitHub Releasesから最新版を取得',
      windows: { title: 'Windows', desc: 'Windows 10/11用デスクトップインストーラー', btn: 'GitHubでダウンロード', note: '<code>.exe</code> または <code>.msix</code>' },
      macos: { title: 'macOS', desc: 'IntelおよびApple Silicon (M1/M2/M3) Mac対応', btn: 'GitHubでダウンロード', note: '<code>.dmg</code> または <code>.app</code>' },
      linux: { title: 'Linux', desc: 'x64 Linuxデスクトップ用', btn: 'GitHubでダウンロード', note: '<code>.AppImage</code> または <code>.deb</code>' },
      steps: { title: 'インストール手順', step1: { title: 'インストールモード選択', p1: 'ローカル: npmグローバル、Node.js 22+必要', p2: 'Docker: 公式イメージ、Docker必要' }, step2: { title: '環境チェック', p: 'Node.jsまたはDockerが不足している場合、リンクを表示。インストール後、再起動して「再チェック」をクリック' }, step3: { title: 'インストール', p1: 'ローカル: npm install -g openclaw@latest と設定ウィザード', p2: 'Docker: ghcr.io/openclaw/openclaw:latest をプルして起動' }, step4: { title: '完了', p: '<a href="http://127.0.0.1:18789/" target="_blank" rel="noopener">http://127.0.0.1:18789/</a> で初回設定' } },
      build: { title: 'ソースからビルド', intro_html: 'ビルドするには <a href="https://flutter.dev" target="_blank" rel="noopener">Flutter</a> をインストールして実行：' },
      issues: '問題があれば'
    }
  },
  ko: {
    nav: { home: '홈', download: '다운로드', github: 'GitHub', openclaw_site: 'OpenClaw' },
    hero: {
      title: 'OpenClaw 그래픽 설치 프로그램',
      subtitle: '<a href="https://openclaw.ai" target="_blank" rel="noopener">OpenClaw</a> 오픈소스 개인 AI 어시스턴트용 크로스 플랫폼 설치 프로그램',
      desc: 'Windows, macOS, Linux 지원. 원클릭 설치 및 설정',
      download: '지금 다운로드',
      source: '소스 보기'
    },
    features: {
      title: '기능',
      dual_mode: { title: '듀얼 설치 모드', desc: '로컬 npm 및 Docker 컨테이너 설치 지원' },
      env_check: { title: '환경 감지', desc: 'Node.js 22+ 및 Docker 자동 감지' },
      deps_guide: { title: '의존성 가이드', desc: '환경 누락 시 공식 다운로드 링크 제공' },
      one_click: { title: '원클릭 설치', desc: 'GUI로 설치 및 설정, 명령줄 불필요' }
    },
    platforms: { title: '지원 플랫폼', windows: 'Windows', macos: 'macOS', linux: 'Linux' },
    requirements: {
      title: '시스템 요구사항',
      local: { title: '로컬 (npm)', items: ['Node.js 22+ (LTS 권장)', 'npm 10+ 또는 pnpm 9+'] },
      docker: { title: 'Docker', items: ['Docker Desktop (Windows/macOS)', 'Docker Engine (Linux)'] }
    },
    about: {
      title: 'OpenClaw 소개',
      intro: 'OpenClaw는 오픈소스 개인 AI 어시스턴트로 지원:',
      features: ['WhatsApp, Telegram, Discord, Slack, Signal, iMessage 등', '영구 메모리 및 개인화 설정', '브라우저 제어, 파일 액세스, 스킬 확장'],
      visit: 'OpenClaw 방문 →'
    },
    cta: { title: '시작하기', desc: 'OS를 선택하여 OpenClaw Installer 다운로드', btn: '다운로드' },
    footer: { license: 'OpenClaw Installer는 <a href="https://opensource.org/licenses/MIT" target="_blank" rel="noopener">MIT</a> 라이선스 오픈소스입니다', repo: 'GitHub', site: 'OpenClaw' },
    download_page: {
      title: 'OpenClaw Installer 다운로드',
      subtitle: 'OS를 선택하여 GitHub Releases에서 최신 버전 받기',
      windows: { title: 'Windows', desc: 'Windows 10/11용 데스크톱 설치 프로그램', btn: 'GitHub에서 다운로드', note: '<code>.exe</code> 또는 <code>.msix</code>' },
      macos: { title: 'macOS', desc: 'Intel 및 Apple Silicon (M1/M2/M3) Mac 지원', btn: 'GitHub에서 다운로드', note: '<code>.dmg</code> 또는 <code>.app</code>' },
      linux: { title: 'Linux', desc: 'x64 Linux 데스크톱용', btn: 'GitHub에서 다운로드', note: '<code>.AppImage</code> 또는 <code>.deb</code>' },
      steps: { title: '설치 단계', step1: { title: '설치 모드 선택', p1: '로컬: npm 전역, Node.js 22+ 필요', p2: 'Docker: 공식 이미지, Docker 필요' }, step2: { title: '환경 확인', p: 'Node.js 또는 Docker가 없으면 링크 표시. 설치 후 재시작하고 "재확인" 클릭' }, step3: { title: '설치', p1: '로컬: npm install -g openclaw@latest 및 설정 마법사', p2: 'Docker: ghcr.io/openclaw/openclaw:latest 풀 후 컨테이너 시작' }, step4: { title: '완료', p: '<a href="http://127.0.0.1:18789/" target="_blank" rel="noopener">http://127.0.0.1:18789/</a> 에서 초기 설정' } },
      build: { title: '소스에서 빌드', intro_html: '빌드하려면 <a href="https://flutter.dev" target="_blank" rel="noopener">Flutter</a>를 설치한 후 실행:' },
      issues: '문제가 있으면'
    }
  },
  es: {
    nav: { home: 'Inicio', download: 'Descargar', github: 'GitHub', openclaw_site: 'OpenClaw' },
    hero: {
      title: 'Instalador gráfico de OpenClaw',
      subtitle: 'Instalador multiplataforma para el asistente de IA personal <a href="https://openclaw.ai" target="_blank" rel="noopener">OpenClaw</a> de código abierto',
      desc: 'Soporta Windows, macOS y Linux. Instalación y configuración con un clic.',
      download: 'Descargar ahora',
      source: 'Ver código'
    },
    features: {
      title: 'Características',
      dual_mode: { title: 'Dos modos de instalación', desc: 'Instalación local con npm y con contenedor Docker' },
      env_check: { title: 'Detección de entorno', desc: 'Detecta Node.js 22+ y Docker automáticamente' },
      deps_guide: { title: 'Guía de dependencias', desc: 'Enlaces de descarga oficiales cuando falta el entorno' },
      one_click: { title: 'Instalación con un clic', desc: 'Interfaz gráfica, sin línea de comandos' }
    },
    platforms: { title: 'Plataformas soportadas', windows: 'Windows', macos: 'macOS', linux: 'Linux' },
    requirements: {
      title: 'Requisitos del sistema',
      local: { title: 'Local (npm)', items: ['Node.js 22+ (LTS recomendado)', 'npm 10+ o pnpm 9+'] },
      docker: { title: 'Docker', items: ['Docker Desktop (Windows/macOS)', 'Docker Engine (Linux)'] }
    },
    about: {
      title: 'Acerca de OpenClaw',
      intro: 'OpenClaw es un asistente de IA personal de código abierto que soporta:',
      features: ['WhatsApp, Telegram, Discord, Slack, Signal, iMessage y más', 'Memoria persistente y configuración personalizada', 'Control del navegador, acceso a archivos, extensiones'],
      visit: 'Visitar OpenClaw →'
    },
    cta: { title: 'Comenzar', desc: 'Elige tu SO, descarga e instala OpenClaw Installer', btn: 'Descargar' },
    footer: { license: 'OpenClaw Installer es código abierto bajo <a href="https://opensource.org/licenses/MIT" target="_blank" rel="noopener">MIT</a>', repo: 'GitHub', site: 'OpenClaw' },
    download_page: {
      title: 'Descargar OpenClaw Installer',
      subtitle: 'Elige tu SO y obtén la última versión en GitHub Releases',
      windows: { title: 'Windows', desc: 'Instalador para Windows 10/11', btn: 'Descargar en GitHub', note: '<code>.exe</code> o <code>.msix</code>' },
      macos: { title: 'macOS', desc: 'Para Intel y Apple Silicon (M1/M2/M3)', btn: 'Descargar en GitHub', note: '<code>.dmg</code> o <code>.app</code>' },
      linux: { title: 'Linux', desc: 'Para Linux x64', btn: 'Descargar en GitHub', note: '<code>.AppImage</code> o <code>.deb</code>' },
      steps: { title: 'Pasos de instalación', step1: { title: 'Elegir modo', p1: 'Local: npm global, requiere Node.js 22+', p2: 'Docker: imagen oficial, requiere Docker' }, step2: { title: 'Verificar entorno', p: 'Si falta Node.js o Docker, se muestran enlaces. Tras instalar, reinicia y haz clic en "Re-verificar"' }, step3: { title: 'Instalar', p1: 'Local: npm install -g openclaw@latest y asistente', p2: 'Docker: pull ghcr.io/openclaw/openclaw:latest y arrancar' }, step4: { title: 'Listo', p: 'Abre <a href="http://127.0.0.1:18789/" target="_blank" rel="noopener">http://127.0.0.1:18789/</a> para la configuración inicial' } },
      build: { title: 'Compilar desde fuente', intro_html: 'Para compilar, instala <a href="https://flutter.dev" target="_blank" rel="noopener">Flutter</a> y ejecuta:' },
      issues: '¿Problemas? Reporta en'
    }
  },
  fr: {
    nav: { home: 'Accueil', download: 'Télécharger', github: 'GitHub', openclaw_site: 'OpenClaw' },
    hero: {
      title: 'Installateur graphique OpenClaw',
      subtitle: 'Installateur multiplateforme pour l\'assistant IA personnel <a href="https://openclaw.ai" target="_blank" rel="noopener">OpenClaw</a> open source',
      desc: 'Windows, macOS et Linux. Installation et configuration en un clic.',
      download: 'Télécharger',
      source: 'Voir le code'
    },
    features: {
      title: 'Fonctionnalités',
      dual_mode: { title: 'Deux modes d\'installation', desc: 'Installation locale npm et conteneur Docker' },
      env_check: { title: 'Détection d\'environnement', desc: 'Détection automatique de Node.js 22+ et Docker' },
      deps_guide: { title: 'Guide des dépendances', desc: 'Liens de téléchargement officiels si l\'environnement manque' },
      one_click: { title: 'Installation en un clic', desc: 'Interface graphique, pas de ligne de commande' }
    },
    platforms: { title: 'Plateformes supportées', windows: 'Windows', macos: 'macOS', linux: 'Linux' },
    requirements: {
      title: 'Configuration requise',
      local: { title: 'Local (npm)', items: ['Node.js 22+ (LTS recommandé)', 'npm 10+ ou pnpm 9+'] },
      docker: { title: 'Docker', items: ['Docker Desktop (Windows/macOS)', 'Docker Engine (Linux)'] }
    },
    about: {
      title: 'À propos d\'OpenClaw',
      intro: 'OpenClaw est un assistant IA personnel open source qui prend en charge :',
      features: ['WhatsApp, Telegram, Discord, Slack, Signal, iMessage, etc.', 'Mémoire persistante et configuration personnalisée', 'Contrôle du navigateur, accès aux fichiers, extensions'],
      visit: 'Visiter OpenClaw →'
    },
    cta: { title: 'Commencer', desc: 'Choisissez votre OS, téléchargez et installez OpenClaw Installer', btn: 'Télécharger' },
    footer: { license: 'OpenClaw Installer est open source sous <a href="https://opensource.org/licenses/MIT" target="_blank" rel="noopener">MIT</a>', repo: 'GitHub', site: 'OpenClaw' },
    download_page: {
      title: 'Télécharger OpenClaw Installer',
      subtitle: 'Choisissez votre OS et récupérez la dernière version sur GitHub Releases',
      windows: { title: 'Windows', desc: 'Installateur pour Windows 10/11', btn: 'Télécharger sur GitHub', note: '<code>.exe</code> ou <code>.msix</code>' },
      macos: { title: 'macOS', desc: 'Pour Intel et Apple Silicon (M1/M2/M3)', btn: 'Télécharger sur GitHub', note: '<code>.dmg</code> ou <code>.app</code>' },
      linux: { title: 'Linux', desc: 'Pour Linux x64', btn: 'Télécharger sur GitHub', note: '<code>.AppImage</code> ou <code>.deb</code>' },
      steps: { title: 'Étapes d\'installation', step1: { title: 'Choisir le mode', p1: 'Local : npm global, Node.js 22+ requis', p2: 'Docker : image officielle, Docker requis' }, step2: { title: 'Vérifier l\'environnement', p: 'Si Node.js ou Docker manque, liens affichés. Après installation, redémarrer et cliquer "Re-vérifier"' }, step3: { title: 'Installer', p1: 'Local : npm install -g openclaw@latest et assistant', p2: 'Docker : pull ghcr.io/openclaw/openclaw:latest et démarrer' }, step4: { title: 'Terminé', p: 'Ouvrir <a href="http://127.0.0.1:18789/" target="_blank" rel="noopener">http://127.0.0.1:18789/</a> pour la configuration initiale' } },
      build: { title: 'Compiler depuis les sources', intro_html: 'Pour compiler, installez <a href="https://flutter.dev" target="_blank" rel="noopener">Flutter</a> puis exécutez :' },
      issues: 'Problèmes ? Signalez sur'
    }
  },
  de: {
    nav: { home: 'Startseite', download: 'Download', github: 'GitHub', openclaw_site: 'OpenClaw' },
    hero: {
      title: 'OpenClaw grafischer Installer',
      subtitle: 'Plattformübergreifender Installer für den Open-Source-Persönlichen-KI-Assistenten <a href="https://openclaw.ai" target="_blank" rel="noopener">OpenClaw</a>',
      desc: 'Windows, macOS und Linux. Ein-Klick-Installation und -Konfiguration.',
      download: 'Jetzt herunterladen',
      source: 'Quellcode anzeigen'
    },
    features: {
      title: 'Funktionen',
      dual_mode: { title: 'Zwei Installationsmodi', desc: 'Lokale npm- und Docker-Container-Installation' },
      env_check: { title: 'Umgebungserkennung', desc: 'Automatische Erkennung von Node.js 22+ und Docker' },
      deps_guide: { title: 'Abhängigkeits-Guide', desc: 'Offizielle Download-Links bei fehlender Umgebung' },
      one_click: { title: 'Ein-Klick-Installation', desc: 'Grafische Oberfläche, keine Befehlszeile nötig' }
    },
    platforms: { title: 'Unterstützte Plattformen', windows: 'Windows', macos: 'macOS', linux: 'Linux' },
    requirements: {
      title: 'Systemanforderungen',
      local: { title: 'Lokal (npm)', items: ['Node.js 22+ (LTS empfohlen)', 'npm 10+ oder pnpm 9+'] },
      docker: { title: 'Docker', items: ['Docker Desktop (Windows/macOS)', 'Docker Engine (Linux)'] }
    },
    about: {
      title: 'Über OpenClaw',
      intro: 'OpenClaw ist ein Open-Source-Persönlicher-KI-Assistent mit Unterstützung für:',
      features: ['WhatsApp, Telegram, Discord, Slack, Signal, iMessage und mehr', 'Persistenter Speicher und personalisierte Konfiguration', 'Browsersteuerung, Dateizugriff, Erweiterungen'],
      visit: 'OpenClaw besuchen →'
    },
    cta: { title: 'Loslegen', desc: 'Wählen Sie Ihr OS, laden Sie OpenClaw Installer herunter', btn: 'Download' },
    footer: { license: 'OpenClaw Installer ist Open Source unter <a href="https://opensource.org/licenses/MIT" target="_blank" rel="noopener">MIT</a>', repo: 'GitHub', site: 'OpenClaw' },
    download_page: {
      title: 'OpenClaw Installer herunterladen',
      subtitle: 'Wählen Sie Ihr OS und holen Sie die neueste Version von GitHub Releases',
      windows: { title: 'Windows', desc: 'Desktop-Installer für Windows 10/11', btn: 'Auf GitHub herunterladen', note: '<code>.exe</code> oder <code>.msix</code>' },
      macos: { title: 'macOS', desc: 'Für Intel und Apple Silicon (M1/M2/M3)', btn: 'Auf GitHub herunterladen', note: '<code>.dmg</code> oder <code>.app</code>' },
      linux: { title: 'Linux', desc: 'Für x64 Linux Desktop', btn: 'Auf GitHub herunterladen', note: '<code>.AppImage</code> oder <code>.deb</code>' },
      steps: { title: 'Installationsschritte', step1: { title: 'Modus wählen', p1: 'Lokal: npm global, Node.js 22+ erforderlich', p2: 'Docker: offizielles Image, Docker erforderlich' }, step2: { title: 'Umgebung prüfen', p: 'Fehlt Node.js oder Docker, werden Links angezeigt. Nach Installation neu starten und "Erneut prüfen" klicken' }, step3: { title: 'Installieren', p1: 'Lokal: npm install -g openclaw@latest und Assistent', p2: 'Docker: ghcr.io/openclaw/openclaw:latest pullen und starten' }, step4: { title: 'Fertig', p: '<a href="http://127.0.0.1:18789/" target="_blank" rel="noopener">http://127.0.0.1:18789/</a> für die Erstkonfiguration öffnen' } },
      build: { title: 'Aus Quellcode bauen', intro_html: 'Zum Bauen installieren Sie <a href="https://flutter.dev" target="_blank" rel="noopener">Flutter</a> und führen aus:' },
      issues: 'Probleme? Melden Sie sich bei'
    }
  },
  pt: {
    nav: { home: 'Início', download: 'Download', github: 'GitHub', openclaw_site: 'OpenClaw' },
    hero: {
      title: 'Instalador gráfico OpenClaw',
      subtitle: 'Instalador multiplataforma para o assistente de IA pessoal <a href="https://openclaw.ai" target="_blank" rel="noopener">OpenClaw</a> de código aberto',
      desc: 'Suporta Windows, macOS e Linux. Instalação e configuração com um clique.',
      download: 'Baixar agora',
      source: 'Ver código'
    },
    features: {
      title: 'Recursos',
      dual_mode: { title: 'Dois modos de instalação', desc: 'Instalação local npm e contêiner Docker' },
      env_check: { title: 'Detecção de ambiente', desc: 'Detecta automaticamente Node.js 22+ e Docker' },
      deps_guide: { title: 'Guia de dependências', desc: 'Links oficiais quando o ambiente está ausente' },
      one_click: { title: 'Instalação com um clique', desc: 'Interface gráfica, sem linha de comando' }
    },
    platforms: { title: 'Plataformas suportadas', windows: 'Windows', macos: 'macOS', linux: 'Linux' },
    requirements: {
      title: 'Requisitos do sistema',
      local: { title: 'Local (npm)', items: ['Node.js 22+ (LTS recomendado)', 'npm 10+ ou pnpm 9+'] },
      docker: { title: 'Docker', items: ['Docker Desktop (Windows/macOS)', 'Docker Engine (Linux)'] }
    },
    about: {
      title: 'Sobre o OpenClaw',
      intro: 'OpenClaw é um assistente de IA pessoal de código aberto que suporta:',
      features: ['WhatsApp, Telegram, Discord, Slack, Signal, iMessage e mais', 'Memória persistente e configuração personalizada', 'Controle do navegador, acesso a arquivos, extensões'],
      visit: 'Visitar OpenClaw →'
    },
    cta: { title: 'Começar', desc: 'Escolha seu SO, baixe e instale o OpenClaw Installer', btn: 'Download' },
    footer: { license: 'OpenClaw Installer é código aberto sob <a href="https://opensource.org/licenses/MIT" target="_blank" rel="noopener">MIT</a>', repo: 'GitHub', site: 'OpenClaw' },
    download_page: {
      title: 'Baixar OpenClaw Installer',
      subtitle: 'Escolha seu SO e obtenha a versão mais recente no GitHub Releases',
      windows: { title: 'Windows', desc: 'Instalador para Windows 10/11', btn: 'Baixar no GitHub', note: '<code>.exe</code> ou <code>.msix</code>' },
      macos: { title: 'macOS', desc: 'Para Intel e Apple Silicon (M1/M2/M3)', btn: 'Baixar no GitHub', note: '<code>.dmg</code> ou <code>.app</code>' },
      linux: { title: 'Linux', desc: 'Para Linux x64', btn: 'Baixar no GitHub', note: '<code>.AppImage</code> ou <code>.deb</code>' },
      steps: { title: 'Passos de instalação', step1: { title: 'Escolher modo', p1: 'Local: npm global, requer Node.js 22+', p2: 'Docker: imagem oficial, requer Docker' }, step2: { title: 'Verificar ambiente', p: 'Se Node.js ou Docker faltar, links são exibidos. Após instalar, reinicie e clique em "Re-verificar"' }, step3: { title: 'Instalar', p1: 'Local: npm install -g openclaw@latest e assistente', p2: 'Docker: pull ghcr.io/openclaw/openclaw:latest e iniciar' }, step4: { title: 'Concluído', p: 'Abra <a href="http://127.0.0.1:18789/" target="_blank" rel="noopener">http://127.0.0.1:18789/</a> para configuração inicial' } },
      build: { title: 'Compilar do código-fonte', intro_html: 'Para compilar, instale <a href="https://flutter.dev" target="_blank" rel="noopener">Flutter</a> e execute:' },
      issues: 'Problemas? Reporte em'
    }
  },
  ru: {
    nav: { home: 'Главная', download: 'Скачать', github: 'GitHub', openclaw_site: 'OpenClaw' },
    hero: {
      title: 'Графический установщик OpenClaw',
      subtitle: 'Кроссплатформенный установщик для персонального ИИ-ассистента <a href="https://openclaw.ai" target="_blank" rel="noopener">OpenClaw</a> с открытым исходным кодом',
      desc: 'Поддержка Windows, macOS и Linux. Установка и настройка в один клик.',
      download: 'Скачать',
      source: 'Исходный код'
    },
    features: {
      title: 'Возможности',
      dual_mode: { title: 'Два режима установки', desc: 'Локальная установка npm и контейнер Docker' },
      env_check: { title: 'Определение среды', desc: 'Автоопределение Node.js 22+ и Docker' },
      deps_guide: { title: 'Руководство по зависимостям', desc: 'Официальные ссылки при отсутствии среды' },
      one_click: { title: 'Установка в один клик', desc: 'Графический интерфейс, без командной строки' }
    },
    platforms: { title: 'Поддерживаемые платформы', windows: 'Windows', macos: 'macOS', linux: 'Linux' },
    requirements: {
      title: 'Системные требования',
      local: { title: 'Локально (npm)', items: ['Node.js 22+ (рекомендуется LTS)', 'npm 10+ или pnpm 9+'] },
      docker: { title: 'Docker', items: ['Docker Desktop (Windows/macOS)', 'Docker Engine (Linux)'] }
    },
    about: {
      title: 'О OpenClaw',
      intro: 'OpenClaw — персональный ИИ-ассистент с открытым исходным кодом, поддерживающий:',
      features: ['WhatsApp, Telegram, Discord, Slack, Signal, iMessage и др.', 'Постоянная память и персонализация', 'Управление браузером, доступ к файлам, расширения'],
      visit: 'Посетить OpenClaw →'
    },
    cta: { title: 'Начать', desc: 'Выберите ОС, скачайте и установите OpenClaw Installer', btn: 'Скачать' },
    footer: { license: 'OpenClaw Installer — открытый код под <a href="https://opensource.org/licenses/MIT" target="_blank" rel="noopener">MIT</a>', repo: 'GitHub', site: 'OpenClaw' },
    download_page: {
      title: 'Скачать OpenClaw Installer',
      subtitle: 'Выберите ОС и получите последнюю версию с GitHub Releases',
      windows: { title: 'Windows', desc: 'Установщик для Windows 10/11', btn: 'Скачать на GitHub', note: '<code>.exe</code> или <code>.msix</code>' },
      macos: { title: 'macOS', desc: 'Для Intel и Apple Silicon (M1/M2/M3)', btn: 'Скачать на GitHub', note: '<code>.dmg</code> или <code>.app</code>' },
      linux: { title: 'Linux', desc: 'Для Linux x64', btn: 'Скачать на GitHub', note: '<code>.AppImage</code> или <code>.deb</code>' },
      steps: { title: 'Шаги установки', step1: { title: 'Выбор режима', p1: 'Локально: npm глобально, нужен Node.js 22+', p2: 'Docker: официальный образ, нужен Docker' }, step2: { title: 'Проверка среды', p: 'Если нет Node.js или Docker, показываются ссылки. После установки перезапустите и нажмите «Проверить снова»' }, step3: { title: 'Установка', p1: 'Локально: npm install -g openclaw@latest и мастер настройки', p2: 'Docker: pull ghcr.io/openclaw/openclaw:latest и запуск' }, step4: { title: 'Готово', p: 'Откройте <a href="http://127.0.0.1:18789/" target="_blank" rel="noopener">http://127.0.0.1:18789/</a> для первичной настройки' } },
      build: { title: 'Сборка из исходников', intro_html: 'Для сборки установите <a href="https://flutter.dev" target="_blank" rel="noopener">Flutter</a> и выполните:' },
      issues: 'Проблемы? Сообщите в'
    }
  },
  ar: {
    nav: { home: 'الرئيسية', download: 'تحميل', github: 'GitHub', openclaw_site: 'OpenClaw' },
    hero: {
      title: 'مثبت OpenClaw الرسومي',
      subtitle: 'مثبت متعدد المنصات لمساعد الذكاء الاصطناعي الشخصي <a href="https://openclaw.ai" target="_blank" rel="noopener">OpenClaw</a> مفتوح المصدر',
      desc: 'يدعم Windows وmacOS وLinux. التثبيت والإعداد بنقرة واحدة.',
      download: 'تحميل الآن',
      source: 'عرض الكود'
    },
    features: {
      title: 'الميزات',
      dual_mode: { title: 'وضعان للتثبيت', desc: 'تثبيت npm محلي وحاوية Docker' },
      env_check: { title: 'اكتشاف البيئة', desc: 'اكتشاف تلقائي لـ Node.js 22+ و Docker' },
      deps_guide: { title: 'دليل التبعيات', desc: 'روابط التحميل الرسمية عند غياب البيئة' },
      one_click: { title: 'تثبيت بنقرة واحدة', desc: 'واجهة رسومية، بدون سطر أوامر' }
    },
    platforms: { title: 'المنصات المدعومة', windows: 'Windows', macos: 'macOS', linux: 'Linux' },
    requirements: {
      title: 'متطلبات النظام',
      local: { title: 'محلي (npm)', items: ['Node.js 22+ (LTS موصى به)', 'npm 10+ أو pnpm 9+'] },
      docker: { title: 'Docker', items: ['Docker Desktop (Windows/macOS)', 'Docker Engine (Linux)'] }
    },
    about: {
      title: 'حول OpenClaw',
      intro: 'OpenClaw هو مساعد ذكاء اصطناعي شخصي مفتوح المصدر يدعم:',
      features: ['WhatsApp و Telegram و Discord و Slack و Signal و iMessage وغيرها', 'ذاكرة دائمة وإعدادات مخصصة', 'التحكم في المتصفح، الوصول للملفات، الامتدادات'],
      visit: 'زيارة OpenClaw ←'
    },
    cta: { title: 'البدء', desc: 'اختر نظام التشغيل، حمّل وثبّت OpenClaw Installer', btn: 'تحميل' },
    footer: { license: 'OpenClaw Installer مفتوح المصدر بموجب <a href="https://opensource.org/licenses/MIT" target="_blank" rel="noopener">MIT</a>', repo: 'GitHub', site: 'OpenClaw' },
    download_page: {
      title: 'تحميل OpenClaw Installer',
      subtitle: 'اختر نظام التشغيل واحصل على أحدث إصدار من GitHub Releases',
      windows: { title: 'Windows', desc: 'مثبت لـ Windows 10/11', btn: 'تحميل من GitHub', note: '<code>.exe</code> أو <code>.msix</code>' },
      macos: { title: 'macOS', desc: 'لـ Intel و Apple Silicon (M1/M2/M3)', btn: 'تحميل من GitHub', note: '<code>.dmg</code> أو <code>.app</code>' },
      linux: { title: 'Linux', desc: 'لـ Linux x64', btn: 'تحميل من GitHub', note: '<code>.AppImage</code> أو <code>.deb</code>' },
      steps: { title: 'خطوات التثبيت', step1: { title: 'اختيار الوضع', p1: 'محلي: npm عام، يتطلب Node.js 22+', p2: 'Docker: صورة رسمية، يتطلب Docker' }, step2: { title: 'التحقق من البيئة', p: 'إذا كان Node.js أو Docker مفقوداً، تظهر الروابط. بعد التثبيت أعد التشغيل وانقر "إعادة التحقق"' }, step3: { title: 'التثبيت', p1: 'محلي: npm install -g openclaw@latest والمعالج', p2: 'Docker: pull ghcr.io/openclaw/openclaw:latest ثم التشغيل' }, step4: { title: 'تم', p: 'افتح <a href="http://127.0.0.1:18789/" target="_blank" rel="noopener">http://127.0.0.1:18789/</a> للإعداد الأولي' } },
      build: { title: 'البناء من المصدر', intro_html: 'للبناء، ثبّت <a href="https://flutter.dev" target="_blank" rel="noopener">Flutter</a> ثم نفّذ:' },
      issues: 'مشاكل؟ أبلغ على'
    }
  }
};
