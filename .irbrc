# load libraries
require 'rubygems'

# irbの補完とか。
require 'wirble'
wirble_opts = {
  :skip_prompt  => true,
  :init_color => true,
}

Wirble.init(wirble_opts)
Wirble.colorize
