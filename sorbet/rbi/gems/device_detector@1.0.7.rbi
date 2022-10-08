# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `device_detector` gem.
# Please instead update this file by running `bin/tapioca gem device_detector`.

# source://device_detector-1.0.7/lib/device_detector/version.rb:3
class DeviceDetector
  # @return [DeviceDetector] a new instance of DeviceDetector
  #
  # source://device_detector-1.0.7/lib/device_detector.rb:21
  def initialize(user_agent); end

  # @return [Boolean]
  #
  # source://device_detector-1.0.7/lib/device_detector.rb:142
  def bot?; end

  # source://device_detector-1.0.7/lib/device_detector.rb:146
  def bot_name; end

  # source://device_detector-1.0.7/lib/device_detector.rb:49
  def device_brand; end

  # source://device_detector-1.0.7/lib/device_detector.rb:45
  def device_name; end

  # source://device_detector-1.0.7/lib/device_detector.rb:56
  def device_type; end

  # source://device_detector-1.0.7/lib/device_detector.rb:29
  def full_version; end

  # @return [Boolean]
  #
  # source://device_detector-1.0.7/lib/device_detector.rb:138
  def known?; end

  # source://device_detector-1.0.7/lib/device_detector.rb:25
  def name; end

  # source://device_detector-1.0.7/lib/device_detector.rb:33
  def os_family; end

  # source://device_detector-1.0.7/lib/device_detector.rb:41
  def os_full_version; end

  # source://device_detector-1.0.7/lib/device_detector.rb:37
  def os_name; end

  # Returns the value of attribute user_agent.
  #
  # source://device_detector-1.0.7/lib/device_detector.rb:19
  def user_agent; end

  private

  # @return [Boolean]
  #
  # source://device_detector-1.0.7/lib/device_detector.rb:197
  def android_mobile_fragment?; end

  # @return [Boolean]
  #
  # source://device_detector-1.0.7/lib/device_detector.rb:193
  def android_tablet_fragment?; end

  # source://device_detector-1.0.7/lib/device_detector.rb:177
  def bot; end

  # source://device_detector-1.0.7/lib/device_detector.rb:239
  def build_regex(src); end

  # source://device_detector-1.0.7/lib/device_detector.rb:181
  def client; end

  # @return [Boolean]
  #
  # source://device_detector-1.0.7/lib/device_detector.rb:230
  def desktop?; end

  # @return [Boolean]
  #
  # source://device_detector-1.0.7/lib/device_detector.rb:201
  def desktop_fragment?; end

  # This is a workaround until we support detecting mobile only browsers
  #
  # @return [Boolean]
  #
  # source://device_detector-1.0.7/lib/device_detector.rb:226
  def desktop_string?; end

  # source://device_detector-1.0.7/lib/device_detector.rb:185
  def device; end

  # @return [Boolean]
  #
  # source://device_detector-1.0.7/lib/device_detector.rb:213
  def opera_tablet?; end

  # @return [Boolean]
  #
  # source://device_detector-1.0.7/lib/device_detector.rb:209
  def opera_tv_store?; end

  # source://device_detector-1.0.7/lib/device_detector.rb:189
  def os; end

  # @return [Boolean]
  #
  # source://device_detector-1.0.7/lib/device_detector.rb:217
  def tizen_samsung_tv?; end

  # @return [Boolean]
  #
  # source://device_detector-1.0.7/lib/device_detector.rb:205
  def touch_enabled?; end

  # @return [Boolean]
  #
  # source://device_detector-1.0.7/lib/device_detector.rb:221
  def uses_mobile_browser?; end

  class << self
    # source://device_detector-1.0.7/lib/device_detector.rb:165
    def cache; end

    # source://device_detector-1.0.7/lib/device_detector.rb:161
    def config; end

    # @yield [config]
    #
    # source://device_detector-1.0.7/lib/device_detector.rb:169
    def configure; end
  end
end

# source://device_detector-1.0.7/lib/device_detector/bot.rb:4
class DeviceDetector::Bot < ::DeviceDetector::Parser
  # @return [Boolean]
  #
  # source://device_detector-1.0.7/lib/device_detector/bot.rb:5
  def bot?; end

  private

  # source://device_detector-1.0.7/lib/device_detector/bot.rb:11
  def filenames; end
