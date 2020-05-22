
require 'pg'

require 'pg'

begin
	# Initialize connection variables.
	host = String('localhost')
	database = String('mydb')
    user = String('postgres')
	password = String('1234')

	# Initialize connection object.
    connection = PG::Connection.new(:host => host, :user => user, :dbname => database, :port => '5432', :password => password)
    puts 'Successfully created connection to database'

    puts 'Init database:'

    #############################
    ##### TABLES WITHOUT FK #####
    #############################

    # LOCATION
    puts 'create location...'
    connection.exec('CREATE TABLE IF NOT EXISTS location (
        id SERIAL NOT NULL PRIMARY KEY,
        description TEXT NOT NULL,
        street TEXT NOT NULL,
        place TEXT NOT NULL
    );')

    # DEVICE
    puts 'create device...'
    connection.exec('CREATE TABLE IF NOT EXISTS device (
        id SERIAL NOT NULL PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT NOT NULL
    );')

    # COURSE
    puts 'create course...'
    connection.exec('CREATE TABLE IF NOT EXISTS course (
        id SERIAL NOT NULL PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT NOT NULL
    );')

    # ABO
    puts 'create abo...'
    connection.exec('CREATE TABLE IF NOT EXISTS abo (
        id SERIAL NOT NULL PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        costs FLOAT NOT NULL,
        terms INTEGER NOT NULL
    );')

    # MUSCLE
    puts 'create muscle...'
    connection.exec('CREATE TABLE IF NOT EXISTS muscle (
        id SERIAL NOT NULL PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT
    );')

    ##########################
    ##### TABLES WITH FK #####
    ##########################

    # MEMBER
    puts 'create member...'
    connection.exec('CREATE TABLE IF NOT EXISTS member (
        id SERIAL NOT NULL PRIMARY KEY,
        role INTEGER NOT NULL,
        height INTEGER,
        weight INTEGER,
        performance_level INTEGER,
        other_activitys TEXT,
        diseases TEXT,
        goal TEXT,
        time_aviability INTEGER,
        abo_start DATE,
        abo_id INTEGER REFERENCES abo(id)
    );')

    # TREATMENTNOTE
    puts 'create treatmentnote...'
    connection.exec('CREATE TABLE IF NOT EXISTS treatmentnote (
        id SERIAL NOT NULL PRIMARY KEY,
        day DATE NOT NULL,
        note TEXT NOT NULL,
        member_id INTEGER REFERENCES member(id)
    );')

    # DATES
    puts 'create date...'
    connection.exec('CREATE TABLE IF NOT EXISTS date (
        id SERIAL NOT NULL PRIMARY KEY,
        week_day INTEGER NOT NULL,
        duration INTEGER NOT NULL,
        course_id INTEGER NOT NULL REFERENCES course(id)
    );')

    # TREATMENTREQUEST
    puts 'create treatmentrequest...'
    connection.exec('CREATE TABLE IF NOT EXISTS treatmentrequest (
        id SERIAL NOT NULL PRIMARY KEY,
        request_date DATE NOT NULL,
        note TEXT,
        member_id INTEGER NOT NULL REFERENCES member(id)
    );')

    # TRAININGPLANREQUEST
    puts 'create trainingplanrequest...'
    connection.exec('CREATE TABLE IF NOT EXISTS trainingplanrequest (
        id SERIAL NOT NULL PRIMARY KEY,
        request_date DATE NOT NULL,
        member_id INTEGER NOT NULL REFERENCES member(id)
    );')

    # TRAININGPLAN
    puts 'create trainingplan...'
    connection.exec('CREATE TABLE IF NOT EXISTS trainingplan (
        id SERIAL NOT NULL PRIMARY KEY,
        name TEXT NOT NULL,
        note TEXT NOT NULL,
        member_id INTEGER NOT NULL REFERENCES member(id)
    );')

    # EXERCISE
    puts 'create exercise...'
    connection.exec('CREATE TABLE IF NOT EXISTS trainingplan (
        trainingplan_id INTEGER NOT NULL REFERENCES trainingplan(id),
        device_id INTEGER NOT NULL REFERENCES device(id),
        sets INTEGER NOT NULL,
        repetitions INTEGER,
        duration INTEGER,
        PRIMARY KEY(trainingplan_id, device_id)
    );')

    ###############################
    ##### TABLES WITH ONLY FK #####
    ###############################

    # DATE_LOCATION
    puts 'create date_location...'
    connection.exec('CREATE TABLE IF NOT EXISTS date_location (
        date_id INTEGER NOT NULL REFERENCES date(id),
        location_id INTEGER NOT NULL REFERENCES location(id),
        PRIMARY KEY (date_id, location_id)
    );')

    # LOCATION_DEVICE
    puts 'create location_device...'
    connection.exec('CREATE TABLE IF NOT EXISTS location_device (
        location_id INTEGER NOT NULL REFERENCES location(id),
        device_id INTEGER NOT NULL REFERENCES device(id),
        PRIMARY KEY (location_id, device_id)
    );')

    # DEVICE_MUSCLE
    puts 'create device_muscle...'
    connection.exec('CREATE TABLE IF NOT EXISTS device_muscle (
        device_id INTEGER NOT NULL REFERENCES device(id),
        muscle_id INTEGER NOT NULL REFERENCES muscle(id),
        PRIMARY KEY (device_id, muscle_id)
    );')



    # list all tables
    puts "\nAll tables:"
    result = connection.exec('SELECT * FROM pg_catalog.pg_tables WHERE schemaname != \'pg_catalog\' AND schemaname != \'information_schema\';')
    result.each do |row|
        puts "%s" % [ row['tablename']]
      end

rescue PG::Error => e
    puts e.message 
ensure
    connection.close if connection
end

def insert_sample_data

end

def drop_all_tables
    begin
        # Initialize connection variables.
        host = String('localhost')
        database = String('mydb')
        user = String('postgres')
        password = String('1234')
    
        # Initialize connection object.
        connection = PG::Connection.new(:host => host, :user => user, :dbname => database, :port => '5432', :password => password)
        puts 'Successfully created connection to database'

        puts 'DROPPING ALL TABLES'    # LOCATION
        puts 'drop location...'
        connection.exec('DROP TABLE IF EXISTS location CASCADE')
    
        # DEVICE
        puts 'drop device...'
        connection.exec('DROP TABLE IF EXISTS device CASCADE')
    
        # COURSE
        puts 'drop course...'
        connection.exec('DROP TABLE IF EXISTS course CASCADE')
    
        # ABO
        puts 'drop abo...'
        connection.exec('DROP TABLE IF EXISTS abo CASCADE')
    
        # MUSCLE
        puts 'drop muscle...'
        connection.exec('DROP TABLE IF EXISTS muscle CASCADE')

    rescue PG::Error => e
        puts e.message 
    ensure
        connection.close if connection
    end
end