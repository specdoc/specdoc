puts "Specdoc Enabled"
RSpec.configure do |c|
  c.alias_example_group_to :specdoc_request, {:type => :request, :specdoc_request => true}

  RSpec.configure do |config|
    config.before(:suite) do
      Dir.mkdir(api_docs_folder_path) unless Dir.exist?(api_docs_folder_path)

      Dir.glob(File.join(api_docs_folder_path, '*_blueprint.md')).each do |f|
        File.delete(f)
      end
    end

    config.after(:each, specdoc_request: true) do |example|
      Specdoc::BlueprintTranslator.instance.record_example(example, request, response)
    end

    config.after(:suite) do
      puts "Writing API Blueprint to #{api_docs_folder_path}"
      Specdoc::BlueprintTranslator.instance.end

      append = -> (handle, file) { handle.puts File.read(File.join(api_docs_folder_path, file)) }

      File.open(File.join(api_docs_folder_path, 'apiary.apib'), 'wb') do |apiary|
        append.call(apiary, 'introduction.md')

        Dir[File.join(api_docs_folder_path, '*_blueprint.md')].each do |file|
          header = file.gsub('_blueprint.md', '_header.md')

          if File.exist? header
            append.call(apiary, File.basename(header))
          else
            apiary.puts "# Group #{(File.basename(file, '_blueprint.md')).titleize}"
          end

          append.call(apiary, File.basename(file))
        end
      end
    end
  end

  def api_docs_folder_path
    return File.join(Rails.root, '/doc/', '/api_docs/') if defined? Rails

    File.join(File.expand_path('.'), '/api_docs/')
  end
end
