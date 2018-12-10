require 'rake'
require 'rake/tasklib'
require 'fileutils'

module Rake
  class ErrorPageAssetsTask < Rake::TaskLib
    attr_accessor :name

    def initialize(name = :error_pages, task_dependencies = [])
      self.name = name

      yield self if block_given?

      define
    end

    def log msg
      # try to log like Sprockets even though their stuff is all private
      STDERR.puts msg
      Rails.logger.info(msg) if Rails.respond_to?(:logger) && Rails.logger
    end

    def process_error_files
      config = Rails.configuration
      pattern = File.join(config.paths['public'].first, config.assets.prefix, "[0-9][0-9][0-9]*.html")

      groups = Dir[pattern].group_by { |s| File.basename(s)[0..2] }
      groups.sort_by { |base,_| base }.each do |base, group|
        src = group.sort_by { |f| File.mtime(f) }.last
        dst = Rails.public_path.join("#{base}.html").to_s
        yield src, dst
      end
    end

    def define
      namespace :assets do
        namespace :precompile do
          desc 'Copy the newest error page assets into /public'
          task name do
            process_error_files do |src, dst|
              log "copy #{src} to #{dst}"
              FileUtils.cp src, dst
            end
          end
        end

        namespace :clobber do
          desc 'Remove the error page assets in /public'
          task name do
            process_error_files do |src,dst|
              log "clobber #{dst}"
              FileUtils.rm_f dst
            end
          end
        end
      end
    end
  end
end