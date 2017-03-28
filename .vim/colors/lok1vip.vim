"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File: "~/.vim/colors/lok1vip.vim"
" Copyright (C) 2016, Stefan Rimola <stefanrimola@gmail.com>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorscheme Option:
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi clear
if exists("syntax on")
	syntax reset
endif
let g:colors_name = "lok1vip"

" general colors
hi Normal	ctermfg=white guifg=peachpuff3 guibg=black
hi Directory	term=bold ctermfg=blue guifg=royalblue
hi ErrorMsg	term=standout ctermfg=white ctermbg=red guifg=white guibg=red3
hi NonText	term=bold ctermfg=darkgray guibg=gray3 guifg=gray20
hi SpecialKey	term=bold ctermfg=darkgray guifg=gray30
hi LineNr	term=underline ctermfg=darkgray guifg=ivory4 guibg=gray4
hi IncSearch	term=reverse cterm=reverse gui=reverse,bold guifg=darkgoldenrod2
hi Search	term=reverse ctermfg=black ctermbg=blue guifg=gray10 guibg=gold2
hi Visual	term=bold,reverse cterm=bold,reverse ctermfg=gray ctermbg=black gui=bold,reverse guifg=gray40 guibg=black
hi VisualNOS	term=bold,underline cterm=bold,underline gui=bold,underline
hi MoreMsg	term=bold ctermfg=green gui=bold guifg=olivedrab1
hi ModeMsg	term=bold cterm=bold gui=bold
hi Question	term=standout ctermfg=green gui=bold guifg=olivedrab1
hi WarningMsg	term=standout ctermfg=red gui=bold guifg=red3
hi WildMenu	term=standout ctermfg=black ctermbg=yellow guifg=black guibg=gold2
hi Folded	term=standout ctermfg=blue ctermbg=none guifg=royalblue1 guibg=white
hi FoldColumn	term=standout ctermfg=blue ctermbg=white guifg=royalblue3 guibg=white
hi DiffAdd	term=bold ctermbg=blue guibg=royalblue2
hi DiffChange	term=bold ctermbg=darkmagenta guibg=maroon
hi DiffDelete	term=bold cterm=bold ctermfg=lightblue ctermbg=cyan gui=bold guifg=lightblue guibg=cyan4
hi DiffText	term=reverse cterm=bold ctermbg=red gui=bold guibg=red3
hi Cursor	guifg=bg guibg=fg
hi lCursor	guifg=bg guibg=fg
" hi CursorLine	ctermbg=black
hi CursorLineNr ctermfg=1
hi StatusLine	term=reverse cterm=reverse gui=reverse guifg=gray60
hi StatusLineNC	term=reverse cterm=reverse gui=reverse guifg=gray40
hi VertSplit	term=reverse cterm=reverse ctermfg=darkgrey ctermbg=cyan gui=bold,reverse guifg=red
hi Title	term=bold ctermfg=magenta gui=bold guifg=aquamarine
hi ColorColumn	cterm=none ctermbg=0 ctermfg=1
hi MatchParen	cterm=none ctermbg=0 ctermfg=1

" syntax hi colors
hi Comment	term=bold ctermfg=darkcyan guifg=cyan4
hi PreProc	term=underline ctermfg=45 guifg=dodgerblue4
hi Constant	term=underline ctermfg=darkred guifg=firebrick3
hi Type		term=underline ctermfg=darkgreen gui=none guifg=chartreuse3
hi Statement	term=bold ctermfg=darkblue gui=none guifg=gold3
hi Identifier	term=underline ctermfg=darkgreen guifg=darkolivegreen4
hi Ignore	term=bold ctermfg=darkgray guifg=gray45
hi Special	term=underline ctermfg=magenta guifg=sienna
hi Error	term=reverse ctermfg=black ctermbg=red guifg=gray guibg=red3
hi Todo		term=standout ctermfg=black ctermbg=red gui=bold guifg=gray10 guibg=red
hi Underlined	term=underline cterm=underline ctermfg=darkblue gui=underline guifg=slateblue
hi Number	term=underline ctermfg=darkred guifg=red2

" syntax hi links
hi link String		Constant
hi link Character	Constant
hi link Number		Constant
hi link Boolean		Constant
hi link vimHighlight	Constant
hi link vimCommand	Constant
hi link Float		Number
hi link Function	Identifier
hi link Number		Constant
hi link Conditional	Statement
hi link Repeat		Statement
hi link Label		Statement
hi link Keyword		Statement
hi link Exception	Statement
hi link Operator	Statement
hi link Include		PreProc
hi link Define		PreProc
hi link Macro		PreProc
hi link PreCondit	PreProc
hi link StorageClass	Type
hi link Structure	Type
hi link Typedef		Type
hi link Tag		Special
hi link SpecialChar	Special
hi link Delimiter	Special
hi link SpecialComment	Special
hi link Debug		Special
hi link vimHiCtermColor PreProc

" vim hi
hi vimMapMod ctermfg=white
hi vimNotation ctermfg=white
hi vimOper ctermfg=white
hi vimOperParen ctermfg=white
hi vimSep ctermfg=white
hi vimSet ctermfg=white
hi vimSetSep ctermfg=white
hi vimSetEqual ctermfg=white
hi vimFunction ctermfg=white
hi vimContinue ctermfg=white
hi vimParenSep ctermfg=white
hi vimExecute ctermfg=white
hi vimFuncSID ctermfg=white
hi vimBracket ctermfg=white

" custom
hi def link jsonKeyword Identifier
hi jsObjectKey ctermfg=51
hi Comment cterm=italic,bold, gui=italic,bold
hi Noise ctermfg=225
hi Function ctermfg=50
hi link jsRegexpString Constant
hi link jsSpecial Constant
