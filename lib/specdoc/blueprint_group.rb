module Specdoc
  class BlueprintGroup
    attr_accessor :name, :resources

    def initialize(name)
      @name = name
      @resources = {}
    end

    def to_s
      return unless @resources.any?
      @resources.values.map(&:to_s).join
    end

    def file_path
      file_name = @name.tr(' ', '').underscore
      "#{api_docs_folder_path}#{file_name}_blueprint.md"
    end
  end
end
