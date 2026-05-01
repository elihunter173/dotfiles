" Vim syntax file for Slap (stack-based language)
" Language: Slap
" Maintainer: Eli W. Hunter

if exists("b:current_syntax")
  finish
endif

" Comments: -- to end of line
syntax match slapComment /--.*$/ contains=slapTodo
syntax keyword slapTodo TODO FIXME NOTE XXX HACK contained

" Numbers (integer and float, including negatives)
syntax match slapNumber /\v-?\d+\.\d+/
syntax match slapNumber /\v-?\d+/

" Strings
syntax region slapString start=/"/ skip=/\\"/ end=/"/

" Symbols: 'word
syntax match slapSymbol /'\v[a-zA-Z_][a-zA-Z0-9_-]*/

" Tuples / code blocks
syntax region slapTuple matchgroup=slapParen start=/(/ end=/)/ contains=ALL
" Lists
syntax region slapList matchgroup=slapBracket start=/\[/ end=/\]/ contains=ALL
" Records
syntax region slapRecord matchgroup=slapBrace start=/{/ end=/}/ contains=ALL

" Definition keywords
syntax keyword slapDefine def let recur effect

" Control flow
syntax keyword slapControl if cond match while loop apply compose

" Stack manipulation
syntax keyword slapStack dup drop swap dip over peek nip rot tuck wrap

" Primitives: arithmetic & logic
syntax keyword slapOperator plus sub mul div mod divmod
syntax keyword slapOperator band bor bxor bnot shl shr
syntax keyword slapOperator eq lt and or not neq gt ge le
syntax keyword slapOperator itof ftoi fsqrt fsin fcos ftan ffloor fceil fround
syntax keyword slapOperator fexp flog fpow fatan2

" Primitives: I/O & system
syntax keyword slapBuiltin print assert halt random millis
syntax keyword slapBuiltin read write ls args isheadless cwd
syntax keyword slapBuiltin utf8-encode utf8-decode str-find str-split parse-http
syntax keyword slapBuiltin tcp-connect tcp-send tcp-recv tcp-close tcp-listen tcp-accept

" Collections: list/stack/record
syntax keyword slapBuiltin list stack rec
syntax keyword slapBuiltin len size give grab get set nth put cat
syntax keyword slapBuiltin push pop pull take-n drop-n range
syntax keyword slapBuiltin sort index-of scan reverse dedup
syntax keyword slapBuiltin at into edit where find shape
syntax keyword slapBuiltin rise fall

" Higher-order
syntax keyword slapBuiltin map filter fold each reduce

" Box (linear types)
syntax keyword slapBuiltin box free lend mutate clone

" Tagged unions
syntax keyword slapBuiltin tag untag union then default ok no

" SDL graphics
syntax keyword slapBuiltin clear pixel fill-rect on show

" Prelude: arithmetic helpers
syntax keyword slapPrelude inc dec neg abs sqr cube sign
syntax keyword slapPrelude fneg fabs frecip fsign
syntax keyword slapPrelude max min clamp fclamp lerp isbetween

" Prelude: predicates
syntax keyword slapPrelude iszero ispos isneg iseven isodd divides

" Prelude: list helpers
syntax keyword slapPrelude sum product max-of min-of first last
syntax keyword slapPrelude member couple isany isall count flatten sort-desc
syntax keyword slapPrelude select pick table repeat times-i
syntax keyword slapPrelude keep-mask group partition classify
syntax keyword slapPrelude zip windows rotate reshape transpose chunks

" Prelude: combinators
syntax keyword slapPrelude bi keep

" Prelude: binary/tile helpers
syntax keyword slapPrelude byte-mask byte-bits bits-byte
syntax keyword slapPrelude icn-decode icn-encode chr-decode chr-encode
syntax keyword slapPrelude nmt-decode nmt-encode tga-decode tga-header

" Prelude: constants
syntax keyword slapConstant true false pi tau e

" Highlight links
highlight default link slapComment Comment
highlight default link slapTodo Todo
highlight default link slapNumber Number
highlight default link slapString String
highlight default link slapSymbol Constant
highlight default link slapParen Delimiter
highlight default link slapBracket Delimiter
highlight default link slapBrace Delimiter
highlight default link slapDefine Keyword
highlight default link slapControl Conditional
highlight default link slapStack Special
highlight default link slapOperator Operator
highlight default link slapBuiltin Function
highlight default link slapPrelude Function
highlight default link slapConstant Boolean

let b:current_syntax = "slap"
