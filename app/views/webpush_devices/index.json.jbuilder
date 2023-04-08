# typed: strict
# frozen_string_literal: true

json = T.unsafe(json)
@webpush_devices = T.let(@webpush_devices, WebpushDevice::RelationType)

json.array!(@webpush_devices, partial: "webpush_devices/device", as: :device)
