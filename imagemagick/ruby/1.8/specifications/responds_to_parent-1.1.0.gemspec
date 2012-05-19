# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "responds_to_parent"
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mark Catley"]
  s.date = "2012-05-09"
  s.homepage = "http://github.com/markcatley/responds_to_parent"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "[Rails] Adds 'responds_to_parent' to your controller torespond to the parent document of your page.Make Ajaxy file uploads by posting the form to a hiddeniframe, and respond with RJS to the parent window."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
