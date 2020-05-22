require 'rubygems'
require 'bundler/setup'
require_relative 'grpc_server'
require_relative 'psql_database'
require 'sinatra'
require 'logger'

logger = Logger.new('/proc/1/fd/1')
logger.formatter = proc do |severity, datetime, progname, msg|
    "api: #{msg}\n"
end

logger.warn('Insert sample data')
insert_sample_data

class API < Sinatra::Base

    def fetch_from_database(request) 
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

    get '/' do
        'Welcome to the Sinatra API test'
        puts 'test'
    end

    before do
        content_type 'application/json'
        response['Access-Control-Allow-Origin'] = '*'
    end

    # all getters

    get '/locations' do
        result = fetch_from_database("SELECT name, street, place, description FROM location")
        data = []
        result.each do |row|
            data.append({name: row['name'], street: row['street'], place: row['place'], description: row['description']})
        end
        data.to_json
    end

    get '/welcome' do
        {title: 'Willkommen!', text: 'Nice to see you here!\nLorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.\n\n Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.'}.to_json
    end

    get '/devices' do
        [
            {
                name: 'Butterfly', 
                description: 'Some fancy work', 
                locations: [
                    {name: 'Smart City'},
                    {name: 'Smart City2'}
                ],
                muscles: [
                    {name: "Großer Rückenmuskel"},
                    {name: "Brustmuskel"}
                ],
            },
            {
                name: 'Butterflyer', 
                description: 'Some fancy work', 
                locations: [
                    {name: 'Smart City'},
                    {name: 'Smart City2'}
                ],
                muscles: [
                    {name: "Großer Rückenmuskel"},
                    {name: "Brustmuskel"}
                ],
            },
        ].to_json
    end

    get '/courses' do
        [
            {
                name: 'Spinning',
                description: 'Some fine biking',
                dates: [
                    {
                        day: 1,
                        hour: 18,
                        minutes: 30,
                        duration: 90, 
                        locations: [
                            {name: 'Smart City'},
                            {name: 'Smart City2'}
                        ] ,
                    },
                    {
                        day: 1,
                        hour: 20,
                        minutes: 30,
                        duration: 90, 
                        locations: [
                            {name: 'Smart City'},
                            {name: 'Smart City2'}
                        ] ,
                    },
                    {
                        day: 4,
                        hour: 18,
                        minutes: 30,
                        duration: 90,
                        locations: [
                            {name: 'Smart City'},
                        ] ,
                    },
                ]
            },
            {
                name: 'Zumba',
                description: 'Not some fine biking',
                dates: [
                    {
                        day: 1,
                        hour: 20,
                        minutes: 30,
                        duration: 90, 
                        locations: [
                            {name: 'Smart City'},
                            {name: 'Smart City2'}
                        ] ,
                    },
                    {
                        day: 4,
                        hour: 18,
                        minutes: 30,
                        duration: 90,
                        locations: [
                            {name: 'Smart City'},
                        ] ,
                    },
                ]
            }
        ].to_json
    end

    get '/abo' do
        [
            {name: 'Sparpreis', description: 'Supper viel sparen', costs: 12.99, term: 24},
            {name: 'Normal', description: 'Nicht ganz so viel sparen', costs: 15.99, term: 12},
            {name: 'Teuer', description: 'Nicht sparen', costs: 24.99, term: 1},
        ].to_json
    end

    get '/personal_data:id' do |id|
        {
            id: id, 
            name: 'Karl Marx', 
            birthday: '18.04.1998', 
            tel: 123456789, 
            mail: 'funy@rly.com', 
            height: 190,
            weight: 180,
            performance_level: 5,
            other_activitys: 'Sports',
            diseases: ['Nothing'],
            goal: 'Marathon',
            aviable_time: 2,
            abo_start: '20.04.2009',
            abo: {name: 'Sparpreis', description: 'Supper viel sparen', costs: 12.99, term: 24}
        }.to_json
    end

    get '/anamnesis:id' do |id|
        {
            height: 190,
            weight: 180,
            performance_level: 5,
            other_activitys: 'Sports',
            diseases: ['Nothing'],
            goal: 'Marathon',
            aviable_time: 2,
        }.to_json
    end

    get '/members' do
        [
            {id: 24, name: 'Karl Marx', role: 'Kunde'},
            {id: 42, name: 'Karl Marxnicht', role: 'Trainer'},
        ].to_json
    end

    get '/requests/trainingplan' do
        [
            {id: 24, name: 'Karl Marx', day: '20.04.2020'}
        ].to_json
    end

    get '/requests/treatment' do
        [
            {id: 24, name: 'Karl Marx', day: '20.04.2020'}
        ].to_json
    end

    get '/trainingplan:id' do |id|
        {
            name: 'Starting now',
            note: 'Dont make too much',
            exercises: [
                {
                    device_name: 'Butterfly',
                    sets: 4,
                    repetitions: 8,
                    duration: ''
                }
            ]
        }.to_json
    end

    get '/treatment/note:id' do |id|
        [ 
            {date: '09.03.2020', note: 'No progress at all'},
            {date: '02.03.2020', note: 'He was to late'},
        ].to_json
    end
end

