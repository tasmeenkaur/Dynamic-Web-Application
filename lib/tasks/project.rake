namespace :project do
  require 'open-uri'
  require 'mysql2'
  require 'json'
  require 'mysql'
  require 'mongo'
  desc "TODO"
# CODE TO LOAD DATA TO MYSQL
  task dataSql: :environment do
      out_file = File.read("config/info.json")
        data_hash= JSON.parse(out_file)
        cmd = "mysql -h "+data_hash["host"].to_s+" "+" -u"+data_hash["username"].to_s+" "+"-p"+data_hash["password"].to_s+" -e \"CREATE DATABASE IF NOT EXISTS phase2;\""
        puts cmd
        if cmd
          puts "Database initialized"
        end
        result = system(cmd)
          conn = Mysql.new(data_hash["host"], data_hash["username"], data_hash["password"], 'phase2' )
          puts conn
          conn.query("create table if not exists p1(id int primary key auto_increment, breed varchar(10), intake_condition varchar(20),sex varchar(2), coat_color_pattern varchar(20) ,days_old varchar(20) , intake_subtype varchar(20) , years_old varchar(20) , intake_date varchar(20) , months_old varchar(20) , animal_type varchar(20) , intake_type varchar(20) )")
          
    request_uri = 'https://data.austintexas.gov/resource/wrwk-skv6.json'
    request_query = ''
    url = "#{request_uri}#{request_query}"
    buffer = open(url).read
    result = JSON.parse(buffer)
    result = result.sample(10000)
 
    $z = 1
    $n = 11
    while $z < $n  do
     result.each  do |user|
      q = "INSERT INTO p1(breed,intake_condition,sex, coat_color_pattern,days_old , intake_subtype , years_old, intake_date  , months_old , animal_type , intake_type) VALUES('#{user['breed']}','#{user['intake_condition']}','#{user['sex']}','#{user['coat_color_pattern']}','#{user['days_old']}','#{user['intake_subtype']}','#{user['years_old']}','#{user['intake_date']}','#{user['months_old']}','#{user['animal_type']}','#{user['intake_type']}')"
      puts q
      conn.query(q)
      puts "Data inserted"
    end
    $z +=1
    end
end
###########################################################################
  desc "TODO"
  task dataNosql: :environment do
    request_uri = 'https://data.austintexas.gov/resource/wrwk-skv6.json'
    request_query = ''
    url = "#{request_uri}#{request_query}"
    buffer = open(url).read
    result = JSON.parse(buffer)
    result = result.sample(10000)
    con = Mongo::Client.new([ '127.0.0.1:27017' ], :database => 'phase2', :connect => :direct)
    $i = 1
    $num = 11
    while $i < $num  do
     result.each { |x|
     res = con[:ps].insert_one(x) 
     puts res
     }
     $i +=1
    end
    puts "DATA INSERTED"
  end
#############################################################################
#CODE TO QUERY SQL DATA
  desc "TODO"
  task querySql: :environment do
    out_file = File.read("config/info.json")
    data_hash= JSON.parse(out_file)
        cmd = "mysql -h "+data_hash["host"].to_s+" "+" -u"+data_hash["username"].to_s+" "+"-p"+data_hash["password"].to_s+" -e \"USE phase2;\""
        puts cmd
        result = system(cmd)
        conn = Mysql.new(data_hash["host"], data_hash["username"], data_hash["password"], 'phase2' )
        q1 = conn.query("SELECT * FROM p1 WHERE id = 89 ")
        puts q1.fetch_row.join("\s")
        puts "query to select primary key = 89 executed"
      q2 = conn.query("SELECT * FROM p1 WHERE coat_color_pattern = 'chocolate' ")
      q2.each do |row|
      puts row.join("\s")
    end
      puts "query to select coat_color_pattern = chocolate executed"
  conn.close
 end
####################################################################################
#code to query no sql data
  desc "TODO"
  task queryNosql: :environment do
    db = Mongo::Client.new([ '127.0.0.1:27017' ], :database => 'phase2', :connect => :direct)
    coll = db['ps']
    coll.find({:breed => 'PIT BULL'}).each {|row| puts row.inspect }
    puts "query to select data with breed = pit bull executed"
    coll.find({:_id => "5519bb0e7562752b0b000012" }).each {|row| puts row.end }
    puts "query to select id executed"
    #coll.ObjectId("5519bb0e7562752b0b000012").valueof()
  end

end
