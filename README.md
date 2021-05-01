
# Table of Contents

-   [init-file](#orgb0fc613)
-   [About](#org602734e)
-   [Speed up load times](#orgcdef1da)
-   [Package Management](#org4c040f2)
    -   [Adding MELPA](#org31b34e7)
    -   [Installing use-package](#orgc21aeb2)
-   [Cleanup](#org711925b)
-   [Icons](#orgf296bbe)
-   [Keybindings](#orgc1da775)
-   [Dashboard](#orga636389)
    -   [Configuring Dashboard](#orge37a113)
    -   [Dashboard in Emacsclient](#orgd0df8c4)
-   [evil-mode](#org08fa94c)
-   [Treemacs](#org77b77f2)
-   [Finding Files](#orgc307893)
-   [Dired](#org76c6302)
-   [Fonts](#orgf7d3a39)
    -   [Setting The Font Face](#org559782f)
    -   [Ligatures](#org73433b3)
    -   [Zooming In and Out](#orgf2714ca)
    -   [Emojis](#org955ab03)
-   [GUI Tweaks](#org91e5ca7)
    -   [Disable Menu, Toolbars and Scrollbars](#org7a4cce1)
    -   [Relative Line Numbers](#org758342f)
    -   [Doom Modeline](#org4c83543)
-   [Ivy, Counsel and Swiper](#org22e6f4a)
    -   [IVY-POSFRAME](#org427ea8d)
-   [Magit](#org78d48c6)
-   [Org Mode](#orga7b6da0)
    -   [Visual fill](#org4f2ade1)
    -   [Defining A Few Things](#orgf96ea92)
    -   [Enabling Org Bullets](#org40b7fa0)
    -   [Org Link Abbreviations](#orgb924275)
    -   [Org Todo Keywords](#org82f925f)
    -   [Source Code Block Tag Expansion](#org92a9225)
    -   [Source Code Block stuff](#orgd1df3db)
    -   [Heading formatting](#org3951079)
    -   [Automatically Create Table of Contents](#org43f0c12)
-   [Projectile](#org44cf654)
-   [Scrolling](#orgbd7c1a4)
-   [PDF-tools](#orga54563e)
-   [Shells](#org2089b4a)
    -   [Eshell](#orgdbd3fdd)
    -   [Vterm](#org9f8b22c)
-   [Theme](#org0c41e5b)
-   [Which key](#orgc36905b)
-   [Brackets](#orga575569)
-   [LSP](#org2486194)
    -   [LSP-Mode](#orgc9215f5)
    -   [yasnippet](#org0960da4)
    -   [company-mode](#org39dd722)
    -   [visual](#org392f9ea)
    -   [commenting](#org5d575e4)
-   [DAP](#orgd904ee0)
-   [Tree-sitter](#org400c7bf)
-   [Elfeed](#org36e3185)
-   [tab-bar](#orgc16ffec)
-   [Spell Checking](#org29c9a30)
-   [mu4e](#orgf9912d2)
-   [texfrag-mode](#org16fd867)
-   [LaTeX](#org62845f7)
-   [Reset gc to keep emacs snappy](#org01d8164)



<a id="orgb0fc613"></a>

# init-file

To be able to configure emacs in org-mode, put this code into init.el

<p class="verse">
(org-babel-load-file<br />
&#xa0;(expand-file-name<br />
&#xa0;&#xa0;"config.org"<br />
&#xa0;&#xa0;user-emacs-directory))<br />
</p>


<a id="org602734e"></a>

# About

My emacs config, adopted from [DT's emacs config](https://gitlab.com/dwt1/dotfiles/-/blob/master/.emacs.d.gnu/config.org). This config is oriented towards efficient note-taking with org-mode and general
productivity using org-agenda in conjuction with mu4e.

It also adds lsp-mode, tree-sitter, ligatures, dap-mode and some other features to enhace to programing experience.

**Generally, what I do with this emacs config is:**

-   write org-documents, e.g.
    -   lectures notes
    -   summaries
    -   keep an agenda
-   code in c/c++ and python
-   write LaTeX-documents
-   read and write mail
-   read rss (sometimes)


<a id="orgcdef1da"></a>

# Speed up load times

    ;; The default is 800 kilobytes.  Measured in bytes.
    (setq gc-cons-threshold (* 50 1000 1000))


<a id="org4c040f2"></a>

# Package Management


<a id="org31b34e7"></a>

## Adding MELPA

Make sure that melpa is added to the repo list

    (require 'package)
    (add-to-list 'package-archives
                 '("melpa" . "https://melpa.org/packages/"))
    ;; disable update checking on each startup 
    ;;(package-refresh-contents)
    (package-initialize)


<a id="orgc21aeb2"></a>

## Installing use-package

use-package makes configuring packages easier

    (unless (package-installed-p 'use-package)
      (package-install 'use-package))
    ;; don't try to install missing packages as default
    ;;(setq use-package-always-ensure t)


<a id="org711925b"></a>

# Cleanup

Keep Emacs from littering

    ;; NOTE: If you want to move everything out of the ~/.emacs.d folder
    ;; reliably, set `user-emacs-directory` before loading no-littering!
    ;(setq user-emacs-directory "~/.cache/emacs")
    (use-package no-littering)
    ;; no-littering doesn't set this by default so we must place
    ;; auto save files in the same path as it uses for sessions
    (setq auto-save-file-name-transforms
          `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))


<a id="orgf296bbe"></a>

# Icons

Add some nice icons to emacs. Needed for doom-modeline and neotree

    (use-package all-the-icons)


<a id="orgc1da775"></a>

# Keybindings

Make binding keys easy, especially when using evil-mode, e.g. mapping for different modes (insert, normal, visual) 

    (use-package general
      :config
      (general-evil-setup t))
    (nvmap "L" '(tab-bar-switch-to-next-tab :whichkey "next tab"))
    (nvmap "H" '(tab-bar-switch-to-prev-tab  :whichkey "prev tab"))
    (nvmap "F" '(tab-bar-close-tab :which-key "close tab"))
    
    ;; window movement
    (nvmap "C-h" '(evil-window-next :which-key "left"))
    (nvmap "C-l" '(evil-window-prev :which-key "right"))
    
    (nvmap :prefix "SPC"
           ;; general
           "SPC"   '(counsel-M-x :which-key "M-x")
           "O"   '(tab-bar-new-tab :which-key "new tab")
           "R"   '(elfeed :which-key "elfeed RSS")
           "C"   '(evilnc-comment-or-uncomment-lines :which-key "(un)comment")
           "G"   '(ffap :which-key "goto file")
           ;;"e"   '(neotree-toggle :which-key "neotree")
           "e"   '(treemacs :which-key "treemacs")
           "F" '(lsp-format-buffer :which-key "format")
           "m" '(:which-key "mail")
           "m m"   '(mu4e :which-key "mu4e")
           "m e"   '(mml-secure-message-encrypt-pgpmime :which-key "encrypt")
           "m s"   '(mml-secure-message-sign-pgpmime :which-key "sing")
           "m o"   '(org-mime-edit-mail-in-org-mode :which-key "org-edit")
           "m O"   '(org-mime-htmlize :which-key "org-htmlize")
           ;; insert
           "i" '(:which-key "insert")
           "i e" '(emojify-insert-emoji :which-key "emoji")
           ;; org and org-agenda 
           "o" '(:which-key "org")
           "o i" '(org-indent-block :which-key "indent")
           "o o" '(org-ctrl-c-ctrl-c :which-key "C-c C-c")
           "o a" '((lambda () (interactive) (evil-window-new (org-agenda))) :which-key "agenda")
           "o A" '((lambda () (interactive) (find-file-other-window "~/Documents/share/Org/agenda.org")) :which-key "agenda-file")
           "o s" '(org-schedule :which-key "schedule")
           "o t" '(org-todo :which-key "todo")
           "o RET" '(org-meta-return :which-key "re-insert")
           ;; compilation 
           "c" '(:which-key "compile")
           "c l"     '(texfrag-document :which-key "latex preview")
           ;; fix
           "f" '(:which-key "fix")
           "f w"     '(ispell-word :which-key "word")
           "f a"     '(ispell-buffer :which-key "all")
           ;; git 
           "g" '(:which-key "git")
           "g g"     '(magit-status :which-key "status")
           "g l"     '(magit-log :which-key "log")
           "g b"     '(magit-blame :which-key "blame")
           ;; lsp 
           "l"   '(:which-key "lsp")
           "l f" '(lsp-format-buffer :which-key "format")
           "l d" '(lsp-ui-peek-find-definitions :which-key "peek defs")
           "l r" '(lsp-ui-peek-find-references  :which-key "peek refs")
           "l s" '(lsp-treemacs-symbols :which-key "peek refs")
           ;; dap 
           "d"   '(:which-key "dap")
           "d d" '(dap-debug :which-key "debug")
           "d l" '(dap-debug-last :which-key "debug last")
           "d b" '(dap-breakpoint-toggle :which-key "breakpoint")
           "d m" '(dap-breakpoint-log-message :which-key "bmesg")
           "d w" '(dap-ui-expressions-add :which-key "watch")
           "d h" '(dap-hydra :which-key "hydra")
    
           ;; search
           "s" '(:which-key "search")
           "s f"  '(find-file :which-key "files")
           "s r"   '(counsel-recentf :which-key "recent")
    	 "s h" '(dired-jump :which-key "here")
    	 "s b" '(swiper :which-key "buffer")
           ;; buffers
           "b" '(:which-key "buffer")
           "b b"   '(counsel-switch-buffer :which-key "switch buffer")
           "b k"   '(kill-current-buffer :which-key "kill")
           "b n"   '(next-buffer :which-key "next")
           "b p"   '(previous-buffer :which-key "previous")
           "b B"   '(ibuffer-list-buffers :which-key "Ibuffer list buffers")
           "b K"   '(kill-buffer :which-key "Killall")
           ;; eshell
           ;;"e" '(:which-key "eshell")
           ;;"e h"   '(counsel-esh-history :which-key "history")
           ;;"e s"   '(eshell :which-key "Eshell")
           "r" '(:which-key "reload")
           "r c" '((lambda () (interactive) (load-file "~/.emacs.d/init.el")) :which-key "config")
           ;; toggle
           "t" '(:which-key "toggle")
           "t t"   '(vterm-toggle-cd :which-key "vterm")
           "t w"   '(toggle-truncate-lines :which-key "truncate lines")
           "t v"   '(visual-line-mode :which-key "visual lines")
           "t z"   '(visual-fill-column-mode :which-key "visual lines")
           "t s"   '(flyspell-mode :which-key "spell checking")
           ;; window splits
           "w" '(:which-key "window")
           "w c"   '(evil-window-delete :which-key "close")
           "w n"   '(evil-window-new :which-key "new")
           "w s"   '(evil-win ow-split :which-key "hsplit")
           "w v"   '(evil-window-vsplit :which-key "vsplit")
           ;; window motions
           "w w"   '(evil-window-next :which-key "Goto next window"))


<a id="orga636389"></a>

# Dashboard

Display a nice dashboard when emacs / emacsclient starts. Fast entry point to recent files, agenda, bookmarks


<a id="orge37a113"></a>

## Configuring Dashboard

    (use-package dashboard
      :init      ;; tweak dashboard config before loading it
      (setq dashboard-set-heading-icons t)
      (setq dashboard-set-file-icons t)
      (setq dashboard-banner-logo-title "~ blep ~")
    ;; custom header image 
      (setq dashboard-startup-banner "~/.emacs.d/gmacs_mid.png")
      (setq dashboard-center-content t)
      (setq dashboard-week-agenda t)
      (setq dashboard-items '((recents . 5)
                              (agenda . 5 )
                              (bookmarks . 3)
                              (projects . 5)))
      :config
      (dashboard-setup-startup-hook)
      (dashboard-modify-heading-icons '((recents . "file-text")
    				    (bookmarks . "book"))))
    
    ;; custom footer with emacs icon
    (setq dashboard-footer-messages '("made with   by channel-42"))
    (setq dashboard-footer-icon (all-the-icons-fileicon "emacs"
                                                       :height 1.1
                                                       :v-adjust -0.05
                                                       :face 'font-lock-keyword-face))
    
    ;; custom font faces
    (custom-set-faces
    '(dashboard-banner-logo-title((t (
    :inherit font-lock-keyword-face :height 200))))
    
    '(dashboard-footer((t (
    :inherit font-lock-keyword-face :height 140))))
    )


<a id="orgd0df8c4"></a>

## Dashboard in Emacsclient

This setting ensures that emacsclient always opens on **dashboard** rather than **scratch**.

    (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))


<a id="org08fa94c"></a>

# evil-mode

Using evil mode since I am/was a vim/nvim user 

    (use-package evil
      :init      ;; tweak evil's configuration before loading it
      (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
      (setq evil-want-keybinding nil)
      (setq evil-vsplit-window-right t)
      (setq evil-split-window-below t)
      (evil-mode))
    (use-package evil-collection
      :after evil
      :config
      (evil-collection-init))


<a id="org77b77f2"></a>

# Treemacs

Adds a nice project file browser, similar to neotree.
For general file browsing I just use dired

    (use-package treemacs
    :config)
    ;; some lsp features (symbol-trees)
    (use-package lsp-treemacs
    :after lsp)


<a id="orgc307893"></a>

# Finding Files

Used for searching recently opened files

    (use-package recentf
      :commands counsel-recentf 
      :config
      (recentf-mode)
    ;; exclude the littering dirs
    (add-to-list 'recentf-exclude no-littering-var-directory)
    (add-to-list 'recentf-exclude no-littering-etc-directory))


<a id="org76c6302"></a>

# Dired

Dired is the file manager within Emacs.

    (use-package all-the-icons-dired)
    (use-package dired-open)
    (use-package peep-dired)
    (setq peep-dired-cleanup-on-disable t)
      (with-eval-after-load 'dired
        (define-key dired-mode-map (kbd "M-p") 'peep-dired)
        (evil-define-key'(normal visual) dired-mode-map (kbd "h") 'dired-up-directory)
        (evil-define-key'(normal visual) dired-mode-map (kbd "l") 'dired-open-file)) ; use dired-find-file instead if not using dired-open package
        (evil-define-key'(normal visual) dired-mode-map (kbd "j") 'peep-dired-next-file)
        (evil-define-key'(normal visual) dired-mode-map (kbd "k") 'peep-dired-prev-file)
    ;; Get file icons in dired
    (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
    ;; With dired-open plugin, you can launch external programs for certain extensions
    ;; For example, I set all .png files to open in 'sxiv' and all .mp4 files to open in 'mpv'
    (setq dired-open-extensions '(("gif" . "sxiv")
                                  ("jpg" . "sxiv")
                                  ("png" . "sxiv")
                                  ("mkv" . "mpv")
                                  ("mp4" . "mpv")))


<a id="orgf7d3a39"></a>

# Fonts

All font settings


<a id="org559782f"></a>

## Setting The Font Face

    (set-face-attribute 'default nil
      :font "FiraCode Nerd Font 12"
      :weight 'medium)
    (set-face-attribute 'variable-pitch nil
      :font "Iosevka Aile 12"
      :weight 'medium)
    (set-face-attribute 'fixed-pitch nil
      :font "FiraCode Nerd Font 12"
      :weight 'medium)
    ;; Makes commented text italics (working in emacsclient but not emacs)
    (set-face-attribute 'font-lock-comment-face nil
      :slant 'italic)
    ;; Makes keywords italics (working in emacsclient but not emacs)
    (set-face-attribute 'font-lock-keyword-face nil :slant 'italic)
    
    ;; make emojis work in emacs-client
    ;;-------------------
    ;; Add Apple Color Emoji to the default symbol fontset used by Emacs
    (defun custom/set-emoji-font ()
      (set-fontset-font "fontset-default" 'symbol "Apple Color Emoji" nil 'prepend))
    ;; Call the config function once and then remove the handler
    (defun custom/set-emoji-font-in-frame (frame)
      (with-selected-frame frame
        (custom/set-emoji-font))
      ;; Unregister this hook once its run
      (remove-hook 'after-make-frame-functions
                   'custom/set-emoji-font-in-frame))
    ;; Attach the function to the hook only if in Emacs server
    ;; otherwise just call the config function directly
    (add-hook 'after-make-frame-functions
                  'custom/set-emoji-font-in-frame)
      (custom/set-emoji-font)
    
    ;;-------------------
    ;; Uncomment the following line if line spacing needs adjusting.
    (setq-default line-spacing 0.12)
    ;; Needed if using emacsclient. Otherwise, your fonts will be smaller than expected.
    (add-to-list 'default-frame-alist '(font . "FiraCode Nerd Font 12"))
    ;; changes certain keywords to symbols, such as lamda!
    (setq global-prettify-symbols-mode t)


<a id="org73433b3"></a>

## Ligatures

Adding nice looking code ligatures **(only for fira code)**

    (use-package fira-code-mode
      :hook prog-mode)


<a id="orgf2714ca"></a>

## Zooming In and Out

Settings for zooming (text-size)

    ;; zoom in/out like we do everywhere else.
    (global-set-key (kbd "C-+") 'text-scale-increase)
    (global-set-key (kbd "C--") 'text-scale-decrease)
    (global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
    (global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)


<a id="org955ab03"></a>

## Emojis

Add emoji support as well as nice emoji menu. Uses Apple's emoji font, which is configured [here](#org559782f)

    (use-package emojify
    :hook (after-init . global-emojify-mode)
    :config
    (setq emojify-display-style 'unicode)
    (setq emojify-emoji-styles '(unicode)))


<a id="org91e5ca7"></a>

# GUI Tweaks

Disable some GUI bloat and configure line numbers and statusbar


<a id="org7a4cce1"></a>

## Disable Menu, Toolbars and Scrollbars

    (menu-bar-mode -1)
    (tool-bar-mode -1)
    (scroll-bar-mode -1)


<a id="org758342f"></a>

## Relative Line Numbers

    (setq display-line-numbers nil)
    ;; relative line-nums in prog
    (add-hook 'prog-mode-hook (lambda () (setq display-line-numbers 'relative)))
    ;; no line-nums in org (due to var-pitch font)
    (add-hook 'org-mode-hook (lambda () (setq display-line-numbers 'nil)))
    ;; always truncate lines
    (setq truncate-lines t)


<a id="org4c83543"></a>

## Doom Modeline

    (use-package doom-modeline
      :init (doom-modeline-mode 1))
    ;; enable icons
    (setq doom-modeline-icon 1)


<a id="org22e6f4a"></a>

# Ivy, Counsel and Swiper

Ivy is a generic completion mechanism for Emacs.

    (use-package counsel
      :after ivy
      :config (counsel-mode))
    (use-package ivy
      :defer 0.1
      :diminish
      :bind (("C-c C-r" . ivy-resume)
             ("C-x B" . ivy-switch-buffer-other-window))
      :custom
      (ivy-count-format "(%d/%d) ")
      (ivy-use-virtual-buffers t)
      :config (ivy-mode))
    (use-package ivy-rich
      :after ivy
      :custom
      (ivy-virtual-abbreviate 'full
       ivy-rich-switch-buffer-align-virtual-buffer t
       ivy-rich-path-style 'abbrev)
      :config
      (ivy-set-display-transformer 'ivy-switch-buffer
                                   'ivy-rich-switch-buffer-transformer))
    (ivy-rich-mode)
    (use-package swiper
      :after ivy
    ;; alternate binding to leadet+s+b
      :bind (("C-s" . swiper)))


<a id="org427ea8d"></a>

## IVY-POSFRAME

Ivy-posframe is an ivy extension, which lets ivy use posframe to show its candidate menu.  Some of the settings below involve:

-   ivy-posframe-display-functions-alist &#x2013; sets the display position for specific programs
-   ivy-posframe-height-alist &#x2013; sets the height of the list displayed for specific programs

Available functions (positions) for 'ivy-posframe-display-functions-alist'

-   ivy-posframe-display-at-frame-center
-   ivy-posframe-display-at-window-center
-   ivy-posframe-display-at-frame-bottom-left
-   ivy-posframe-display-at-window-bottom-left
-   ivy-posframe-display-at-frame-bottom-window-center
-   ivy-posframe-display-at-point
-   ivy-posframe-display-at-frame-top-center

`NOTE:` If the setting for 'ivy-posframe-display' is set to 'nil' (false), anything that is set to 'ivy-display-function-fallback' will just default to their normal position in Doom Emacs (usually a bottom split).  However, if this is set to 't' (true), then the fallback position will be centered in the window.

    (use-package ivy-posframe
      :init
      (setq ivy-posframe-display-functions-alist
    	'((swiper                     . ivy-posframe-display-at-point)
    	  (complete-symbol            . ivy-posframe-display-at-point)
    	  (counsel-M-x                . ivy-display-function-fallback)
    	  (counsel-esh-history        . ivy-posframe-display-at-window-center)
    	  (counsel-describe-function  . ivy-display-function-fallback)
    	  (counsel-describe-variable  . ivy-display-function-fallback)
    	  (counsel-find-file          . ivy-display-function-fallback)
    	  (counsel-recentf            . ivy-display-function-fallback)
    	  (counsel-register           . ivy-posframe-display-at-frame-bottom-window-center)
    	  (dmenu                      . ivy-posframe-display-at-frame-top-center)
    	  (nil                        . ivy-posframe-display))
    	ivy-posframe-height-alist
    	'((swiper . 20)
    	  (dmenu . 20)
    	  (t . 10)))
      :config
      (ivy-posframe-mode 1)) ; 1 enables posframe-mode, 0 disables it.


<a id="org78d48c6"></a>

# Magit

Used for managing git projects

    (use-package magit
    :commands  magit-status)
    (use-package magit-todos
    :after magit
      ;; show comments with TODO in magit 
      :config (magit-todos-mode))


<a id="orga7b6da0"></a>

# Org Mode

**THE** mode I use emacs for and the main reason I originally switched to it


<a id="org4f2ade1"></a>

## Visual fill

Add margins on both sides of the buffer (useful for wide monitors)

    (defun dw/org-mode-visual-fill ()
      (setq visual-fill-column-width 120
            visual-fill-column-center-text t)
      (visual-fill-column-mode 1))
    
    (use-package visual-fill-column
      :defer t
      :hook (org-mode . dw/org-mode-visual-fill))
    (setq-default truncate-lines t)
    (setq-default global-visual-line-mode t)


<a id="orgf96ea92"></a>

## Defining A Few Things

    ;;(add-hook 'org-mode-hook 'org-indent-mode)
    (setq org-startup-indented t)
    (add-hook 'org-mode-hook 'texfrag-mode)
    (add-hook 'org-mode-hook #'visual-line-mode)
    (setq org-directory "~/Documents/share/Org"
          org-agenda-files (list org-directory)
          org-default-notes-file (expand-file-name "notes.org" org-directory)
          org-ellipsis " ▼ "
          org-log-done 'time
          org-journal-dir "~/Documents/share/Org/journal/"
          org-journal-date-format "%B %d, %Y (%A) "
          org-journal-file-format "%Y-%m-%d.org"
          org-hide-emphasis-markers t)


<a id="org40b7fa0"></a>

## Enabling Org Bullets

Org-bullets provides glyph-style bullets instead of asterisks.

    (use-package org-bullets)
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))


<a id="orgb924275"></a>

## Org Link Abbreviations

This allows for the use of abbreviations that will get expanded out into a lengthy URL.

    ;; An example of how this works.
    ;; [[arch-wiki:Name_of_Page][Description]]
    (setq org-link-abbrev-alist    ; This overwrites the default Doom org-link-abbrev-list
            '(("google" . "http://www.google.com/search?q=")
              ("arch-wiki" . "https://wiki.archlinux.org/index.php/")
              ("ddg" . "https://duckduckgo.com/?q=")
              ("wiki" . "https://en.wikipedia.org/wiki/")))


<a id="org82f925f"></a>

## Org Todo Keywords

Some custom settings for agenda items.

    (setq org-todo-keywords        ; This overwrites the default Doom org-todo-keywords
             '((sequence
                "TODO(t)"           ; A task that is ready to be tackled
                "BLOG(b)"           ; Blog writing assignments
                "UNI(u)"            ; Things to accomplish at the gym
                "PROJ(p)"           ; A project that contains other tasks
                "CODE(e)"          ; Video assignments
                "WAIT(w)"           ; Something is holding up this task
                "|"                 ; The pipe necessary to separate "active" states and "inactive" states
                "DONE(d)"           ; Task has been completed
                "CANCELLED(c)" )))  ; Task has been cancelled
    
    (setq org-fontify-done-headline t)
    ;; strike through things marked as done
    (set-face-attribute 'org-done nil :strike-through t)
    (set-face-attribute 'org-headline-done nil
                          :strike-through t
                          :foreground "#657b83")


<a id="org92a9225"></a>

## Source Code Block Tag Expansion

Org-tempo org-block expansion. Includes:

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">Characters Preceding TAB</th>
<th scope="col" class="org-left">Expands to &#x2026;</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">&lt;a</td>
<td class="org-left">'#+BEGIN_EXPORT ascii' … '#+END_EXPORT</td>
</tr>


<tr>
<td class="org-left">&lt;c</td>
<td class="org-left">'#+BEGIN_CENTER' … '#+END_CENTER'</td>
</tr>


<tr>
<td class="org-left">&lt;C</td>
<td class="org-left">'#+BEGIN_COMMENT' … '#+END_COMMENT'</td>
</tr>


<tr>
<td class="org-left">&lt;e</td>
<td class="org-left">'#+BEGIN_EXAMPLE' … '#+END_EXAMPLE'</td>
</tr>


<tr>
<td class="org-left">&lt;E</td>
<td class="org-left">'#+BEGIN_EXPORT' … '#+END_EXPORT'</td>
</tr>


<tr>
<td class="org-left">&lt;h</td>
<td class="org-left">'#+BEGIN_EXPORT html' … '#+END_EXPORT'</td>
</tr>


<tr>
<td class="org-left">&lt;l</td>
<td class="org-left">'#+BEGIN_EXPORT latex' … '#+END_EXPORT'</td>
</tr>


<tr>
<td class="org-left">&lt;q</td>
<td class="org-left">'#+BEGIN_QUOTE' … '#+END_QUOTE'</td>
</tr>


<tr>
<td class="org-left">&lt;s</td>
<td class="org-left">'#+BEGIN_SRC' … '#+END_SRC'</td>
</tr>


<tr>
<td class="org-left">&lt;v</td>
<td class="org-left">'#+BEGIN_VERSE' … '#+END_VERSE'</td>
</tr>
</tbody>
</table>

    (use-package org-tempo
      :after org
      :ensure nil) 


<a id="orgd1df3db"></a>

## Source Code Block stuff

Add syntax highlighting, preserve indentation and enable C, C++ and Python

    (setq org-src-fontify-natively t
         org-src-tab-acts-natively t
         org-confirm-babel-evaluate nil
         org-src-preserve-indentation t 
         org-edit-src-content-indentation 0
         org-adapt-indentation nil)
    
    ;; load langs for code blocks (needed for eval)
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((python . t)))
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((C . t)))


<a id="org3951079"></a>

## Heading formatting

Make headings different sizes

    ;; colors
    (custom-set-faces
      '(org-level-1 ((t (:inherit outline-1))))
      '(org-level-2 ((t (:inherit outline-2))))
      '(org-level-3 ((t (:inherit outline-3))))
      '(org-level-4 ((t (:inherit outline-4))))
      '(org-level-5 ((t (:inherit outline-5))))
    )
    
    ;; use non-mono font
    (add-hook 'org-mode-hook 'variable-pitch-mode 1)
    
    ;; heading sizes
    (set-face-attribute 'org-document-title nil :font "Iosevka Aile" :weight 'bold :height 1.3)
    (dolist (face '((org-level-1 . 1.5)
                    (org-level-2 . 1.4)
                    (org-level-3 . 1.3)
                    (org-level-4 . 1.2)
                    (org-level-5 . 1.1)
                    (org-level-6 . 1.0)
                    (org-level-7 . 1.0)
                    (org-level-8 . 1.0)))
      (set-face-attribute (car face) nil :font "Iosevka Aile" :weight 'medium :height (cdr face)))
    
    ;; Make sure org-indent face is available
    (require 'org-indent)
    
    ;; Ensure that anything that should be fixed-pitch in Org files appears that way
    (set-face-attribute 'org-block nil  :inherit 'fixed-pitch)
    (set-face-attribute 'org-table nil  :inherit 'fixed-pitch)
    (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
    (set-face-attribute 'org-code nil   :inherit '(fixed-pitch))
    (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
    (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
    (set-face-attribute 'org-special-keyword nil :inherit '( fixed-pitch))
    (set-face-attribute 'org-meta-line nil :inherit '(fixed-pitch))
    (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)


<a id="org43f0c12"></a>

## Automatically Create Table of Contents

Use ':TOC:' to generate it in org documents 

    (use-package toc-org
      :commands toc-org-enable
      :init (add-hook 'org-mode-hook 'toc-org-enable))


<a id="org44cf654"></a>

# Projectile

For project management.

    (use-package projectile
      :config
      (projectile-global-mode 1))


<a id="orgbd7c1a4"></a>

# Scrolling

Remove half page jumps and add acceleratted scrolling.

    (setq scroll-conservatively 101) ;; value greater than 100 gets rid of half page jumping
    (setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; how many lines at a time
    (setq mouse-wheel-progressive-speed t) ;; accelerate scrolling
    (setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse


<a id="orga54563e"></a>

# PDF-tools

Improve PDF viewing in emacs. Useful for writing LaTeX docs or taking lecture notes

    (use-package pdf-tools
    :config
    (pdf-tools-install)
    (add-hook 'pdf-tools-enabled-hook 'pdf-view-midnight-minor-mode))


<a id="org2089b4a"></a>

# Shells


<a id="orgdbd3fdd"></a>

## Eshell

*I don't use this, but still keep it around. Taken from DT's config*

Eshell is an Emacs 'shell' that is written in Elisp.

-   'eshell-syntax-highlighting' &#x2013; adds fish/zsh-like syntax highlighting.
-   'eshell-aliases-file' &#x2013; sets an aliases file for the eshell.

    (use-package eshell-syntax-highlighting
      :after esh-mode
      :config
      (eshell-syntax-highlighting-global-mode +1))
    (setq eshell-aliases-file "~/.config/doom/aliases"
          eshell-history-size 5000
          eshell-buffer-maximum-lines 5000
          eshell-hist-ignoredups t
          eshell-scroll-to-bottom-on-input t
          eshell-destroy-buffer-when-process-dies t
          eshell-visual-commands'("bash" "htop" "ssh" "top" "zsh"))


<a id="org9f8b22c"></a>

## Vterm

Adding vterm with custom function so that it opens in a new buffer at the bottom

    (use-package vterm
    :commands vterm
    :config
    ;; which shell to use
    (setq vterm-shell "/bin/zsh"))
    (setq shell-file-name "/bin/sh"
          vterm-max-scrollback 5000)
    (use-package vterm-toggle
    :commands (vterm-toggle vterm-toggle-cd)
    :config
    ;; show vterm at the bottom
    (setq vterm-toggle-fullscreen-p nil)
    (add-to-list 'display-buffer-alist
                 '((lambda(bufname _) (with-current-buffer bufname (equal major-mode 'vterm-mode)))
                    (display-buffer-reuse-window display-buffer-at-bottom)
                    ;;(display-buffer-reuse-window display-buffer-in-direction)
                    ;;display-buffer-in-direction/direction/dedicated is added in emacs27
                    ;;(direction . bottom)
                    ;;(dedicated . t) ;dedicated is supported in emacs27
                    (reusable-frames . visible)
                    (window-height . 0.3))))


<a id="org0c41e5b"></a>

# Theme

Using the doom-themes since they integrate well with other packages (treemacs, modeline, etc.)

    ;;(use-package dracula-theme)
    ;;(load-theme 'dracula t)
    (use-package doom-themes)
    (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
          doom-themes-enable-italic t) ; if nil, italics is universally disabled
    (load-theme 'doom-solarized-dark t)
    ;;(doom-themes-neotree-config)
    (setq doom-themes-treemacs-theme "doom-colors")
    (doom-themes-treemacs-config)
    (set-frame-parameter (selected-frame) 'alpha '(95 . 90))
    (add-to-list 'default-frame-alist '(alpha . (95 . 90)))


<a id="orgc36905b"></a>

# Which key

Been using it in nvim, so it had to be included here

    (use-package which-key
    :after evil)
    (which-key-mode)


<a id="orga575569"></a>

# Brackets

Enabling autoclosing brackets 

    (electric-pair-mode)


<a id="org2486194"></a>

# LSP

Make emacs a very powerful IDE


<a id="orgc9215f5"></a>

## LSP-Mode

Configure lsp-mode for python and c/c++

    (setq byte-compile-warnings '(cl-functions))
    (use-package lsp-mode
      :init
      ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
      (setq lsp-keymap-prefix "C-c l")
    
    (setq lsp-pyls-server-command '("/home/lukas/.local/bin/pyls"))
      :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
             ;;(prog-mode . lsp)
             (c-mode . lsp)
             (python-mode . lsp)
             (LaTeX-mode . lsp)
             ;; if you want which-key integration
             (lsp-mode . lsp-enable-which-key-integration))
      :commands lsp
    :config
    
    ;; needed for yasnippets to work
    (setq lsp-completion-provider :none))
    
    ;; tab width and coding style
    (setq c-basic-offset 4
          c-default-style "k&r")
    
    ;; use ccls instead of clangd -> avr-programming
    (use-package ccls
      :hook ((c-mode c++-mode objc-mode cuda-mode) .
             (lambda () (require 'ccls) (lsp)))
    :config (setq ccls-executable "/usr/bin/ccls")
     (setq ccls-args `(,(format "--log-file=/tmp/ccls_%d.log" (emacs-pid)) "-v=2")))
    
    ;; configure ui settings (doc position, always peek)
    (use-package lsp-ui
      :hook (lsp-mode . lsp-ui-mode)
      :config
      (setq lsp-ui-sideline-enable t)
      (setq lsp-ui-sideline-show-hover nil)
      (setq lsp-ui-doc-position 'bottom)
      (setq lsp-ui-peek-always-show t))


<a id="org0960da4"></a>

## yasnippet

Add useful snippets to speed up coding

    (use-package yasnippet
      :hook (prog-mode . yas-minor-mode)
      :config
      (yas-reload-all))
    
    (use-package yasnippet-snippets)


<a id="org39dd722"></a>

## company-mode

Enhace the default autocompletion with company-mode (added support for yasnippets)

    (use-package company
      :after lsp-mode
      :hook (prog-mode . company-mode)
      :custom
      (company-minimum-prefix-length 1)
      (company-idle-delay 0.0)
    :config
    ;; Add yasnippet support for all company backends
    ;; https://github.com/syl20bnr/spacemacs/pull/179
    (defvar company-mode/enable-yas t
      "Enable yasnippet for all backends.")
    
    (defun company-mode/backend-with-yas (backend)
      (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
          backend
        (append (if (consp backend) backend (list backend))
                '(:with company-yasnippet))))
    
    (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))
    )
    
    (use-package company-box
      :hook (company-mode . company-box-mode))


<a id="org392f9ea"></a>

## visual

    ;; indent guides 
    (use-package highlight-indent-guides
    :config
    (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
    (setq highlight-indent-guides-method 'character))
    
    ;; colorful brackets
    (use-package rainbow-delimiters
      :hook (prog-mode . rainbow-delimiters-mode))


<a id="org5d575e4"></a>

## commenting

    ;; easily toggle comments
    (use-package evil-nerd-commenter)


<a id="orgd904ee0"></a>

# DAP

Add debugging functionality. Currently only configured for c/c++

    (use-package dap-mode
    :hook (c-mode) 
    :config
    (require 'dap-gdb-lldb)
    (dap-gdb-lldb-setup))


<a id="org400c7bf"></a>

# Tree-sitter

Enhanced syntax highlighting in prog-mode. Clashes with code blocks sometimes (background color of brackets)

    (use-package tree-sitter)
    (use-package tree-sitter-langs)
    (global-tree-sitter-mode)
    (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
    ;; change type face as it clashes with the function face (doom-themes)
    (custom-set-faces
    '(tree-sitter-hl-face:type.builtin ((t (
    :inherit font-lock-type-face)))))


<a id="org36e3185"></a>

# Elfeed

A RSS reader for emacs

    (use-package elfeed
    :commands elfeed
    :config
    ;; Entries older than 2 weeks are marked as read
    (add-hook 'elfeed-new-entry-hook
              (elfeed-make-tagger :before "2 weeks ago"
                                  :remove 'unread))
    ;; custom viewing settings
    (add-hook 'elfeed-show-mode-hook #'visual-line-mode) 
    (add-hook 'elfeed-show-mode-hook #'visual-fill-column-mode) 
    ;; feeds to load
    (setq elfeed-feeds
          '(("https://www.reddit.com/r/emacs.rss" emacs-reddit)
            ("https://www.linux.com/feed/" linux)
            ("https://www.tagesschau.de/xml/rss2" news))))
    
    ;; some visual enhancements
    (use-package elfeed-goodies
      :init
      (elfeed-goodies/setup)
      :config
      (setq elfeed-goodies/entry-pane-size 0.6))
    ;; custom bindings
    (add-hook 'elfeed-show-mode-hook 'visual-line-mode)
    (evil-define-key 'normal elfeed-show-mode-map
      (kbd "J") 'elfeed-goodies/split-show-next
      (kbd "K") 'elfeed-goodies/split-show-prev)
    (evil-define-key 'normal elfeed-search-mode-map
      (kbd "J") 'elfeed-goodies/split-show-next
      (kbd "K") 'elfeed-goodies/split-show-prev)


<a id="orgc16ffec"></a>

# tab-bar

Adding a simple tab-bar (comes bundled with emacs).

    (tab-bar-mode)
    (setq tab-bar-close-button-show nil
          tab-bar-new-button-show nil)
    
    ;; new tab
    (setq tab-bar-new-tab-choice "*scratch*")
    
    ;; custom colors
    (custom-set-faces
    '(tab-bar ((t (
    :inherit mode-line))))
    
    '(tab-bar-tab ((t (
    :inherit mode-line 
    :foreground "#fb3d66"))))
    
    '(tab-bar-tab-inactive ((t(
    :inherit mode-line
    :foreground "#b3bec1")))))


<a id="org29c9a30"></a>

# Spell Checking

Spell checking with ispell and hunspell. Requires hunspell to be installed. Company-completions not working ATM.   

    (use-package ispell
      :after org
      :custom
      (ispell-program-name "hunspell")
      ;;(ispell-dictionary "en_US,de_DE,es")
      (ispell-dictionary "de_DE,es")
      (ispell-personal-dictionary "~/.emacs.d/.hunspell_personal")
      :config
      ;; Configure `LANG`, otherwise ispell.el cannot find a 'default
      ;; dictionary' even though multiple dictionaries will be configured
      ;; in next line.
      (setenv "LANG" "en_US")
      ;; ispell-set-spellchecker-params has to be called
      ;; before ispell-hunspell-add-multi-dic will work
      (ispell-set-spellchecker-params)
      (ispell-hunspell-add-multi-dic ispell-dictionary)
      (unless (file-exists-p ispell-personal-dictionary)
        (write-region "" nil ispell-personal-dictionary nil 0)))
    
    ;(use-package company
    ;:config
    ;(add-hook 'after-init-hook 'global-company-mode 'company-dabbrev)
    ;(add-to-list 'company-backends 'company-ispell)
    ;(setq company-ispell-dictionary ispell-dictionary)
    ;)


<a id="orgf9912d2"></a>

# mu4e

Manage mail comortably in emacs. Includes: 

-   encrypted passwords
-   pgp signing
-   org to html conversion
-   org capture templates (useful if you use org-agenda)

All this makes integration into the general *emacs workflow* very convinient

    
    ;; needed for encrypted passwords
    (use-package epa-file)
    (epa-file-enable)
    (setq mm-sign-option 'nil)
    (use-package smtpmail :after mu4e)
    (use-package org-mime :after org
    :config
    ;; custom org-to-html-conversion settings
    (setq org-mime-export-options '(:section-numbers nil
                                    :with-author nil
                                    :with-toc nil))
    
    ;; custom code block styling (html)
    (add-hook 'org-mime-html-hook
              (lambda ()
                (org-mime-change-element-style
                "pre" (format "color: %s; background-color: %s; padding: 0.5em;"
                              "#ffffff" "#1d1f21")))))
    (use-package mu4e
      :ensure nil
      :load-path "/usr/share/emacs/site-lisp/mu4e/"
      ;; :defer 20 ; Wait until 20 seconds after startup
      :commands mu4e
      :config
    ;; enable custom modes when reading/writing
    (add-hook 'mu4e-view-mode-hook #'visual-line-mode) 
    (add-hook 'mu4e-view-mode-hook #'visual-fill-column-mode) 
    (add-hook 'mu4e-compose-mode-hook 'flyspell-mode)
    ;; org capture stuff
    (require 'mu4e-org)
    (setq org-capture-templates
      `(("m" "Email Workflow")
        ("mf" "Follow Up" entry (file+olp "~/Documents/share/Org/Mail.org" "Beantworten")
              "* TODO AW an %:fromname über %:subject\nSCHEDULED:%t\nDEADLINE: %(org-insert-time-stamp (org-read-date nil t \"+2d\"))\n\n%a\n\n%i" :immediate-finish t) ("mr" "Read Later" entry (file+olp "~/Documents/share/Org/Mail.org" "Lesen")
              "* TODO LESEN: %:subject\nSCHEDULED:%t\nDEADLINE: %(org-insert-time-stamp (org-read-date nil t \"+2d\"))\n\n%a\n\n%i" :immediate-finish t)))
    ;; custom capture vars
    (defun efs/capture-mail-follow-up (msg)
      (interactive)
      (call-interactively 'org-store-link)
      (org-capture nil "mf"))
    
    (defun efs/capture-mail-read-later (msg)
      (interactive)
      (call-interactively 'org-store-link)
      (org-capture nil "mr"))
    
    ;; Add custom actions for our capture templates
    (add-to-list 'mu4e-headers-actions
      '("antwort vormerken" . efs/capture-mail-follow-up) t)
    (add-to-list 'mu4e-view-actions
      '("antwort vormerken" . efs/capture-mail-follow-up) t)
    (add-to-list 'mu4e-headers-actions
      '("lesen vormerken" . efs/capture-mail-read-later) t)
    (add-to-list 'mu4e-view-actions
      '("lesen vormerken" . efs/capture-mail-read-later) t)
    
    (setq mml-secure-openpgp-sign-with-sender t)
    (setq mu4e-view-show-images t)
    ;; Only ask if a context hasn't been previously picked
    (setq mu4e-compose-context-policy 'ask-if-none)
    ;; Make sure plain text mails flow correctly for recipients
    (setq mu4e-compose-format-flowed t)
    
    ;; load the mail account configs
    (load "~/.emacs.d/mail.el")
    ;; file contains list of mue4e-contexts, this allows for multiple accounts
    ;; looks like this
    ;;
    ;; (setq mu4e-contexts
    ;;       (list
    ;;        ;; first account
    ;;        (make-mu4e-context
    ;;         :name "1st-acc"
    ;;         :match-func
    ;;           (lambda (msg)
    ;;             (when msg
    ;;               (string-prefix-p "/first_acc" (mu4e-message-field msg :maildir))))
    ;;         :vars '((user-mail-address . "example@domain.net")
    ;;                 (mu4e-compose-signature . "Your Name (CEO Mail Inc.)"
    ;;                 (user-full-name    . "Your Name")
    ;;                 (mu4e-drafts-folder  . "/first_acc/Drafts")
    ;;                 (mu4e-sent-folder  . "/first_acc/Sent")
    ;;                 (mu4e-trash-folder  . "/first_acc/Trash")
    ;;                 (smtpmail-auth-credentials . (expand-file-name "~/.authinfo.gpg"))
    ;;                 (message-send-mail-function . smtpmail-send-it)
    ;;                 (smtpmail-starttls-credentials . (("your.smpt.net" 587 nil nil)))
    ;;                 (smtpmail-smtp-server . "your.smpt.net")
    ;;                 (smtpmail-smtp-user . "example@domain.net")
    ;;                 (smtpmail-debug-info . t)
    ;; 	          (smtpmail-debug-verbose . t)
    ;;                 (smtpmail-smtp-service . 587)
    ;;                 (mu4e-maildir-shortcuts . ( ("/first_acc/Inbox" . ?i)
    ;; 					("/first_acc/Sent"        . ?s)
    ;; 					("/first_acc/Trash"       . ?t)
    ;; 					("/first_acc/Spam"        . ?j)
    ;; 					("/first_acc/Drafts"      . ?d)))
    ;;                )
    ;;         )
    ;; 
    ;;  
    ;; ))
    ;;
    
    ;; This is set to 't' to avoid mail syncing issues when using mbsync
    (setq mu4e-change-filenames-when-moving t)
    ;; Refresh mail using isync every 10 minutes
    (setq mu4e-update-interval (* 10 60))
    (setq mu4e-get-mail-command "mbsync -a -c ~/.config/mbsync/mbsyncrc")
    )


<a id="org16fd867"></a>

# texfrag-mode

Display inline Latex code blocks in org-mode

    (use-package texfrag
    :after org
    :config
    (setq texfrag-preview-buffer-at-start t
          texfrag-scale 1.25))


<a id="org62845f7"></a>

# LaTeX

Setup auctex to work together with pdftools, lsp, company, and yasnippets.
Some stuff seems to be a bit borked, probably config related

    (use-package company-auctex)
    ;; this line also needs to go into init.el
    ;; all other settings work for some reason
    (setq TeX-engine 'xetex) ;enable autosave on during LaTeX-mode
    (setq TeX-auto-save t) ;enable autosave on during LaTeX-mode
    (setq TeX-parse-self t) ; enable autoparsing
    (setq TeX-save-query nil) 
    ;; pdftools to view compiled file
    ;; has autorefresh on recompile
    (setq TeX-view-program-selection '((output-pdf "PDF Tools"))
          TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view))
          TeX-source-correlate-start-server t)
    (add-hook 'TeX-after-compilation-finished-functions
              #'TeX-revert-document-buffer)
    ;; enable some specific minor modes
    (setq predictive-latex-electric-environments 1)
    (add-hook 'LaTeX-mode-hook 'company-mode)
    (add-hook 'LaTeX-mode-hook 'yas-minor-mode)
    (setq-default fill-column 100)
    (add-hook 'LaTeX-mode-hook 'auto-fill-mode)
    (add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
    (add-hook 'LaTeX-mode-hook 'visual-line-mode)
    (add-hook 'pdf-view-mode-hook ( lambda() (company-mode -1)))


<a id="org01d8164"></a>

# Reset gc to keep emacs snappy

    ;; Make gc pauses faster by decreasing the threshold.
    (setq gc-cons-threshold (* 2 1000 1000))

