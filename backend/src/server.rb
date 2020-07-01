require 'rubygems'
require 'bundler/setup'
require_relative 'grpc_server'
require_relative 'grpc_client'
require_relative 'psql_database'
require 'sinatra'
require 'logger'
require 'set'

#logger = Logger.new('/proc/1/fd/1')
#logger.formatter = proc do |severity, datetime, progname, msg|
#    "api: #{msg}\n"
#end

#logger.warn('Insert sample data')

#init_db
#insert_sample_data

class API < Sinatra::Base

    set :port, 8080
    set :protection, :except => [:frame_options, :json_csrf]

    get '/' do
        'Welcome to the Sinatra API test'
        puts 'test'
    end

    before do
        content_type 'application/json'
    end

    # all getters

    get '/locations' do
        result = fetch_from_database("SELECT id, name, street, place, description FROM location")
        if result == '' then
            return [].to_json()
        end

        data = []
        result.each do |row|
            data.append({
                id: row['id'].to_i, 
                name: row['name'], 
                street: row['street'], 
                place: row['place'], 
                description: 
                row['description']
            })
        end
        data.to_json
    end

    get '/welcome' do
        {
            title: 'Willkommen!',
            text: 'Nice to see you here!\nLorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.\n\n Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.'
        }.to_json
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
            locations.map! {|location| {id: location['location_id'].to_i, name: location['location']}}
            device['locations'] = locations

            muscles = device_entries.uniq {|row| row['muscle_id']}
            muscles.map! {|muscle| {id: muscle['muscle_id'].to_i, name: muscle['muscle']}}
            device['muscles'] = muscles
        end
        data.map! {|device| {id: device['id'].to_i, name: device['name'], description: device['description'], locations: device['locations'], muscles: device['muscles']}}
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
                locations.map! {|loc| {id: loc['location_id'].to_i, name: loc['location']}}
                date['locations'] = locations
            end

            course['dates'] = dates.map {|date| {id: date['date_id'].to_i, day: date['week_day'].to_i, hour: date['hour'].to_i, minutes: date['min'].to_i, duration: date['duration'].to_i, locations: date['locations']}}
        end
        data.map! {|course| {id: course['id'].to_i, name: course['name'], description: course['description'], dates: course['dates']}}
        data.to_json

    end

    get '/abo' do
        result = fetch_from_database("SELECT * FROM abo")
        if result == '' then
            return [].to_json()
        end

        data = []
        result.each do |row|
            row["id"] = row["id"].to_i
            row["costs"] = row["costs"].to_f
            row["terms"] = row["terms"].to_i
            data.append(row)
        end
        
        data.to_json
    end

    get '/personal_data/:id' do |id|
        result = fetch_from_database("SELECT member.id, member.role, member.height, member.weight, member.performance_level, member.other_activitys, member.diseases,
        member.goal, member.time_aviability, member.abo_start, member.abo_id, abo.name AS abo_name, abo.costs AS abo_costs, abo.terms AS abo_terms
        FROM member LEFT OUTER JOIN abo ON member.abo_id = abo.id WHERE member.id = '#{id}'")
        if result == '' || result.ntuples() == 0 then
            return {
                id: -1,
                personal_data: {
                    name: '-', 
                    birthday: '-', 
                    tel: 0, 
                    mail: '-',
                },
                physical_data: {
                    height: 0,
                    weight: 0,
                    performance_level: 0,
                    other_activitys: 0,
                    diseases: '-',
                    goal: '-',
                    aviable_time: '-',
                },
                abo_information: {
                    abo: {
                        id: -1,
                        name: '-',
                        costs: 0, 
                        term: 0
                    },
                    abo_start: '-',
                }
            }.to_json
        end

        #logger = Logger.new('/proc/1/fd/1')
        #logger.formatter = proc do |severity, datetime, progname, msg|
        #    "api: #{msg}\n"
        #end
        #logger.warn result.ntuples() 
        data = result[0]
        user_data = get_user_information data['id']
        {
            id: if user_data != nil && user_data.uid != nil && user_data.uid != "" then user_data.uid else data['id'] end,
            personal_data: {
                name: if user_data != nil && user_data.firstName != nil && user_data.firstName != "" then "#{user_data.firstName} #{user_data.lastName}" else "-" end, 
                birthday: if user_data != nil && user_data.birthDate != nil && user_data.birthDate != "" then user_data.birthDate else "-" end, 
                tel: if user_data != nil && user_data.phone != nil && user_data.phone != "" then user_data.phone else "-" end,
                mail: if user_data != nil && user_data.email != nil && user_data.email != "" then user_data.email else "-" end,
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
        if result == '' then
            return [].to_json()
        end
        data = []

        # TODO: fetch name
        result.each do |row|
            user_data = get_user_information row['id']
            id = if user_data != nil && user_data.uid != nil && user_data.uid != "" then user_data.uid else row['id'] end
            name = if user_data != nil && user_data.firstName != nil && user_data.firstName != "" then "#{user_data.firstName} #{user_data.lastName}" else "-" end
            data.append({
                id: id,
                name: name,
                role: row['role'].to_i
            })
        end
        data.to_json
    end

    get '/requests/trainingplan' do
        result = fetch_from_database("SELECT * FROM trainingplanrequest")
        if result == '' then
            return [].to_json()
        end
        data = []

        # TODO: fetch name
        result.each do |row|
            data.append({
                id: row['id'].to_i,
                name: "Karl Marx",
                day: row['request_date']
            })
        end
        data.to_json
    end

    get '/requests/treatment' do
        result = fetch_from_database("SELECT * FROM treatmentrequest")
        if result == '' then
            return [].to_json()
        end
        data = []

        # TODO: fetch name
        result.each do |row|
            data.append({
                id: row['id'].to_i,
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
            {id: 1, date: '09.03.2020', note: 'No progress at all'},
            {id: 2, date: '02.03.2020', note: 'He was to late'},
        ].to_json
    end

    get '/role/:id' do |id|
        result = fetch_from_database("SELECT role FROM member WHERE member.id = '#{id}'")
        if result == '' || result.ntuples() == 0 then
            return {
                id: id,
                role: -1
            }.to_json
        end
        data = result[0]
        {
            id: id,
            role: data["role"].to_i
        }.to_json
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

        status 200
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
        post_to_database("INSERT INTO treatmentrequest (request_date, note, member_id) VALUES(
            '#{data["date"]}',
            '#{data["note"]}',
            #{data["id"]}
        );")

        status 200
        { message: 'Insertions was successfull' }.to_json
    end

    post '/personal_data' do
        data = nil
        begin
            data = JSON.parse(request.body.read)
        rescue
            halt 400, { message:'Invalid JSON' }.to_json
        end
        # TODO: validate by token

        data['height'] = data['height'] == "" ? "NULL" : data['height']
        data['weight'] = data['weight'] == "" ? "NULL" : data['weight']
        data['performance_level'] = data['performance_level'] == "" ? "NULL" : data['performance_level']
        data['time_aviability'] = data['time_aviability'] == "" ? "NULL" : data['time_aviability']
        
        post_to_database("UPDATE member
        SET 
            height = #{data['height']}, 
            weight = #{data['weight']}, 
            performance_level = #{data['performance_level']}, 
            other_activitys = '#{data['other_activitys']}',
            diseases = '#{data['diseases']}',
            goal = '#{data['goal']}',
            time_aviability = #{data['time_aviability']}
        WHERE id = '#{data['id']}';")
        status 200
        { message: 'Insertions was successfull' }.to_json

    end

    post '/members/add' do
        begin
            data = JSON.parse(request.body.read)
        rescue
            halt 400, { message:'Invalid JSON' }.to_json
        end

        logger = Logger.new('./log')
        logger.formatter = proc do |severity, datetime, progname, msg|
            "api: #{msg}\n"
        end

        if data['abo_id'] == nil then
            data['abo_id'] = "NULL"
        end
        if data['abo_start'] == nil then
            data['abo_start'] = "NULL"
        else
            data['abo_start'] = "'#{data['abo_start']}'"
        end

        #test_local

        user_data = get_user_information data['uid']
        logger.warn user_data
        if user_data == nil then
            logger.warn "Invalid user"
            status 400
            return { message:'Could not reach buergerbuero. Got nil as answer.' }.to_json
        end

        if user_data.uid == nil || user_data.uid == "" then
            logger.warn "Invalid user"
            status 400
            return { message:'The userid is nil. The user does not exist.' }.to_json
        end

        post_to_database("INSERT INTO member (id, role, abo_id, abo_start) VALUES(
            '#{user_data.uid}', 
            #{data['role']}, 
            #{data['abo_id']}, 
            #{data['abo_start']}
        )")


        return { message:user_data.uid, uid: user_data.uid}.to_json
    end

    delete '/member/:id' do |id|
        delete_entry(
            "DELETE FROM trainingplanrequest WHERE member_id = '#{id}';
            DELETE FROM treatmentrequest WHERE member_id = '#{id}';
            DELETE FROM treatmentnote WHERE member_id = '#{id}';

            DELETE FROM exercise WHERE trainingplan_id in (SELECT id FROM trainingplan WHERE member_id = '#{id}');
            DELETE FROM trainingplan WHERE member_id = '#{id}';

            DELETE FROM member WHERE id = '#{id}';"
        )
        status 200
    end

    delete '/device/:id' do |id|
        delete_entry(
            "DELETE FROM device_muscle WHERE device_id = '#{id}';
            DELETE FROM location_device WHERE device_id = '#{id}';
            DELETE FROM exercise WHERE device_id = '#{id}';

            DELETE FROM device WHERE id = '#{id}';"
        )
        status 200
    end
end

