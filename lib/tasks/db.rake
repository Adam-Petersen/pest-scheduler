require 'csv'

namespace :db do
  namespace :import do
    desc "Loads Location CSV data into database"
    task :load_csv_data, [:model_name, :filename, :encoding] => :environment do |t, args|
      supported_models = ["Location", "Technician", "WorkOrder"]
      unless supported_models.include? args[:model_name]
        raise "#{args[:model_name]} model not yet supported for CSV intake."
      end

      encoding = args[:encoding].nil? ? "bom|utf-8" : args[:encoding]
      file_data = CSV.read(args[:filename], :encoding => encoding)
      record_data = []

      file_data.drop(1).each do |line|
        line_data = {}
        line.each_with_index do |val, ind|
          line_data[file_data[0][ind].to_sym] = val
        end
        if args[:model_name] == "WorkOrder"
          line_data[:time] = DateTime.strptime(line_data[:time], "%D %R")
        end
        record_data.push(line_data)
      end

      case args[:model_name]
      when "Location"
        loc = Location.create(record_data)
      when "Technician"
        tech = Technician.create(record_data)
      when "WorkOrder"
        date = WorkOrder.create(record_data)
      else
        puts "Error: #{args[:model_name]} not yet supported for CSV intake."
      end
    end
  end

  namespace :delete do
    desc "Deletes all records for given model"
    task :delete_records, [:model_name] => :environment do |t, args|
      supported_models = ["Location", "Technician", "WorkOrder"]
      unless supported_models.include? args[:model_name]
        raise "#{args[:model_name]} model not yet supported for automated deletion."
      end

      case args[:model_name]
      when "Location"
        Location.destroy_all
      when "Technician"
        Technician.destroy_all
      when "WorkOrder"
        WorkOrder.destroy_all
      else
        puts "Error: #{args[:model_name]} not yet supported for automated deletion."
      end
    end
  end
end
