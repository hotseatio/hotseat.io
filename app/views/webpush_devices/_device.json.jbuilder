# typed: strict
# frozen_string_literal: true

device = T.cast(device, WebpushDevice)
json = T.unsafe(json)

json.id(device.id)
json.browser(device.browser)
json.os(device.operating_system)