end

# source://device_detector-1.0.7/lib/device_detector/browser.rb:4
class DeviceDetector::Browser
  class << self
    # @return [Boolean]
    #
    # source://device_detector-1.0.7/lib/device_detector/browser.rb:357
    def mobile_only_browser?(name); end
  end
end

# source://device_detector-1.0.7/lib/device_detector/browser.rb:5
DeviceDetector::Browser::AVAILABLE_BROWSERS = T.let(T.unsafe(nil), Hash)

# source://device_detector-1.0.7/lib/device_detector/browser.rb:343
DeviceDetector::Browser::BROWSER_FULL_TO_SHORT = T.let(T.unsafe(nil), Hash)

# source://device_detector-1.0.7/lib/device_detector/browser.rb:345
DeviceDetector::Browser::MOBILE_ONLY_BROWSERS = T.let(T.unsafe(nil), Set)

# source://device_detector-1.0.7/lib/device_detector/client.rb:4
class DeviceDetector::Client < ::DeviceDetector::Parser
  # @return [Boolean]
  #
  # source://device_detector-1.0.7/lib/device_detector/client.rb:9
  def browser?; end

  # @return [Boolean]
  #
  # source://device_detector-1.0.7/lib/device_detector/client.rb:5
  def known?; end

  # @return [Boolean]
  #
  # source://device_detector-1.0.7/lib/device_detector/client.rb:13
  def mobile_only_browser?; end

  private

  # source://device_detector-1.0.7/lib/device_detector/client.rb:19
  def filenames; end
end

# source://device_detector-1.0.7/lib/device_detector/device.rb:5
class DeviceDetector::Device < ::DeviceDetector::Parser
  # source://device_detector-1.0.7/lib/device_detector/device.rb:1220
  def brand; end

  # @return [Boolean]
  #
  # source://device_detector-1.0.7/lib/device_detector/device.rb:1204
  def known?; end

  # source://device_detector-1.0.7/lib/device_detector/device.rb:1208
  def name; end

  # source://device_detector-1.0.7/lib/device_detector/device.rb:1212
  def type; end

  private

  # The order of files needs to be the same as the order of device
  # parser classes used in the piwik project.
  #
  # source://device_detector-1.0.7/lib/device_detector/device.rb:1228
  def filenames; end

  # @return [Boolean]
  #
  # source://device_detector-1.0.7/lib/device_detector/device.rb:1281
  def hbbtv?; end

  # source://device_detector-1.0.7/lib/device_detector/device.rb:1241
  def matching_regex; end

  # source://device_detector-1.0.7/lib/device_detector/device.rb:1303
  def parse_regexes(path, raw_regexes); end

  # Finds the first match of the string in a list of regexes.
  # Handles exception with special characters caused by bug in Ruby regex
  #
  # @param user_agent [String] User Agent string
  # @param regex_list [Array<Regex>] List of regexes
  # @return [MatchData, nil] MatchData if string matches any regexp, nil otherwise
  #
  # source://device_detector-1.0.7/lib/device_detector/device.rb:1270
  def regex_find(user_agent, regex_list); end

  # source://device_detector-1.0.7/lib/device_detector/device.rb:1291
  def regexes_for_hbbtv; end

  # source://device_detector-1.0.7/lib/device_detector/device.rb:1295
  def regexes_for_shelltv; end

  # source://device_detector-1.0.7/lib/device_detector/device.rb:1299
  def regexes_other; end

  # @return [Boolean]
  #
  # source://device_detector-1.0.7/lib/device_detector/device.rb:1286
  def shelltv?; end
end

# source://device_detector-1.0.7/lib/device_detector/device.rb:23
DeviceDetector::Device::DEVICE_BRANDS = T.let(T.unsafe(nil), Hash)

# order is relevant for testing with fixtures
#
# source://device_detector-1.0.7/lib/device_detector/device.rb:6
DeviceDetector::Device::DEVICE_NAMES = T.let(T.unsafe(nil), Array)

