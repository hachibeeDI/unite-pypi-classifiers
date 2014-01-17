let s:save_cpo = &cpo
set cpo&vim

let s:pythonimport_source = {
\       'name': 'pypiclassifiers',
\       'description': 'append classifiers for python packages',
\       'action_table': {
\           },
\       }

" 辞書変数のリストを返す関数
function! s:pypiclassifiers_source.gather_candidates(args, context)
  let classifiers = s:get_module_sources()
  return map(
        \ importable_list,
        \ '{
        \   "word": v:val,
        \   "source": "pypiclassifiers",
        \   "kind": "command",
        \   "action__module_name": v:val,
        \ }'
        \)
endfunction

" unite用のリストを作成する
function! s:get_classfiers_sources()
  " いちいちアクセスするのもあれだし、ファイルに落とし込んでおく
  " let URL = 'https://pypi.python.org/pypi?:action=list_classifiers'
  return readfile('./classifiers.txt')
endfunction


function! s:pythonimport_source.action_table.import_module.func(candidate)
  let module_name = printf('"%s"', a:candidate.action__module_name)
  call s:pythonimport(module_name)
endfunction


function! s:pythonimport_source.action_table.from_module_import_target.func(candidate)
  let module_name = printf('"%s"', a:candidate.action__module_name)
  call s:python_from_import(module_name)
endfunction


function! unite#sources#pypiclassifiers#define()
  return has('python') ? s:pypiclassifiers_source : []
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
