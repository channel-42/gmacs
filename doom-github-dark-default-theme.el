;;; doom-github-dark-default-theme.el
(require 'doom-themes)

;;
(defgroup doom-github-dark-default-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(defcustom doom-github-dark-default-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-github-dark-default-theme
  :type 'boolean)

(defcustom doom-github-dark-default-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-github-dark-default-theme
  :type 'boolean)

(defcustom doom-github-dark-default-comment-bg doom-github-dark-default-brighter-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their
legibility."
  :group 'doom-github-dark-default-theme
  :type 'boolean)

(defcustom doom-github-dark-default-padded-modeline nil
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'doom-github-dark-default-theme
  :type '(or integer boolean))

;;
(def-doom-theme doom-github-dark-default
  "Doom github-dark-default theme"

  ;; name        default   256       16
  ((bg         '("#0D1117" nil       nil            ))
   (bg-alt     '("#1E2735" nil       nil            ))
   (base0      '("#121211" "#121212" "black"        ))
   (base1      '("#252422" "#262626" "brightblack"  ))
   (base2      '("#373533" "#3A3A3A" "brightblack"  ))
   (base3      '("#494744" "#444444" "brightblack"  ))
   (base4      '("#5B5955" "#585858" "brightblack"  ))
   (base5      '("#6E6B66" "#6C6C6C" "brightblack"  ))
   (base6      '("#807D77" "#808080" "brightblack"  ))
   (base7      '("#918E88" "#8A8A8A" "brightblack"  ))
   (base8      '("#A2A09B" "#9E9E9E" "white"        ))
   (fg-alt     '("#C2C1BD" "#C0C0C0" "brightwhite"  ))
   (fg         '("#B3B1AD" "#AFAFAF" "white"        ))

   (grey       base4)
   (red        '("#FF7B72" "#FF875F" "red"          ))
   (orange     '("#ffa657" "#ffa657" "brightred"    ))
   (green      '("#3FB950" "#5FAF5F" "green"        ))
   (teal       '("#56D364" "#5FD75F" "brightgreen"  ))
   (yellow     '("#e4b221" "#e4b221" "yellow"       ))
   (blue       '("#79C0FF" "#87AFFF" "brightblue"   ))
   (dark-blue  '("#58A6FF" "#5FAFFF" "blue"         ))
   (magenta    '("#D2A8FF" "#D7AFFF" "magenta"      ))
   (violet     '("#d2a8ff" "#d2a8ff" "brightmagenta"))
   (cyan       '("#9dcbf4" "#9dcbf4" "brightcyan"   ))
   (dark-cyan  '("#39C5CF" "#5FD7D7" "cyan"         ))
   (selection-bg  '("#121c27" "#121c27" "brightblue"   ))

   ;; face categories -- required for all themes
   (highlight      blue)
   (vertical-bar   (doom-lighten bg 0.05))
   (selection      (doom-lighten selection-bg 0.05))
   (builtin        blue)
   (comments       (if doom-github-dark-default-brighter-comments dark-cyan base5))
   (doc-comments   (doom-lighten (if doom-github-dark-default-brighter-comments dark-cyan base5) 0.25))
   (constants      blue)
   (functions      violet)
   (keywords       red)
   (methods        violet)
   (operators      red)
   (type           red)
   (strings        cyan)
   (variables      fg)
   (numbers        blue)
   (region         (doom-lighten selection-bg 0.05))
   (error          red)
   (warning        orange)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (hidden     `(,(car bg) "black" "black"))
   (-modeline-bright doom-github-dark-default-brighter-modeline)
   (-modeline-pad
    (when doom-github-dark-default-padded-modeline
      (if (integerp doom-github-dark-default-padded-modeline) doom-github-dark-default-padded-modeline 4)))

   (modeline-fg     nil)
   (modeline-fg-alt base5)

   (modeline-bg
    (if -modeline-bright
        base3
        `(,(doom-darken (car bg) 0.15) ,@(cdr base0))))
   (modeline-bg-l
    (if -modeline-bright
        base3
        `(,(doom-darken (car bg) 0.1) ,@(cdr base0))))
   (modeline-bg-inactive   (doom-darken bg 0.1))
   (modeline-bg-inactive-l `(,(car bg) ,@(cdr base1))))


  ;; --- extra faces ------------------------
  ((elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")

   ((line-number &override) :foreground fg-alt )
   ((line-number-current-line &override) :foreground fg :background bg)
   ((line-number &override) :background bg )

   (font-lock-comment-face
    :foreground comments
    :background (if doom-github-dark-default-comment-bg (doom-lighten bg 0.05)))
   (font-lock-doc-face
    :inherit 'font-lock-comment-face
    :foreground doc-comments)

   (doom-modeline-bar :background (if -modeline-bright modeline-bg highlight))

   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis
    :foreground (if -modeline-bright base8 highlight))
   (mode-line-buffer-id
    :foreground highlight)

   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l)))

   (telephone-line-accent-active
    :inherit 'mode-line
    :background (doom-lighten bg 0.2))
   (telephone-line-accent-inactive
    :inherit 'mode-line
    :background (doom-lighten bg 0.05))
   (telephone-line-evil-emacs
    :inherit 'mode-line
    :background dark-blue)

   ;; --- major-mode faces -------------------
   ;; css-mode / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)

   ;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground red)
   (markdown-code-face :background (doom-lighten base3 0.05))

   ;; org-mode
   (org-hide :foreground hidden)
   (org-block :background base2)
   (org-block-begin-line :background base2 :foreground comments)
   (solaire-org-hide-face :foreground hidden))


  ;; --- extra variables ---------------------
  ;; ()
  )

;;; doom-github-dark-default-theme.el ends here
