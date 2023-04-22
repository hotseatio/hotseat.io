# typed: strict
# frozen_string_literal: true

module Rack
  class Attack
    ### Throttle Spammy Clients ###

    # If any single client IP is making tons of requests, then they're
    # probably malicious or a poorly-configured scraper. Either way, they
    # don't deserve to hog all of the app server's CPU. Cut them off!
    #
    # Note: If you're serving assets through rack, those requests may be
    # counted by rack-attack and this throttle may be activated too
    # quickly. If so, enable the condition to exclude them from tracking.

    # Throttle all requests by IP (60 requests/minute)
    #
    # Key: "rack::attack:#{Time.now.to_i/:period}:req/ip:#{req.ip}"
    throttle("req/ip", limit: 300, period: 5.minutes) do |req|
      req.ip unless req.path.start_with?("/packs", "/favicon", "/hotcount", "/enrollment_notifications")
    end

    # Block suspicious requests for '/etc/password' or wordpress specific paths.
    # After 3 blocked requests in 10 minutes, block all requests from that IP for 1 day.
    blocklist("fail2ban pentesters") do |req|
      # `filter` returns truthy value if request fails, or if it's from a previously banned IP
      # so the request is blocked
      Fail2Ban.filter("pentesters-#{req.ip}", maxretry: 4, findtime: 10.minutes, bantime: 1.day) do
        # The count for the IP is incremented if the return value is truthy
        CGI.unescape(req.query_string).include?("/etc/passwd") ||
          req.path.include?("/etc/passwd") ||
          req.path.include?("wp-admin") ||
          req.path.include?("wp-login") ||
          req.path.include?("wp-includes") ||
          req.path.include?("wlwmanifest.xml") ||
          req.path.include?("xmlrpc.php") ||
          req.path.include?("phpunit") ||
          req.path.include?("vendor/.env") ||
          req.path.include?("aws.yml") ||
          req.path.include?("sellers.json")
      end
    end
  end
end
