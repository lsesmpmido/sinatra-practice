# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'

FILE_PATH = 'public/quicknote_db.json'

def to_escape(text)
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
  text = notes[params[:id]]['content'].split
  @title = to_escape(text.shift)
  @content = to_escape(text.join("\r\n"))
  erb :show
end

post '/quicknote' do
  content = params[:content]
  notes = get_notes(FILE_PATH)
  id = (notes.keys.map(&:to_i).max + 1).to_s
  notes[id] = { 'content' => content }
  set_notes(FILE_PATH, notes)

  redirect '/quicknote'
end

get '/quicknote/:id/edit' do
  notes = get_notes(FILE_PATH)
  @content = to_escape(notes[params[:id]]['content'])
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