# source://device_detector-1.0.7/lib/device_detector/memory_cache.rb:4
class DeviceDetector::MemoryCache
  # @return [MemoryCache] a new instance of MemoryCache
  #
  # source://device_detector-1.0.7/lib/device_detector/memory_cache.rb:11
  def initialize(config); end

  # Returns the value of attribute data.
  #
  # source://device_detector-1.0.7/lib/device_detector/memory_cache.rb:8
  def data; end

  # source://device_detector-1.0.7/lib/device_detector/memory_cache.rb:27
  def get(key); end

  # source://device_detector-1.0.7/lib/device_detector/memory_cache.rb:32
  def get_or_set(key, value = T.unsafe(nil)); end

  # Returns the value of attribute max_keys.
  #
  # source://device_detector-1.0.7/lib/device_detector/memory_cache.rb:8
  def max_keys; end

  # source://device_detector-1.0.7/lib/device_detector/memory_cache.rb:17
  def set(key, value); end

  private

  # source://device_detector-1.0.7/lib/device_detector/memory_cache.rb:44
  def get_hit(key); end

  # Returns the value of attribute lock.
  #
  # source://device_detector-1.0.7/lib/device_detector/memory_cache.rb:8
  def lock; end

  # source://device_detector-1.0.7/lib/device_detector/memory_cache.rb:51
  def purge_cache; end
end

# source://device_detector-1.0.7/lib/device_detector/memory_cache.rb:5
DeviceDetector::MemoryCache::DEFAULT_MAX_KEYS = T.let(T.unsafe(nil), Integer)

# source://device_detector-1.0.7/lib/device_detector/memory_cache.rb:6
DeviceDetector::MemoryCache::STORES_NIL_VALUE = T.let(T.unsafe(nil), Symbol)

# source://device_detector-1.0.7/lib/device_detector/metadata_extractor.rb:4
class DeviceDetector::MetadataExtractor < ::Struct
  # source://device_detector-1.0.7/lib/device_detector/metadata_extractor.rb:5
  def call; end

  private

  # source://device_detector-1.0.7/lib/device_detector/metadata_extractor.rb:16
  def extract_metadata; end

  # @raise [NotImplementedError]
  #
  # source://device_detector-1.0.7/lib/device_detector/metadata_extractor.rb:11
  def metadata_string; end

  # source://device_detector-1.0.7/lib/device_detector/metadata_extractor.rb:24
  def regex; end
end

# source://device_detector-1.0.7/lib/device_detector/model_extractor.rb:4
class DeviceDetector::ModelExtractor < ::DeviceDetector::MetadataExtractor
  # source://device_detector-1.0.7/lib/device_detector/model_extractor.rb:5
  def call; end

  private

  # source://device_detector-1.0.7/lib/device_detector/model_extractor.rb:16
  def metadata_string; end

  # source://device_detector-1.0.7/lib/device_detector/model_extractor.rb:20
  def regex; end
end

# source://device_detector-1.0.7/lib/device_detector/name_extractor.rb:4
class DeviceDetector::NameExtractor < ::DeviceDetector::MetadataExtractor
  # source://device_detector-1.0.7/lib/device_detector/name_extractor.rb:5
  def call; end

  private

  # source://device_detector-1.0.7/lib/device_detector/name_extractor.rb:15
  def metadata_string; end
end

# source://device_detector-1.0.7/lib/device_detector/os.rb:6
class DeviceDetector::OS < ::DeviceDetector::Parser
  # @return [Boolean]
  #
  # source://device_detector-1.0.7/lib/device_detector/os.rb:19
  def desktop?; end

  # source://device_detector-1.0.7/lib/device_detector/os.rb:15
  def family; end

  # source://device_detector-1.0.7/lib/device_detector/os.rb:23
  def full_version; end

  # source://device_detector-1.0.7/lib/device_detector/os.rb:7
  def name; end

  # source://device_detector-1.0.7/lib/device_detector/os.rb:11
  def short_name; end

  private

  # source://device_detector-1.0.7/lib/device_detector/os.rb:195
  def filenames; end

  # source://device_detector-1.0.7/lib/device_detector/os.rb:30
  def os_info; end
end

# source://device_detector-1.0.7/lib/device_detector/os.rb:42
DeviceDetector::OS::DESKTOP_OSS = T.let(T.unsafe(nil), Set)

# source://device_detector-1.0.7/lib/device_detector/os.rb:156
DeviceDetector::OS::DOWNCASED_OPERATING_SYSTEMS = T.let(T.unsafe(nil), Hash)

