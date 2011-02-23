"compiler php
"au BufWritePost * silent make %
set makeprg=php\ -l\ %
set errorformat=%m\ in\ %f\ on\ line\ %l

set fileencoding=utf-8

setlocal dictionary+=~/.vim/dict/php_functions.dict
setlocal tags+=~/.vim/dict/zend.php.tags
setlocal tags+=~/.vim/dict/phpunit.php.tags
setlocal tags+=~/.vim/dict/phpexcel.php.tags

