"compiler php
"au BufWritePost * silent make %
setlocal makeprg=php\ -l\ %
setlocal errorformat=%m\ in\ %f\ on\ line\ %l
setlocal dictionary+=~/.vim/dict/php_functions.dict
"setlocal tags+=~/.vim/dict/zend.php.tags
"setlocal tags+=~/.vim/dict/phpunit.php.tags
"setlocal tags+=~/.vim/dict/phpexcel.php.tags

setlocal tabstop=4
setlocal expandtab
setlocal shiftwidth=4
setlocal autoindent
setlocal softtabstop=4

