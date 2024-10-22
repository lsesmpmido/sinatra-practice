# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'

FILE_PATH = 'data/quicknote.json'

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
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
  note = notes[params[:id]]
  if note
    @title = note['title']
    @content = note['content']
    erb :show
  else
    status 404
    erb :not_found
  end
end

post '/notes' do
  title = params[:title]
  content = params[:content]
  if title && content
    notes = load_notes(FILE_PATH)
    id = notes.empty? ? '1' : (notes.keys.map(&:to_i).max + 1).to_s
    notes[id] = { 'title' => title, 'content' => content }
    save_notes(FILE_PATH, notes)
    redirect '/notes'
  else
    redirect '/new'
  end
end

get '/notes/:id/edit' do
  notes = load_notes(FILE_PATH)
  note = notes[params[:id]]
  if note
    @title = note['title']
    @content = note['content']
    erb :edit
  else
    redirect '/notes/:id'
  end
end

patch '/notes/:id' do
  title = params[:title]
  content = params[:content]
  if title && content
    notes = load_notes(FILE_PATH)
    notes[params[:id]] = { 'title' => title, 'content' => content }
    save_notes(FILE_PATH, notes)
    redirect "/notes/#{params[:id]}"
  else
    redirect '/notes/:id/edit'
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
