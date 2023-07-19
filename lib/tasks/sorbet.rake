# typed: strict
# frozen_string_literal: true

# Add Sorbet support
# https://sorbet.org/docs/faq#does-sorbet-work-with-rake-and-rakefiles
extend Rake::DSL # rubocop:disable Style/MixinUsage

namespace :sorbet do
  desc "Typecheck"
  task typecheck: :environment do
    system("bin/spoom tc")
  end

  namespace :update do
    desc "Update Sorbet and Sorbet Rails RBIs."
    task all: :environment do
      system("bin/tapioca gem")
      system("bin/tapioca dsl")
      system("bin/tapioca todo")
    end
  end
end
