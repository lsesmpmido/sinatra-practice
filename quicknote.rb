# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'

FILE_PATH = 'data/quicknote.json'

def generate_escape_character(text)
  Rack::Utils.escape_html(text)
end

def load_notes(file_path)
  File.open(file_path) { |f| JSON.parse(f.read) }
end

def save_notes(file_path, notes)
  File.write(file_path, JSON.dump(notes))
end

get '/' do
  redirect '/notes'
end

get '/notes' do
  @notes = load_notes(FILE_PATH)
  erb :index
end

get '/notes/new' do
  erb :new
end

get '/notes/:id' do
  notes = load_notes(FILE_PATH)
  content = notes[params[:id]]
  if content
    @title = content['title']
    @content = content['content']
    erb :show
  else
    status 404
    erb :not_found
  end
end

post '/notes' do
  title = generate_escape_character(params[:title])
  content = generate_escape_character(params[:content])
  if title && content
    notes = load_notes(FILE_PATH)
    id = notes.empty? ? '1' : (notes.keys.map(&:to_i).max + 1).to_s
    notes[id] = { 'title' => title, 'content' => content }
    save_notes(FILE_PATH, notes)
    redirect '/notes'
  else
    status 422
    redirect '/new'
  end
end

get '/notes/:id/edit' do
  notes = load_notes(FILE_PATH)
  content = notes[params[:id]]
  if content
    @title = content['title']
    @content = content['content']
    erb :edit
  else
    erb :not_found
  end
end

patch '/notes/:id' do
  title = generate_escape_character(params[:title])
  content = generate_escape_character(params[:content])
  if title && content
    notes = load_notes(FILE_PATH)
    notes[params[:id]] = { 'title' => title, 'content' => content }
    save_notes(FILE_PATH, notes)
    redirect "/notes/#{params[:id]}"
  else
    erb :not_found
  end
end

delete '/notes/:id' do
  notes = load_notes(FILE_PATH)
  notes.delete(params[:id])
  save_notes(FILE_PATH, notes)

  redirect '/notes'
end

not_found do
  status 404
  erb :not_found
end
