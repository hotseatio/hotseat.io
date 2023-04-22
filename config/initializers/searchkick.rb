# typed: strict
# frozen_string_literal: true

Searchkick.client_type = if ENV.fetch("SEARCH_CLIENT", nil) == "elasticsearch" || T.cast(Rails.env, ActiveSupport::EnvironmentInquirer).production?
                           :elasticsearch
                         else
                           :opensearch
                         end
