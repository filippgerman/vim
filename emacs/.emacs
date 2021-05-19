;;el get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")

;; загрузки
(el-get-bundle emacs-neotree)
(el-get-bundle indent-guide)
(el-get-bundle company-mode)
(el-get-bundle flycheck)
(el-get-bundle ergoemacs-mode)

;; web 
(el-get-bundle yasnippet)
(el-get-bundle web-mode)
;; smex
(el-get-bundle smex)

;;python
(el-get-bundle jedi)
(el-get-bundle auto-complete)


;; Указать в какой системе  работаем
(defun system-is-linux()
    (string-equal system-type "gnu/linux"))

; Включить эргоемак	  
(package-initialize)
(require 'ergoemacs-mode)
(setq ergoemacs-theme nil) ;; Uses Standard Ergoemacs keyboard theme
(setq ergoemacs-keyboard-layout "us") ;; Assumes QWERTY keyboard layout
(ergoemacs-mode 1)

;;(setq ergoemacs-theme "lvl2")
;;(setq ergoemacs-keyboard-layout "us")
;;(require 'ergoemacs-mode)			  
;;(ergoemacs-mode 1)

;; Отключить бар меню
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode   -1) ;; отключаем полосу прокрутки
(blink-cursor-mode -1) ;; курсор не мигает
(setq use-dialog-box     nil) ;; никаких графических диалогов и окон - все через минибуфер
(setq redisplay-dont-pause t)  ;; лучшая отрисовка буфера
(setq ring-bell-function 'ignore) ;; отключить звуковой сигнал


;; Включение на сервре
(when (system-is-linux)
    (require 'server)
    (unless (server-running-p)
      (server-start))) ;; запустить Emacs как сервер, если ОС - GNU/Linux

;; Выключение экрана приветствия
(setq inhibit-splash-screen   t)
(setq ingibit-startup-message t) ;; экран приветствия можно вызвать комбинацией C-h C-a

;; Скобки
(show-paren-mode t) ;; включить выделение выражений между {},[],()
(setq show-paren-style 'expression) ;; выделить цветом выражения между {},[],()
(electric-pair-mode    1) ;; автозакрытие {},[],() с переводом курсора внутрь скобок
(electric-indent-mode -1) ;; отключить индентацию  electric-indent-mod'ом (default in Emacs-24.4)

(require 'linum) ;; вызвать Linum
(line-number-mode   t) ;; показать номер строки в mode-line
(global-linum-mode  t) ;; показывать номера строк во всех буферах
(column-number-mode t) ;; показать номер столбца в mode-line
(setq linum-format " %d") ;; задаем формат нумерации строк

(fringe-mode '(8 . 0)) ;; органичиталь текста только слева
(setq-default indicate-empty-lines t) ;; отсутствие строки выделить глифами рядом с полосой с номером строки
(setq-default indicate-buffer-boundaries 'left) ;; индикация только слева

;; Display file size/time in mode-line
(setq display-time-24hr-format t) ;; 24-часовой временной формат в mode-line
(display-time-mode             t) ;; показывать часы в mode-line
(size-indication-mode          t) ;; размер файла в %-ах

(setq word-wrap          t) ;; переносить по словам
(global-visual-line-mode t)

;; размер экрана.
(when (window-system)
    (set-frame-size (selected-frame) 100 50))

;; IDO plugin
(require 'ido)
(ido-mode                      t)
(icomplete-mode                t)
(ido-everywhere                t)
(setq ido-vitrual-buffers      t)
(setq ido-enable-flex-matching t)
(ido-mode 1)


;; Buffer Selection and ibuffer settings
(require 'bs)
(require 'ibuffer)
(defalias 'list-buffers 'ibuffer) ;; отдельный список буферов при нажатии C-x C-b
(global-set-key (kbd "<f2>") 'bs-show) ;; запуск buffer selection кнопкой F2

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
	("80d5a22931c15756b00fb258b80c93b8bc5096bb698dadfb6155ef3550e1c8fb" default)))
 '(package-selected-packages (quote (sr-speedbar lsp-mode ## js2 js2-mode slime))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load-theme 'monokai t)

;; подсветка синтаксиса
(require 'font-lock)
(global-font-lock-mode             t) ;; включено с версии Emacs-22. На всякий...
(setq font-lock-maximum-decoration t)

;; отступы
(setq-default tab-width          4) ;; ширина табуляции - 4 пробельных символа
(setq-default c-basic-offset     4)
(setq-default standart-indent    4) ;; стандартная ширина отступа - 4 пробельных символа
(setq-default lisp-body-indent   4) ;; сдвигать Lisp-выражения на 4 пробельных символа
(global-set-key (kbd "RET") 'newline-and-indent) ;; при нажатии Enter перевести каретку и сделать отступ
(setq lisp-indent-function  'common-lisp-indent-function)

;; скролинг
(setq scroll-step               1) ;; вверх-вниз по 1 строке
(setq scroll-margin            10) ;; сдвигать буфер верх/вниз когда курсор в 10 шагах от верхней/нижней границы  
(setq scroll-conservatively 10000)

;; общий буфер обмена
(setq x-select-enable-clipboard t)

(setq require-final-newline    t) ;; добавить новую пустую строку в конец файла при сохранении
(setq next-line-add-newlines nil) ;; не добавлять новую строку в конец при смещении 

;; эметы.
(add-to-list 'load-path "~/.emacs.d/emmet-mode")
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
(global-set-key (kbd "C-j") 'emmet-expand-line)

;; с помощью shift + стрелочки можно переключить окно.
(windmove-default-keybindings)

;; neotree
(add-to-list 'load-path "/some/path/neotree")
(require 'neotree)
(global-set-key [f12] 'neotree-toggle)

;; indent-guide
(require 'indent-guide)
(indent-guide-global-mode)

;; company-mode
(add-hook 'after-init-hook 'global-company-mode)

;; yasnippet
(require 'yasnippet)
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)			

;;flycheck
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)
(eval-after-load 'js-mode
  '(add-hook 'js-mode-hook #'add-node-modules-path))

;;web-mode
(require 'web-mode)

; с какими файлами ассоциировать web-mode
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))

; настройка отступов
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)

; сниппеты и автозакрытие парных скобок
(setq web-mode-extra-snippets '(("erb" . (("name" . ("beg" . "end"))))
                                ))
(setq web-mode-extra-auto-pairs '(("erb" . (("open" "close")))
                                  ))
; подсвечивать текущий элемент
(setq web-mode-enable-current-element-highlight t)


;;python
(add-hook 'python-mode-hook 'auto-complete-mode)
(add-hook 'python-mode-hook 'jedi:ac-setup)

;; smex
(require 'smex) 
(smex-initialize)


;; vue
(setq vue-mode-packages
  '(vue-mode))

(setq vue-mode-excluded-packages '())

(defun vue-mode/init-vue-mode ()
  "Initialize my package"
  (use-package vue-mode))

(defun vue-mode/init-vue-mode ()
  (use-package vue-mode
               :config
               ;; 0, 1, or 2, representing (respectively) none, low, and high coloring
               (setq mmm-submode-decoration-level 0)))
