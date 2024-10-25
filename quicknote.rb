# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'pg'

conn = PG.connect(
  dbname: ENV['DB_NAME'],
  user: ENV['DB_USER'],
  password: ENV['DB_PASSWORD'],
  host: ENV['DB_HOST'], client_encoding: 'UTF-8'
)

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

def read_notes(conn)
  data = {}
  result = conn.exec('SELECT * FROM NOTE')
  result.each do |row|
    data[row['id']] = { 'title' => row['title'], 'content' => row['content'] }
  end
  data
end

def create_notes(conn, title, content)
  conn.exec_params('INSERT INTO NOTE (title, content) VALUES ($1, $2)', [title, content])
end

def update_notes(conn, id, title, content)
  conn.exec_params('UPDATE NOTE SET title = $1, content = $2 WHERE id = $3', [title, content, id])
end

def delete_notes(conn, id)
  conn.exec_params('DELETE FROM NOTE WHERE id = $1', [id])
end

get '/' do
  redirect '/notes'
end

get '/notes' do
  @notes = read_notes(conn)
  erb :index
end

get '/notes/new' do
  erb :new
end

get '/notes/:id' do
  notes = read_notes(conn)
  note = notes[params[:id]]
  if note
    @title = note['title']
    @content = note['content']
    puts "GET title: #{@title} #{@title.encoding} content: #{@content} #{@content.encoding}"
    erb :show
  else
    status 404
    erb :not_found
  end
end

post '/notes' do
  title = params[:title]
  content = params[:content]
  puts "POST title: #{title} #{title.encoding} content: #{content} #{content.encoding}"
  if title && content
    create_notes(conn, title, content)
    redirect '/notes'
  else
    redirect '/new'
  end
end

get '/notes/:id/edit' do
  notes = read_notes(conn)
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
  puts "PATCH title: #{title} #{title.encoding} content: #{content} #{content.encoding}"
  if title && content
    update_notes(conn, params[:id], title, content)
    redirect "/notes/#{params[:id]}"
  else
    redirect '/notes/:id/edit'
  end
end

delete '/notes/:id' do
  delete_notes(conn, params[:id])

  redirect '/notes'
end

not_found do
  status 404
  erb :not_found
end
