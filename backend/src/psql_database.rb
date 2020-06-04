require 'pg'
require 'logger'


def fetch_from_database(request) 
    logger = Logger.new('./log')
    logger.formatter = proc do |severity, datetime, progname, msg|
        "psql: #{msg}\n"
    end
    result = ''
    begin
        # Initialize connection variables.
        host = String('database')
        database = String('fitnesscenter')
        user = String('postgres')
        password = String('1234')
        connection = PG::Connection.new(:host => host, :user => user, :dbname => database, :port => '5432', :password => password)

        result = connection.exec(request)

    rescue PG::Error => e
        logger.warn e.message 
    ensure
        connection.close if connection
    end
    result
end

def post_to_database(request)
    logger = Logger.new('./log')
    logger.formatter = proc do |severity, datetime, progname, msg|
        "psql: #{msg}\n"
    end

    result = ''
    begin
        # Initialize connection variables.
        host = String('database')
        database = String('fitnesscenter')
        user = String('postgres')
        password = String('1234')
        connection = PG::Connection.new(:host => host, :user => user, :dbname => database, :port => '5432', :password => password)

        connection.exec(request)
    rescue PG::Error => e
        logger.warn e.message 
        result = e.message
    ensure
        connection.close if connection
    end
    result
end

def drop_all_tables
    logger = Logger.new('./log')
    logger.formatter = proc do |severity, datetime, progname, msg|
        "psql: #{msg}\n"
    end
    begin
        # Initialize connection variables.
        host = String('database')
        database = String('fitnesscenter')
        user = String('postgres')
        password = String('1234')
    
        # Initialize connection object.
        connection = PG::Connection.new(:host => host, :user => user, :dbname => database, :port => '5432', :password => password)
        logger.warn 'Successfully created connection to database'

        logger.warn 'DROPPING ALL TABLES'    # LOCATION
        logger.warn 'drop location...'
        connection.exec('DROP TABLE IF EXISTS location CASCADE')
    
        # DEVICE
        logger.warn 'drop device...'
        connection.exec('DROP TABLE IF EXISTS device CASCADE')
    
        # COURSE
        logger.warn 'drop course...'
        connection.exec('DROP TABLE IF EXISTS course CASCADE')
    
        # ABO
        logger.warn 'drop abo...'
        connection.exec('DROP TABLE IF EXISTS abo CASCADE')
    
        # MUSCLE
        logger.warn 'drop muscle...'
        connection.exec('DROP TABLE IF EXISTS muscle CASCADE')

        # MEMEBER
        logger.warn 'drop member...'
        connection.exec('DROP TABLE IF EXISTS member CASCADE')


        # TREATMENTNOTE
        logger.warn 'drop treatmentnote...'
        connection.exec('DROP TABLE IF EXISTS treatmentnote CASCADE')

        # DATES
        logger.warn 'drop date...'
        connection.exec('DROP TABLE IF EXISTS date CASCADE')

        # TREATMENTREQUEST
        logger.warn 'drop treatmentrequest...'
        connection.exec('DROP TABLE IF EXISTS treatmentrequest CASCADE')

        # TRAININGPLANREQUEST
        logger.warn 'drop trainingplanrequest...'
        connection.exec('DROP TABLE IF EXISTS trainingplanrequest CASCADE')

        # TRAININGPLAN
        logger.warn 'drop trainingplan...'
        connection.exec('DROP TABLE IF EXISTS trainingplan CASCADE')

        # EXERCISE
        logger.warn 'drop exercise...'
        connection.exec('DROP TABLE IF EXISTS exercise CASCADE')

        # DATE_LOCATION
        logger.warn 'drop date_location...'
        connection.exec('DROP TABLE IF EXISTS date_location CASCADE')

        # LOCATION_DEVICE
        logger.warn 'drop location_device...'
        connection.exec('DROP TABLE IF EXISTS location_device CASCADE')

        # DEVICE_MUSCLE
        logger.warn 'drop device_muscle...'
        connection.exec('DROP TABLE IF EXISTS device_muscle CASCADE')
    rescue PG::Error => e
        logger.warn e.message 
    ensure
        connection.close if connection
    end
