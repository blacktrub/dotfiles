function! neoformat#formatters#go#enabled() abort
    return ['gofmt']
endfunction

function! neoformat#formatters#go#gofmt() abort
    return {'exe': 'gofmt'}
endfunction
