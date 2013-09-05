module GemCheck
  class Gem
    attr_accessor :name, :local_version

    def initialize(name, version)
      @name = name
      @local_version = version
    end

    def get_remote_version
      response = Faraday.get "https://rubygems.org/api/v1/versions/#{name}.json"
      case response.status
      when 200
        pack = JSON.parse(response.body)
        @remote_version = pack[0]['number']
      when 404
      end
    end

    def to_s
      puts "#{name} : #{local_version} (local) vs #{remote_version} (remote)"
    end

    def remote_version
      @remote_version ||= get_remote_version
    end

    def outdated?
      !local_version.eql?(remote_version)
    end

    def self.list
      Bundler.load.specs.collect do |g|
        GemCheck::Gem.new(g.name, g.version.to_s)
      end
    end

    def self.outdated
      GemCheck::Gem.list.select { |g| g.outdated? }
    end

    def self.report
      GemCheck::Gem.outdated.collect do |d|
        d.to_s
      end.uniq
    end
  end
end
