# typed: strict
# frozen_string_literal: true

json = T.unsafe(json)
@device = T.let(@device, WebpushDevice)

json.partial!("webpush_devices/device", device: @device)