# source://device_detector-1.0.7/lib/device_detector/os.rb:191
DeviceDetector::OS::FAMILY_TO_OS = T.let(T.unsafe(nil), Hash)

# OS short codes mapped to long names
#
# source://device_detector-1.0.7/lib/device_detector/os.rb:49
DeviceDetector::OS::OPERATING_SYSTEMS = T.let(T.unsafe(nil), Hash)

# source://device_detector-1.0.7/lib/device_detector/os.rb:160
DeviceDetector::OS::OS_FAMILIES = T.let(T.unsafe(nil), Hash)

# source://device_detector-1.0.7/lib/device_detector/parser.rb:4
class DeviceDetector::Parser
  # @return [Parser] a new instance of Parser
  #
  # source://device_detector-1.0.7/lib/device_detector/parser.rb:10
  def initialize(user_agent); end

  # source://device_detector-1.0.7/lib/device_detector/parser.rb:22
  def full_version; end

  # source://device_detector-1.0.7/lib/device_detector/parser.rb:16
  def name; end

  # Returns the value of attribute user_agent.
  #
  # source://device_detector-1.0.7/lib/device_detector/parser.rb:14
  def user_agent; end

  private

  # source://device_detector-1.0.7/lib/device_detector/parser.rb:87
  def build_regex(src); end

  # @raise [NotImplementedError]
  #
  # source://device_detector-1.0.7/lib/device_detector/parser.rb:44
  def filenames; end

  # source://device_detector-1.0.7/lib/device_detector/parser.rb:48
  def filepaths; end

  # source://device_detector-1.0.7/lib/device_detector/parser.rb:91
  def from_cache(key); end

  # source://device_detector-1.0.7/lib/device_detector/parser.rb:60
  def load_regexes(file_paths); end

  # source://device_detector-1.0.7/lib/device_detector/parser.rb:34
  def matching_regex; end

  # source://device_detector-1.0.7/lib/device_detector/parser.rb:77
  def parse_regexes(path, raw_regexes); end

  # source://device_detector-1.0.7/lib/device_detector/parser.rb:30
  def regex_meta; end

  # source://device_detector-1.0.7/lib/device_detector/parser.rb:40
  def regexes; end

  # source://device_detector-1.0.7/lib/device_detector/parser.rb:54
  def regexes_for(file_paths); end

  # source://device_detector-1.0.7/lib/device_detector/parser.rb:64
  def symbolize_keys!(object); end
end

# source://device_detector-1.0.7/lib/device_detector/parser.rb:7
DeviceDetector::Parser::REGEX_CACHE = T.let(T.unsafe(nil), DeviceDetector::MemoryCache)

# source://device_detector-1.0.7/lib/device_detector/parser.rb:5
DeviceDetector::Parser::ROOT = T.let(T.unsafe(nil), String)

# source://device_detector-1.0.7/lib/device_detector/version.rb:4
DeviceDetector::VERSION = T.let(T.unsafe(nil), String)

# source://device_detector-1.0.7/lib/device_detector/version_extractor.rb:4
class DeviceDetector::VersionExtractor < ::DeviceDetector::MetadataExtractor
  # source://device_detector-1.0.7/lib/device_detector/version_extractor.rb:10
  def call; end

  private

  # source://device_detector-1.0.7/lib/device_detector/version_extractor.rb:35
  def metadata_string; end

  # source://device_detector-1.0.7/lib/device_detector/version_extractor.rb:20
  def os_version_by_regexes; end
end

# source://device_detector-1.0.7/lib/device_detector/version_extractor.rb:5
DeviceDetector::VersionExtractor::MAJOR_VERSION_2 = T.let(T.unsafe(nil), Gem::Version)

# source://device_detector-1.0.7/lib/device_detector/version_extractor.rb:6
DeviceDetector::VersionExtractor::MAJOR_VERSION_3 = T.let(T.unsafe(nil), Gem::Version)

# source://device_detector-1.0.7/lib/device_detector/version_extractor.rb:7
DeviceDetector::VersionExtractor::MAJOR_VERSION_4 = T.let(T.unsafe(nil), Gem::Version)

# source://device_detector-1.0.7/lib/device_detector/version_extractor.rb:8
DeviceDetector::VersionExtractor::MAJOR_VERSION_8 = T.let(T.unsafe(nil), Gem::Version)
