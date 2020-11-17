# frozen_string_literal: true

module Backup
  class Database
    include Backup::Helper
    attr_reader :config

    def initialize
      @config = YAML.load(ERB.new(File.read(Rails.root.join('config/database.yml'))).result)[Rails.env] # rubocop:disable Security/YAMLLoad
      {
        'username': 'PGUSER',
        'host': 'PGHOST',
        'port': 'PGPORT',
        'password': 'PGPASSWORD'
      }.each { |opt, arg| ENV[arg] = config[opt.to_s].to_s if config[opt.to_s] }
    end

    def dump
      compress_rd, compress_wr = IO.pipe
      compress_pid = spawn('gzip -c -1', in: compress_rd, out: ["#{backup_path}/#{dump_file}", 'w', 00600])
      compress_rd.close

      dump_pid = Process.spawn('pg_dump', '--clean', '--if-exists', config['database'], out: compress_wr)
      compress_wr.close

      success = [compress_pid, dump_pid].all? do |pid|
        Process.waitpid(pid)
        $?.success?
      end

      raise Backup::Error unless success
    end

    private

    def dump_file
      @dump_file ||= "#{Time.zone.now.strftime('%s_%Y_%m_%d')}_#{NetAM::VERSION}.sql.gz"
    end
  end
end
