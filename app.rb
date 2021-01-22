#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

configure do
	@db = SQLite3::Database.new 'barbershop.db'
	@db.execute 'CREATE TABLE IF NOT EXISTS 
	"Users"
	(
		"id" INTEGER PRIMARY KEY AUTOINCREMENT,
		"username" TEXT,
		"phone" TEXT,
		"datestamp" TEXT,
		"barber" TEXT,
		"color" TEXT
	)'
end

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/About' do
	@error = 'something wrong'
	erb :about
end

get '/Visit' do
	erb :visit
end 

post '/visit' do
	
	@username = params[:username]
	@phone    = params[:phone]
	@datetime = params[:datetime]
	@barber   = params[:barber]
	@color    = params[:color]

	hh = {  :username 	=> 'Введите имя',  
			:phone 		=> 'Введите телефон', 
			:datetime 	=> 'Введите дату и время', 
			:barber 	=> 'Введите имя парикхмахера', 
			:color 		=> 'Введите цвет' }

	#Для каждой пары ключ значение
	hh.each do |key,value|

		# если параметр пуст
		if params[key] == ''
			# переменной error присвоить value из хеша hh
			# (а value из хеша hh это сообщенине об ошибке)
			# т.е. переменной error присвоить сообщение об ошибке
			@error = hh[key]

			# вернуть представление visit 
			return erb :visit
		end

	end


	erb "OK, #{@username}, #{@phone}, #{@datetime}, #{@barber}"
end