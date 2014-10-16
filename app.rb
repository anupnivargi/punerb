require 'sinatra'

get '/' do
  next_meetup_date = Date.parse('2014/11/1')
  @days = (next_meetup_date.mjd - Date.today.mjd).to_i
  erb :index
end

if ENV['RACK_ENV'] == 'development'
  ASSETS_MANIFEST_FILE = 'public/assets_manifest.yml'
  require 'yaml'
  get '/assets/stylesheets/compiled.css' do
    content_type "text/css"
    assets = YAML.load_file ASSETS_MANIFEST_FILE
    styles = assets['stylesheets'].map { |asset| File.open(asset).read }
    styles.join('')
  end

  get '/assets/javascripts/compiled.js' do
    content_type "text/javascript"
    assets = YAML.load_file ASSETS_MANIFEST_FILE
    js = assets['javascripts'].map { |asset| File.open(asset).read }
    js.join('')
  end
end
