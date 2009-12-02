" Vim syntax file
" Language:     RDoc - Ruby Documentation
" Maintainer:   Hallison Batista <email@hallisonbatista.com>
" URL:          http://hallisonbatista.com/projetos/rdoc.vim
" Version:      0.1.0
" Last Change:  Wed Dec  2 07:16:36 AMT 2009
" Remark:       Inspired in Markdown syntax written by Ben Williams <benw@plasticboy.com>.
"               http://www.vim.org/scripts/script.php?script_id=1242


" Read the HTML syntax to start with
if version < 600
  source <sfile>:p:h/html.vim
else
  runtime! syntax/html.vim
  unlet b:current_syntax
endif

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" don't use standard HiLink, it will not work with included syntax files
if version < 508
  command! -nargs=+ HtmlHiLink highlight link <args>
else
  command! -nargs=+ HtmlHiLink highlight def link <args>
endif

syntax spell toplevel
syntax case ignore
syntax sync linebreaks=1

" RDoc text markup
syntax region rdocBold      start=/\\\@<!\(^\|\A\)\@=\*\(\s\|\W\)\@!\(\a\{1,}\s\|$\n\)\@!/ skip=/\\\*/ end=/\*\($\|\A\|\s\|\n\)\@=/ contains=@Spell
syntax region rdocEmphasis  start=/\\\@<!\(^\|\A\)\@=_\(\s\|\W\)\@!\(\a\{1,}\s\|$\n\)\@!/  skip=/\\_/  end=/_\($\|\A\|\s\|\n\)\@=/  contains=@Spell
syntax region rdocMonospace start=/\\\@<!\(^\|\A\)\@=+\(\s\|\W\)\@!\(\a\{1,}\s\|$\n\)\@!/  skip=/\\+/  end=/+\($\|\A\|\s\|\n\)\@=/  contains=@Spell

" {link}[URL]
syn region rdocLink matchgroup=rdocDelimiter start="\!\?{" end="}\ze\s*[\[\]]" contains=@Spell nextgroup=rdocURL,rdocID skipwhite oneline
syn region rdocID   matchgroup=rdocDelimiter start="{"     end="}"  contained
syn region rdocURL  matchgroup=rdocDelimiter start="\["    end="\]" contained

"define RDoc markup groups
syn match  rdocLineContinue ".$" contained
syn match  rdocRule      /^\s*\*\s\{0,1}\*\s\{0,1}\*$/
syn match  rdocRule      /^\s*-\s\{0,1}-\s\{0,1}-$/
syn match  rdocRule      /^\s*_\s\{0,1}_\s\{0,1}_$/
syn match  rdocRule      /^\s*-\{3,}$/
syn match  rdocRule      /^\s*\*\{3,5}$/
syn match  rdocListItem  "^\s*[-*+]\s\+"
syn match  rdocListItem  "^\s*\d\+\.\s\+"
syn match  rdocLineBreak /  \+$/

"RDoc pre-formatted markup
"syn region rdocCode      start=/\s*``[^`]*/          end=/[^`]*``\s*/
syntax match  rdocCode  /^\s*\n\(\(\s\{1,}[^ ]\|\t\+[^\t]\).*\n\)\+/
syntax region rdocCode  start="<pre[^>]*>"         end="</pre>"
syntax region rdocCode  start="<code[^>]*>"        end="</code>"

" RDoc HTML headings
syntax region htmlH1  start="^\s*="       end="\($\)" contains=@Spell
syntax region htmlH2  start="^\s*=="      end="\($\)" contains=@Spell
syntax region htmlH3  start="^\s*==="     end="\($\)" contains=@Spell
syntax region htmlH4  start="^\s*===="    end="\($\)" contains=@Spell
syntax region htmlH5  start="^\s*====="   end="\($\)" contains=@Spell
syntax region htmlH6  start="^\s*======"  end="\($\)" contains=@Spell

"highlighting for Markdown groups
HtmlHiLink rdocCode         String
HtmlHiLink rdocBlockquote   Comment
HtmlHiLink rdocLineContinue Comment
HtmlHiLink rdocListItem     Identifier
HtmlHiLink rdocRule         Identifier
HtmlHiLink rdocLineBreak    Todo
HtmlHiLink rdocLink         htmlLink
HtmlHiLink rdocURL          htmlString
HtmlHiLink rdocID           Identifier
HtmlHiLink rdocBold         htmlBold
HtmlHiLink rdocEmphasis     htmlItalic
HtmlHiLink rdocMonospace    String

HtmlHiLink rdocDelimiter     Delimiter

let b:current_syntax = "rdoc"

delcommand HtmlHiLink

" vim: tabstop=2
