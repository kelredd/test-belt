module TestBelt::Matchers
  module HaveFiles

    def self.included(receiver)
      receiver.send(:extend, ClassMethods)
    end

    module ClassMethods
      def have_files(*files)
        files.collect do |file|
          Matcher.new(file)
        end
      end
      alias_method :have_file, :have_files
      alias_method :have_directories, :have_files
      alias_method :have_directory, :have_files
    end

    class Matcher < ::TestBelt::Matchers::Base
      def initialize(file_path)
        @file_path = file_path
      end

      def desc
        "have the file path '#{@file_path}'"
      end

      def test
        using(@file_path) do |path|
          assert File.exists?(path), "'#{path}' does not exist"
        end
      end
    end

  end
end