end

def init_db

    logger = Logger.new('./log')
    logger.formatter = proc do |severity, datetime, progname, msg|
        "psql: #{msg}\n"
    end
    begin
        drop_all_tables

        # Initialize connection variables.
        host = String('database')
        database = String('fitnesscenter')
        user = String('postgres')
        password = String('1234')

        # Initialize connection object.
        connection = PG::Connection.new(:host => host, :user => user, :dbname => database, :port => '5432', :password => password)
        logger.warn 'Successfully created connection to database'

        logger.warn 'Init database:'

        #############################
        ##### TABLES WITHOUT FK #####
        #############################

        # LOCATION
        logger.warn 'create location...'
        connection.exec('CREATE TABLE IF NOT EXISTS location (
            id SERIAL NOT NULL PRIMARY KEY,
            name TEXT NOT NULL,
            description TEXT NOT NULL,
            street TEXT NOT NULL,
            place TEXT NOT NULL
        );')

        # DEVICE
        logger.warn 'create device...'
        connection.exec('CREATE TABLE IF NOT EXISTS device (
            id SERIAL NOT NULL PRIMARY KEY,
            name TEXT NOT NULL,
            description TEXT NOT NULL
        );')

        # COURSE
        logger.warn 'create course...'
        connection.exec('CREATE TABLE IF NOT EXISTS course (
            id SERIAL NOT NULL PRIMARY KEY,
            name TEXT NOT NULL,
            description TEXT NOT NULL
        );')

        # ABO
        logger.warn 'create abo...'
        connection.exec('CREATE TABLE IF NOT EXISTS abo (
            id SERIAL NOT NULL PRIMARY KEY,
            name TEXT NOT NULL,
            description TEXT NOT NULL,
            costs FLOAT NOT NULL,
            terms INTEGER NOT NULL
        );')

        # MUSCLE
        logger.warn 'create muscle...'
        connection.exec('CREATE TABLE IF NOT EXISTS muscle (
            id SERIAL NOT NULL PRIMARY KEY,
            name TEXT NOT NULL,
            description TEXT
        );')

        ##########################
        ##### TABLES WITH FK #####
        ##########################

        # MEMBER
        logger.warn 'create member...'
        connection.exec('CREATE TABLE IF NOT EXISTS member (
            id TEXT NOT NULL PRIMARY KEY,
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
        logger.warn 'create treatmentnote...'
        connection.exec('CREATE TABLE IF NOT EXISTS treatmentnote (
            id SERIAL NOT NULL PRIMARY KEY,
            day DATE NOT NULL,
            note TEXT NOT NULL,
            member_id TEXT REFERENCES member(id)
        );')

        # DATES
        logger.warn 'create date...'
        connection.exec('CREATE TABLE IF NOT EXISTS date (
            id SERIAL NOT NULL PRIMARY KEY,
            week_day INTEGER NOT NULL,
            hour INTEGER NOT NULL,
            min INTEGER NOT NULL,
            duration INTEGER NOT NULL,
            course_id INTEGER NOT NULL REFERENCES course(id)
        );')

        # TREATMENTREQUEST
        logger.warn 'create treatmentrequest...'
        connection.exec('CREATE TABLE IF NOT EXISTS treatmentrequest (
            id SERIAL NOT NULL PRIMARY KEY,
            request_date DATE NOT NULL,
            note TEXT,
            member_id TEXT NOT NULL REFERENCES member(id)
        );')

        # TRAININGPLANREQUEST
        logger.warn 'create trainingplanrequest...'
        connection.exec('CREATE TABLE IF NOT EXISTS trainingplanrequest (
            id SERIAL NOT NULL PRIMARY KEY,
            request_date DATE NOT NULL,
            member_id TEXT NOT NULL REFERENCES member(id)
        );')

        # TRAININGPLAN
        logger.warn 'create trainingplan...'
        connection.exec('CREATE TABLE IF NOT EXISTS trainingplan (
            id SERIAL NOT NULL PRIMARY KEY,
            name TEXT NOT NULL,
            note TEXT NOT NULL,
            member_id TEXT NOT NULL REFERENCES member(id)
        );')

        # EXERCISE
        logger.warn 'create exercise...'
        connection.exec('CREATE TABLE IF NOT EXISTS exercise (
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
        logger.warn 'create date_location...'
        connection.exec('CREATE TABLE IF NOT EXISTS date_location (
            date_id INTEGER NOT NULL REFERENCES date(id),
            location_id INTEGER NOT NULL REFERENCES location(id),
            PRIMARY KEY (date_id, location_id)
        );')

        # LOCATION_DEVICE
        logger.warn 'create location_device...'
        connection.exec('CREATE TABLE IF NOT EXISTS location_device (
            location_id INTEGER NOT NULL REFERENCES location(id),
            device_id INTEGER NOT NULL REFERENCES device(id),
            PRIMARY KEY (location_id, device_id)
        );')

        # DEVICE_MUSCLE
        logger.warn 'create device_muscle...'
        connection.exec('CREATE TABLE IF NOT EXISTS device_muscle (
            device_id INTEGER NOT NULL REFERENCES device(id),
            muscle_id INTEGER NOT NULL REFERENCES muscle(id),
            PRIMARY KEY (device_id, muscle_id)
        );')



        # list all tables
        logger.warn "\nAll tables:"
        result = connection.exec('SELECT * FROM pg_catalog.pg_tables WHERE schemaname != \'pg_catalog\' AND schemaname != \'information_schema\';')
        result.each do |row|
            logger.warn "%s" % [ row['tablename']]
        end

    rescue PG::Error => e
        logger.warn e.message 
    ensure
        connection.close if connection
    end
end

def insert_sample_data
    begin
        logger = Logger.new('./log')
        logger.formatter = proc do |severity, datetime, progname, msg|
            "psqlSampleData: #{msg}\n"
        end

        # Initialize connection variables.
        host = String('database')
        database = String('fitnesscenter')
        user = String('postgres')
        password = String('1234')
    
        # Initialize connection object.
        connection = PG::Connection.new(:host => host, :user => user, :dbname => database, :port => '5432', :password => password)
        logger.warn 'Successfully created connection to database'

        logger.warn 'INSERT EXAMPLE DATA'    # LOCATION

        # Delete old data
        connection.exec("DELETE FROM exercise")
        connection.exec("DELETE FROM trainingplan")
        connection.exec("DELETE FROM treatmentnote")
        connection.exec("DELETE FROM trainingplanrequest")
        connection.exec("DELETE FROM treatmentrequest")
        connection.exec("DELETE FROM member")
        connection.exec("DELETE FROM abo")
        connection.exec("DELETE FROM date_location")
        connection.exec("DELETE FROM date")
        connection.exec("DELETE FROM course")
        connection.exec("DELETE FROM location_device")
        connection.exec("DELETE FROM device_muscle")
        connection.exec("DELETE FROM muscle")
        connection.exec("DELETE FROM device")
        connection.exec("DELETE FROM location")


        # LOCATION
        connection.exec("INSERT INTO location VALUES(
            DEFAULT,
            'Smart City - Straße 7',
            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
            'Straße 7',
            '4242 Smart City'
        );")
        connection.exec("INSERT INTO location VALUES(
            DEFAULT,
            'Smart City - Straße 73',
            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
            'Straße 73',
            '4242 Smart City'
        );")

        # DEVICES
        connection.exec("INSERT INTO device VALUES(
            DEFAULT,
            'Butterfly',
            'Mit der Butterfly-Maschine trainierst Du primär Deine Brustmuskulatur. Die Brustmuskeln (musculus pectoralis major et minor) sind für das Zusammenführen der Arme vor dem Körper zuständig. Bei der eGym Butterfly-Maschine wird die Brustmuskulatur im Gegensatz zu anderen Brust Übungen wie Liegestützen über den vollen Bewegungsumfang trainiert. Hier müssen Deine Brustmuskeln auch im Endpunkt maximal arbeiten. Insbesondere die inneren Bereiche der Brust werden so stärker trainiert. Eine gut ausgebildete Brustmuskulatur ist für die Stabilisierung und somit für die Gesundheit des Schultergelenks unerlässlich.'
        );")
        connection.exec("INSERT INTO device VALUES(
            DEFAULT,
            'Beinstrecker',
            'Mit dem Beinstrecker trainierst Du Deine vorderen Oberschenkelmuskeln, d. h. den vierköpfigen Oberschenkelmuskel (Musculus quadriceps femoris). Der Quadrizeps ist der Muskel mit der größten Muskelmasse im Körper und besteht aus vier Köpfen oder Teilen, dem geraden Oberschenkelmuskel (Musculus rectus femoris), dem inneren Oberschenkelmuskel (Musculus vastus medialis), dem mittleren Oberschenkelmuskel (Musculus vastus intermedius) und dem äußeren Oberschenkelmuskel (Musculus vastus lateralis). Die Hauptfunktion Deiner vorderen Oberschenkelmuskulatur ist die Kniestreckung, wie z. B. beim Laufen und Springen.'
        );")

        # MUSCLE
        connection.exec("INSERT INTO muscle VALUES(
            DEFAULT,
            'Brustmuskel',
            ''
        );")
        connection.exec("INSERT INTO muscle VALUES(
            DEFAULT,
            'Vorderer Armmuskel',
            ''
        );")
        connection.exec("INSERT INTO muscle VALUES(
            DEFAULT,
            'Vorderer Oberschenkelmuskel',
            ''
        );")

        # DEVICE_MUSCLE
        connection.exec("INSERT INTO device_muscle VALUES(
            1,
            1
        );")
        connection.exec("INSERT INTO device_muscle VALUES(
            1,
            2
        );")
        connection.exec("INSERT INTO device_muscle VALUES(
            2,
            3
        );")

        # LOCATION_DEVICE
        connection.exec("INSERT INTO location_device VALUES(
            1,
            1
        );")
        connection.exec("INSERT INTO location_device VALUES(
            2,
            1
        );")
        connection.exec("INSERT INTO location_device VALUES(
            1,
            2
        );")

        # COURSE
        connection.exec("INSERT INTO course VALUES(
            DEFAULT,
            'Spinning',
            'Im Gegensatz zum Heimfahrrad oder Ergometer ist das Spinning-Bike ein Standrad mit Starrlauf, mit dem man das tatsächliche Radtraining sinnvoll simulieren bzw. um spezielle Technik-Drills ergänzen kann. Mentale Hilfen, zum Beispiel Visualisierung, und spezielle Atemtechniken kommen ebenfalls zum Einsatz. '
        );")
        connection.exec("INSERT INTO course VALUES(
            DEFAULT,
            'Bodyatack',
            'BODYATTACK ist eine hochintensive Fitness-Class mit Bewegungsabläufen, die sowohl für absolute Anfänger als auch für Fitness-Freaks geeignet sind. Dieses Workout kombiniert athletische Bewegung wie Laufen, Ausfallschritte oder Springen mit Kraftübungen wie Push-Ups und Squats. Ein Instruktor führt dich mit energiegeladener Musik durchs Workout und motiviert dich dazu, an deine Grenzen zu gehen. Dabei verbrennst du bis zu 730 Kalorien^ und fühlst dich danach einfach großartig.'
        );")

        # DATES
        connection.exec("INSERT INTO date VALUES(
            DEFAULT,
            0,
            18,
            30,
            60,
            1
        );")
        connection.exec("INSERT INTO date VALUES(
            DEFAULT,
            3,
            19,
            00,
            40,
            1
        );")
        connection.exec("INSERT INTO date VALUES(
            DEFAULT,
            1,
            18,
            00,
            45,
            2
        );")
        connection.exec("INSERT INTO date VALUES(
            DEFAULT,
            5,
            14,
            00,
            55,
            2
        );")

        # DATE_LOCATION
        connection.exec("INSERT INTO date_location VALUES(
            1,
            1
        );")
        connection.exec("INSERT INTO date_location VALUES(
            1,
            2
        );")
        connection.exec("INSERT INTO date_location VALUES(
            2,
            1
        );")
        connection.exec("INSERT INTO date_location VALUES(
            2,
            2
        );")
        connection.exec("INSERT INTO date_location VALUES(
            3,
            1
        );")
        connection.exec("INSERT INTO date_location VALUES(
            3,
            2
        );")
        connection.exec("INSERT INTO date_location VALUES(
            4,
            2
        );")

        # ABO
        connection.exec("INSERT INTO abo VALUES(
            DEFAULT,
            'Flex',
            'Die Vertragslaufzeit der Mitgliedsverträge mit einer Mindestvertragslaufzeit unter 12 Monate verlängern sich jeweils um die online ausgewählte Laufzeit, wenn der „Mitgliedsvertrag“ nicht vom Mitglied oder von EASYFITNESS unter Einhaltung einer Kündigungsfrist von mindestens 1 Monat vor dem jeweiligen Vertragsende gekündigt wird. ',
            39.90,
            1
        );")
        connection.exec("INSERT INTO abo VALUES(
            DEFAULT,
            'Service 12',
            'Die Vertragslaufzeit der Mitgliedsverträge mit einer Mindestvertragslaufzeit unter 12 Monate verlängern sich jeweils um die online ausgewählte Laufzeit, wenn der „Mitgliedsvertrag“ nicht vom Mitglied oder von EASYFITNESS unter Einhaltung einer Kündigungsfrist von mindestens 1 Monat vor dem jeweiligen Vertragsende gekündigt wird. ',
            29.90,
            12
        );")
        connection.exec("INSERT INTO abo VALUES(
            DEFAULT,
            'Service 24',
            'Die Vertragslaufzeit der Mitgliedsverträge mit einer Mindestvertragslaufzeit unter 12 Monate verlängern sich jeweils um die online ausgewählte Laufzeit, wenn der „Mitgliedsvertrag“ nicht vom Mitglied oder von EASYFITNESS unter Einhaltung einer Kündigungsfrist von mindestens 1 Monat vor dem jeweiligen Vertragsende gekündigt wird. ',
            25.90,
            24
        );")

        # MEMBER
        connection.exec("INSERT INTO member VALUES(
            '1',
            0,
            190,
            75,
            4,
            'Fußball',
            '',
            'Gewichtszunahme',
            '2',
            '2020-01-01',
            2
        );")
        connection.exec("INSERT INTO member VALUES(
            '2',
            1,
            190,
            75,
            4,
            'Fußball',
            '',
            'Gewichtszunahme',
            '2'
        );")
        connection.exec("INSERT INTO member VALUES(
            '3',
            2,
            190,
            75,
            4,
            'Fußball',
            '',
            'Gewichtszunahme',
            '2'
        );")

        # TREATMENTREQUEST
        connection.exec("INSERT INTO treatmentrequest VALUES(
            DEFAULT,
            '2020-05-23',
            'Verletzung am Fuß',
            '1'
        );")

        # TRAININGPLANREQUEST
        connection.exec("INSERT INTO trainingplanrequest VALUES(
            DEFAULT,
            '2020-05-23',
            '1'
        );")

        # TREATMENTNOTE
        connection.exec("INSERT INTO treatmentnote VALUES(
            DEFAULT,
            '2020-02-17',
            'Er stellt sich ziemlich an...',
            '1'
        );")

        # TRAININGPLAN
        connection.exec("INSERT INTO trainingplan VALUES(
            DEFAULT,
            'Fit mit 2 Übungen',
            'Siehe Titel',
            '1'
        );")

        # EXERCISE
        connection.exec('INSERT INTO exercise VALUES(
            1,
            1,
            3,
            10
        );')
        connection.exec('INSERT INTO exercise VALUES(
            1,
            2,
            3,
            10
        );')

    rescue PG::Error => e
        logger.warn e.message 
    ensure
        connection.close if connection
    end

end

