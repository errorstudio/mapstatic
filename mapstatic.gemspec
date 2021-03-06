# -*- encoding: utf-8 -*-
# stub: mapstatic 0.0.2 ruby lib

Gem::Specification.new do |s|
  s.name = "mapstatic".freeze
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["James Croft".freeze]
  s.date = "2019-07-01"
  s.email = "james@matchingnotes.com".freeze
  s.executables = ["mapstatic".freeze]
  s.files = ["Gemfile".freeze, "Gemfile.lock".freeze, "bin/mapstatic".freeze, "lib/mapstatic".freeze, "lib/mapstatic.rb".freeze, "lib/mapstatic/cli.rb".freeze, "lib/mapstatic/conversion.rb".freeze, "lib/mapstatic/errors.rb".freeze, "lib/mapstatic/map.rb".freeze, "lib/mapstatic/tile.rb".freeze, "lib/mapstatic/tile_source.rb".freeze, "lib/mapstatic/version.rb".freeze, "spec/fixtures".freeze, "spec/fixtures/maps".freeze, "spec/fixtures/maps/london.png".freeze, "spec/fixtures/maps/thames.png".freeze, "spec/fixtures/vcr_cassettes".freeze, "spec/fixtures/vcr_cassettes/osm-london-fail.yml".freeze, "spec/fixtures/vcr_cassettes/osm-london.yml".freeze, "spec/fixtures/vcr_cassettes/osm-thames.yml".freeze, "spec/models".freeze, "spec/models/map_spec.rb".freeze, "spec/spec_helper.rb".freeze]
  s.homepage = "https://github.com/crofty/mapstatic".freeze
  s.rubygems_version = "3.0.3".freeze
  s.summary = "Static Map Generator".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mini_magick>.freeze, ["~> 4.9"])
      s.add_runtime_dependency(%q<typhoeus>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<thor>.freeze, [">= 0.19.0", "< 2.0"])
      s.add_development_dependency(%q<awesome_print>.freeze, ["< 2.0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3"])
      s.add_development_dependency(%q<vcr>.freeze, ["~> 3"])
      s.add_development_dependency(%q<webmock>.freeze, ["~> 2"])
    else
      s.add_dependency(%q<mini_magick>.freeze, ["~> 4.9"])
      s.add_dependency(%q<typhoeus>.freeze, ["~> 1.3"])
      s.add_dependency(%q<thor>.freeze, [">= 0.19.0", "< 2.0"])
      s.add_dependency(%q<awesome_print>.freeze, ["< 2.0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3"])
      s.add_dependency(%q<vcr>.freeze, ["~> 3"])
      s.add_dependency(%q<webmock>.freeze, ["~> 2"])
    end
  else
    s.add_dependency(%q<mini_magick>.freeze, ["~> 4.9"])
    s.add_dependency(%q<typhoeus>.freeze, ["~> 1.3"])
    s.add_dependency(%q<thor>.freeze, [">= 0.19.0", "< 2.0"])
    s.add_dependency(%q<awesome_print>.freeze, ["< 2.0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3"])
    s.add_dependency(%q<vcr>.freeze, ["~> 3"])
    s.add_dependency(%q<webmock>.freeze, ["~> 2"])
  end
end
