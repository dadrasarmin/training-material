# frozen_string_literal: true

# Plugin to add environment variables to the `site` object in Liquid templates
require 'date'
require 'time'
require './_plugins/gtn/scholar'
require './_plugins/gtn/git'

module Jekyll
  module Generators
    # This module contains a generator for adding environment variables to the `site` object in Liquid templates
    # TODO: definitely could be a hook instead of a generator
    class EnvironmentVariablesGenerator < Generator
      ##
      # Environment variables are added to the `site` object in Liquid templates.
      # Here we add the following:
      #  - `site.config['git_revision']` - the current git revision
      #  - `site.config['git_tags']` - an array of all git tags
      #  - `site.config['git_tags_recent']` - an array of the 3 most recent git tags
      #  - `site.config['gtn_fork']` - the fork of the GTN repo
      #  - `site.config['age']` - the age of the site in years
      def generate(site)
        # Add other environment variables to `site.config` here...
        Gtn::Scholar.load_bib(site)
        site.config.update(Gtn::Git.discover)

        site.data['build'] = {
          'today' => Date.today,
          'now' => Time.now,
          'jekyll' => {
            'version' => Jekyll::VERSION,
            'environment' => Jekyll.env,
          }
        }
      end
    end
  end
end
