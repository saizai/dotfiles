Pry.config.editor = 'mate'
Pry.prompt = [proc { |obj, nest_level| "#{RUBY_VERSION} (#{obj}):#{nest_level} > " }, proc { |obj, nest_level| "#{RUBY_VERSION} (#{obj}):#{nest_level} * " }]

# this causes a error on startup when used together w/ pry-stack_explorer
# https://github.com/pry/pry-stack_explorer/issues/20
require "awesome_print"
AwesomePrint.pry!
