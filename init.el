;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)

;; 配置源并初始化package
(when (>= emacs-major-version 24)
    (require 'package)
    (package-initialize)
    (setq package-archives '(("gnu" . "http://elpa.emacs-china.org/gnu/")
                     ("melpa" . "http://elpa.emacs-china.org/melpa/"))))

;; 注意 elpa.emacs-china.org 是 Emacs China 中文社区在国内搭建的一个 ELPA 镜像

;; cl - Common Lisp Extension
(require 'cl)

;; Add Packages
(defvar ouo/packages '(
               ;; --- Auto-completion ---
               company
               ;; --- Better Editor ---
               hungry-delete
               swiper
               counsel
               smartparens
               ;; --- Major Mode ---
               js2-mode
               ;; --- Minor Mode ---
               nodejs-repl
               ;; exec-path-from-shell
               ;; --- Themes ---
               monokai-theme
               ;; solarized-theme
               ) "Default packages")

;; 这个是package-autoremove的执行列表,保持与ouo/packages同步
(setq package-selected-packages ouo/packages)

;; 判定ouo/packages列表中的package是否安装
(defun ouo/packages-installed-p ()
    (loop for pkg in ouo/packages
          when (not (package-installed-p pkg)) do (return nil)
          finally (return t)))

;; 若ouo/packages列表中有未安装的package则安装
(unless (ouo/packages-installed-p)
    (message "%s" "Refreshing package database...")
    (package-refresh-contents)
    (dolist (pkg ouo/packages)
      (when (not (package-installed-p pkg))
        (package-install pkg))))

;; 关闭工具栏
(tool-bar-mode -1)

;; 关闭文件滑动控件
(scroll-bar-mode -1)

;; 显示行号
(global-linum-mode t)

;; 关闭启动帮助画面
(setq inhibit-splash-screen t)

;; f2键打开init.el文件
(defun open-my-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "<f2>") 'open-my-init-file)

;; 启动company模式
(global-company-mode t)

;; 更改光标样式
(setq-default cursor-type 'bar)

;; 关闭自动生成备份文件
(setq make-backup-files nil)

;; 设置org代码块内文本语法高亮显示
(require 'org)
(setq org-src-fontify-natively t)

;; 设置显示字体大小
(set-face-attribute 'default nil :height 120)

;; 配置最近打开过的文件,最多记住10个
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 10)
;; 这个快捷键绑定可以用之后的插件counsel代替
;; (global-set-key (kbd "<\C-x\ \C-r>") 'recentf-open-files)

;; 选中文本后输入字符,会替换选中文本,而不是追加
(delete-selection-mode 1)

;; 全屏启动
(setq initial-frame-alist (quote ((fullscreen . maximized))))

;; 添加钩子,挂到emacs-lisp模式,开启括号匹配高亮显示
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;; 光标当前行高亮
(global-hl-line-mode t)

;; 加载monokai主题
(load-theme 'monokai t)

;; hungry-delete启动配置
(require 'hungry-delete)
(global-hungry-delete-mode)

;; swiper配置
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-h f") 'counsel-describe-function)
(global-set-key (kbd "C-h v") 'counsel-describe-variable)
;;(global-set-key (kbd "<f1> l") 'counsel-find-library)
;;(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
;;(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
;;(global-set-key (kbd "C-c g") 'counsel-git)
;;(global-set-key (kbd "C-c j") 'counsel-git-grep)
;;(global-set-key (kbd "C-c k") 'counsel-ag)
;;(global-set-key (kbd "C-x l") 'counsel-locate)
;;(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
;;(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

;; company配置
;; 提示延迟
(setq-default company-idle-delay 0.08)
;; 触发最小输入字符数
(setq-default company-minimum-prefix-length 1)

;; smartparens配置
(require 'smartparens-config)
;;(add-hook 'emacs-lisp-mode-hook #'smartparens-mode)
(smartparens-global-mode t)

;; js2-mode配置,将.js的Major Mode替换成js2-mode
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       auto-mode-alist))

;; nodejs-repl配置
(require 'nodejs-repl)

;; 三个重要查找文件函数绑定快捷键
(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)

;; 设置默认 Org Agenda 文件目录
(setq org-agenda-files '("~/org"))
;; 设置 org-agenda 打开快捷键
(global-set-key (kbd "C-c a") 'org-agenda)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js2-external-variable ((t (:foreground "dark gray")))))
