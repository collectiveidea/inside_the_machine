require 'sinatra'

set :root, File.dirname(__FILE__)
set :public_folder, 'html'

get '/' do
  File.open('html/frontmatter.html', File::RDONLY)
end
