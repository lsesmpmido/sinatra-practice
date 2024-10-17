# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'

FILE_PATH = 'public/quicknote_db.json'

def generate_escape_character(text)
  Rack::Utils.escape_html(text)
end

def get_notes(file_path)
  File.open(file_path) { |f| JSON.parse(f.read) }
end

def set_notes(file_path, notes)
  File.write(file_path, JSON.pretty_generate(notes))
end

get '/' do
  redirect '/quicknote'
end

get '/quicknote' do
  @notes = get_notes(FILE_PATH)
  erb :index
end

get '/quicknote/new' do
  erb :new
end

get '/quicknote/:id' do
  notes = get_notes(FILE_PATH)
  content = notes[params[:id]]
  if content
    text = content['content'].split
    @title = generate_escape_character(text.shift)
    @content = generate_escape_character(text.join("\r\n"))
    erb :show
  else
    erb :not_found
  end
end

post '/quicknote' do
  content = params[:content]
  notes = get_notes(FILE_PATH)
  id = notes.empty? ? '1' : (notes.keys.map(&:to_i).max + 1).to_s
  notes[id] = { 'content' => content }
  set_notes(FILE_PATH, notes)

  redirect '/quicknote'
end

get '/quicknote/:id/edit' do
  notes = get_notes(FILE_PATH)
  @content = generate_escape_character(notes[params[:id]]['content'])
  erb :edit
end

patch '/quicknote/:id' do
  content = params[:content]
  notes = get_notes(FILE_PATH)
  notes[params[:id]] = { 'content' => content }
  set_notes(FILE_PATH, notes)

  redirect "/quicknote/#{params[:id]}"
end

delete '/quicknote/:id' do
  notes = get_notes(FILE_PATH)
  notes.delete(params[:id])
  set_notes(FILE_PATH, notes)

  redirect '/quicknote'
end

not_found do
  status 404
  erb :not_found
end
