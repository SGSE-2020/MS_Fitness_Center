require 'rubygems'
require 'bundler/setup'
require_relative 'grpc_server'
require_relative 'psql_database'
require 'sinatra'
require 'logger'
require 'set'

#logger = Logger.new('/proc/1/fd/1')
#logger.formatter = proc do |severity, datetime, progname, msg|
#    "api: #{msg}\n"
#end

set :port, 8080

#logger.warn('Insert sample data')
init_db
insert_sample_data

class API < Sinatra::Base

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
        result = fetch_from_database("SELECT device.id, device.name, device.description, muscle.id AS muscle_id, muscle.name AS muscle, location.id AS location_id, location.name AS location
        FROM device 
            INNER JOIN device_muscle ON device.id = device_muscle.device_id
            INNER JOIN muscle ON device_muscle.muscle_id = muscle.id
            INNER JOIN location_device ON device.id = location_device.device_id
            INNER JOIN location ON location_device.location_id = location.id")
        if result == '' then
            return [].to_json()
        end

        data = result.uniq {|row| row['id']}
        data.each do |device|
            device_entries = result.select {|row| row['id'] == device['id']}

            locations = device_entries.uniq {|row| row['location_id']}
            locations.map! {|location| {id: location['location_id'], name: location['location']}}
            device['locations'] = locations

            muscles = device_entries.uniq {|row| row['muscle_id']}
            muscles.map! {|muscle| {id: muscle['muscle_id'], name: muscle['muscle']}}
            device['muscles'] = muscles
        end
        data.map! {|device| {id: device['id'], name: device['name'], description: device['description'], locations: device['locations'], muscles: device['muscles']}}
        data.to_json
    end

    get '/courses' do
        result = fetch_from_database("SELECT course.id, course.name, course.description, date.id AS date_id, date.week_day, date.hour, date.min, date.duration, location.id AS location_id, location.name AS location FROM course 
            INNER JOIN date ON date.course_id = course.id
            INNER JOIN date_location ON date_location.date_id = date.id
            INNER JOIN location ON location.id = date_location.location_id")

        if result == '' then
            return [].to_json()
        end


        # store only uniqe ids
        data = result.uniq {|row| row['id']}
        data.each do |course|
            dates_locations = result.select {|entry| entry['id'].eql? course['id']}

            
            dates = dates_locations.uniq {|entry| entry['date_id']}

            dates.each do |date|
                locations = dates_locations.select {|entry| entry['date_id'] == date['date_id']}
                locations.map! {|loc| {id: loc['location_id'], name: loc['location']}}
                date['locations'] = locations
            end

            course['dates'] = dates.map {|date| {id: date['date_id'], day: date['week_day'], hour: date['hour'], minutes: date['min'], duration: date['duration'], locations: date['locations']}}
        end
        data.map! {|course| {id: course['id'], name: course['name'], description: course['description'], dates: course['dates']}}
        data.to_json

    end

    get '/abo' do
        result = fetch_from_database("SELECT * FROM abo")

        data = []
        result.each do |row|
            data.append(row)
        end
        
        data.to_json
    end

    get '/personal_data/:id' do |id|
        result = fetch_from_database("SELECT member.id, member.role, member.height, member.weight, member.performance_level, member.other_activitys, member.diseases,
        member.goal, member.time_aviability, member.abo_start, member.abo_id, abo.name AS abo_name, abo.costs AS abo_costs, abo.terms AS abo_terms
        FROM member LEFT OUTER JOIN abo ON member.abo_id = abo.id WHERE member.id = '#{id}'")

        #logger = Logger.new('/proc/1/fd/1')
        #logger.formatter = proc do |severity, datetime, progname, msg|
        #    "api: #{msg}\n"
        #end
    
        data = result[0]
        {
            id: data['id'],
            personal_data: {
                name: 'Karl Marx', 
                birthday: '18.04.1998', 
                tel: 123456789, 
                mail: 'funy@rly.com',
            },
            physical_data: {
                height: data['height'],
                weight: data['weight'],
                performance_level: data['performance_level'],
                other_activitys: data['other_activitys'],
                diseases: data['diseases'],
                goal: data['goal'],
                aviable_time: data['time_aviability'],
            },
            abo_information: {
                abo: {
                    id: data['abo_id'],
                    name: data['abo_name'],
                    costs: data['abo_costs'], 
                    term: data['abo_terms']
                },
                abo_start: data['abo_start'],
            }
        }.to_json
    end

    get '/anamnesis/:id' do |id|
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
        result = fetch_from_database("SELECT id, role FROM member")
        data = []

        # TODO: fetch name
        result.each do |row|
            data.append({
                id: row['id'],
                name: "Karl Marx",
                role: row['role']
            })
        end
        data.to_json
    end

    get '/requests/trainingplan' do
        result = fetch_from_database("SELECT * FROM trainingplanrequest")
        data = []

        # TODO: fetch name
        result.each do |row|
            data.append({
                id: row['id'],
                name: "Karl Marx",
                day: row['request_date']
            })
        end
        data.to_json
    end

    get '/requests/treatment' do
        result = fetch_from_database("SELECT * FROM treatmentrequest")
        data = []

        # TODO: fetch name
        result.each do |row|
            data.append({
                id: row['id'],
                name: "Karl Marx",
                day: row['request_date'],
                note: row['note']
            })
        end
        data.to_json
    end

    get '/trainingplan/:id' do |id|
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

    get '/treatment/note/:id' do |id|
        [ 
            {date: '09.03.2020', note: 'No progress at all'},
            {date: '02.03.2020', note: 'He was to late'},
        ].to_json
    end

    post '/requests/trainingplan' do

        data = nil
        begin
            data = JSON.parse(request.body.read)
          rescue
            halt 400, { message:'Invalid JSON' }.to_json
          end

        post_to_database("INSERT INTO trainingplanrequest (request_date, member_id) VALUES(
            '#{data["date"]}',
            #{data["id"]}
        );")

        status 201
        { message: 'Insertions was successfull' }.to_json
    end

    post '/requests/treatment' do
        #logger = Logger.new('/proc/1/fd/1')
        #logger.formatter = proc do |severity, datetime, progname, msg|
        #    "api: #{msg}\n"
        #end

        data = nil
        begin
            data = JSON.parse(request.body.read)
        rescue
            halt 400, { message:'Invalid JSON' }.to_json
        end

        if data["note"] == nil then
            data["note"] = ""
        end

        #logger.warn data
        #post_to_database("INSERT INTO treatmentrequest (request_date, note, member_id) VALUES(
        #    '#{data["date"]}',
        #    '#{data["note"]}',
        #    #{data["id"]}
        #);")

        status 201
        { message: 'Insertions was successfull' }.to_json
    end
        
end

