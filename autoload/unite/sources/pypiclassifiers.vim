let s:save_cpo = &cpo
set cpo&vim

let s:CURRENT_PATH = expand('<sfile>:p:h')

let s:pypiclassifiers_source = {
\   'name': 'pypiclassifiers',
\   'description': 'append classifiers for python packages',
\   'action_table': {'*': {}},
\   'default_action': 'insert',
\ }

" 辞書変数のリストを返す関数
function! s:pypiclassifiers_source.gather_candidates(args, context)
  let classifiers = s:get_classifiers_sources()
  return map(
        \ classifiers,
        \ '{
        \   "word": v:val,
        \   "source": "pypiclassifiers",
        \   "kind": "command",
        \   "action__module_name": v:val,
        \ }'
        \)
endfunction

" unite用のリストを作成する
function! s:get_classifiers_sources()
  " いちいちアクセスするのもあれだし、ファイルに落とし込んでおく
  " let URL = 'https://pypi.python.org/pypi?:action=list_classifiers'
  " 速度十分だし、別にキャッシュしなくて良いかな？
  return readfile(s:CURRENT_PATH . '/classifiers.txt')
endfunction

function! unite#sources#pypiclassifiers#define()
  return s:pypiclassifiers_source
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
